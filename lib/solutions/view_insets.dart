import 'dart:async';

import 'package:flutter/material.dart';

import '../content.dart';

class SolutionViewInsets extends StatefulWidget {
  const SolutionViewInsets({Key? key}) : super(key: key);

  @override
  State<SolutionViewInsets> createState() => _SolutionViewInsetsState();
}

class _SolutionViewInsetsState extends State<SolutionViewInsets> {
  late final Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        print('rebuild');
      });
    });
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardHeight = EdgeInsets.fromWindowPadding(WidgetsBinding.instance.window.viewInsets,WidgetsBinding.instance.window.devicePixelRatio).bottom;
    return ChatScreen(
      title: 'ViewInsets',
      keyboardHeight: keyBoardHeight,
      isKeyboardOpen: keyBoardHeight > 100.0,
    );
  }
}
