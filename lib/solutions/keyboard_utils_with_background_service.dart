import 'dart:async';
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

class SolutionKeyboardUtilsWithBackgroundService extends StatefulWidget {
  const SolutionKeyboardUtilsWithBackgroundService({Key? key}) : super(key: key);

  @override
  State<SolutionKeyboardUtilsWithBackgroundService> createState() => _SolutionKeyboardUtilsWithBackgroundServiceState();
}

class _SolutionKeyboardUtilsWithBackgroundServiceState extends State<SolutionKeyboardUtilsWithBackgroundService> {
  final KeyboardBloc _bloc = KeyboardBloc();
  double _keyboardHeight = 0.0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _bloc.start();
    log('start timer');
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if(!mounted){
        log('cancel timer');
        timer.cancel();
        return;
      }

      var newHeight = MediaQuery.of(context).viewInsets.bottom;

      if(newHeight == _keyboardHeight){
        return;
      }

      setState(() {
        log('new: $newHeight, old: $_keyboardHeight');
        _keyboardHeight = newHeight;
      });
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        return ChatScreen(
          title: 'keyboard_utils with background service',
          keyboardHeight: _keyboardHeight,
          isKeyboardOpen: _bloc.keyboardUtils.isKeyboardOpen,
        );
      },
    );
  }
}
