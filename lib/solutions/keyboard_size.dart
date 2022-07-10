import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

import '../content.dart';

class SolutionKeyboardSize extends StatefulWidget {
  const SolutionKeyboardSize({Key? key}) : super(key: key);

  @override
  State<SolutionKeyboardSize> createState() => _SolutionKeyboardSizeState();
}

class _SolutionKeyboardSizeState extends State<SolutionKeyboardSize> {
  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: Builder(
        builder: (context) {
          return Consumer<ScreenHeight>(
            builder: (context, res, child) => ChatScreen(
              title: 'flutter_keyboard_size',
              keyboardHeight: res.keyboardHeight,
              isKeyboardOpen: res.isOpen,
            ),
          );
        }
      ),
    );
  }
}
