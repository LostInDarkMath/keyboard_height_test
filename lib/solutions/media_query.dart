import 'dart:async';

import 'package:flutter/material.dart';

import '../content.dart';

class SolutionMediaQuery extends StatefulWidget {
  const SolutionMediaQuery({Key? key}) : super(key: key);

  @override
  State<SolutionMediaQuery> createState() => _SolutionMediaQueryState();
}

class _SolutionMediaQueryState extends State<SolutionMediaQuery> {
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
    final keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    return ChatScreen(
      title: 'MediaQuery',
      keyboardHeight: keyBoardHeight,
      isKeyboardOpen: keyBoardHeight > 100.0,
    );
  }
}
