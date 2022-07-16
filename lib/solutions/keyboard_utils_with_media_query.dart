import 'dart:async';
import 'dart:math' hide log;
import 'dart:developer';

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
          log('willHideKeyboard: ${_keyboardUtils.keyboardHeight}');
          _streamController.sink.add(_keyboardUtils.keyboardHeight);
        }, willShowKeyboard: (double keyboardHeight) {
          log('willShowKeyboard: $keyboardHeight');
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

class SolutionKeyboardUtilsWithMediaQuery extends StatefulWidget {
  const SolutionKeyboardUtilsWithMediaQuery({Key? key}) : super(key: key);

  @override
  State<SolutionKeyboardUtilsWithMediaQuery> createState() => _SolutionKeyboardUtilsWithMediaQueryState();
}

class _SolutionKeyboardUtilsWithMediaQueryState extends State<SolutionKeyboardUtilsWithMediaQuery> {
  final KeyboardBloc _bloc = KeyboardBloc();
  double _keyboardHeight = 0.0;

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
  void didChangeDependencies(){
    super.didChangeDependencies();
    _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    log('didChangeDependencies: $_keyboardHeight');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        final height_1 = _bloc.keyboardUtils.keyboardHeight;
        final height_2 = _keyboardHeight;
        log('----------------');
        log('height 1: $height_1');
        log('height 2: $height_2');
        return ChatScreen(
          title: 'keyboard_utils with media query',
          keyboardHeight: max(height_1, height_2),
          isKeyboardOpen: _bloc.keyboardUtils.isKeyboardOpen,
        );
      },
    );
  }
}
