import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:keyboard_utils/keyboard_listener.dart' as keyboard_listener;

import '../content.dart';

class KeyboardBloc {
  final KeyboardUtils _keyboardUtils = KeyboardUtils();
  final StreamController<double> _streamController = StreamController<double>();
  Stream<double> get stream => _streamController.stream;

  KeyboardUtils get keyboardUtils => _keyboardUtils;

  late int _idKeyboardListener;

  void start() {
    _idKeyboardListener = _keyboardUtils.add(
        listener: keyboard_listener.KeyboardListener(willHideKeyboard: () {
          print('willHideKeyboard: ${_keyboardUtils.keyboardHeight}');
          _streamController.sink.add(_keyboardUtils.keyboardHeight);
        }, willShowKeyboard: (double keyboardHeight) {
          print('willShowKeyboard: $keyboardHeight');
          print('ratio: ${WidgetsBinding.instance.window.devicePixelRatio}');
          print('view padding: ${WidgetsBinding.instance.window.viewPadding}');
          _streamController.sink.add(keyboardHeight);
        }));
  }

  void dispose() {
    _keyboardUtils.unsubscribeListener(subscribingId: _idKeyboardListener);
    if (_keyboardUtils.canCallDispose()) {
      _keyboardUtils.dispose();
    }
    _streamController.close();
  }
}

class SolutionKeyboardUtils extends StatefulWidget {
  const SolutionKeyboardUtils({Key? key}) : super(key: key);

  @override
  State<SolutionKeyboardUtils> createState() => _SolutionKeyboardUtilsState();
}

class _SolutionKeyboardUtilsState extends State<SolutionKeyboardUtils> {
  final KeyboardBloc _bloc = KeyboardBloc();

  @override
  void initState() {
    super.initState();
    _bloc.start();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: _bloc.stream,
      builder: (context, snapshot) => ChatScreen(
        title: 'keyboard_utils',
        keyboardHeight: _bloc.keyboardUtils.keyboardHeight, // TODO BUG
        isKeyboardOpen: _bloc.keyboardUtils.isKeyboardOpen,
      ),
    );
  }
}
