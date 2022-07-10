
import 'package:flutter/material.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';

import '../content.dart';

class SolutionPersistentKeyboardHeight extends StatefulWidget {
  const SolutionPersistentKeyboardHeight({Key? key}) : super(key: key);

  @override
  State<SolutionPersistentKeyboardHeight> createState() => _SolutionPersistentKeyboardHeightState();
}

class _SolutionPersistentKeyboardHeightState extends State<SolutionPersistentKeyboardHeight> {
  @override
  Widget build(BuildContext context) {
    return PersistentKeyboardHeightProvider(
      child: Builder(
        builder: (context) { // Builder here is necessary for InheritedWidget to work
          return ChatScreen(
            title: 'flutter_persistent_keyboard_height Pub version',
            keyboardHeight: PersistentKeyboardHeight.of(context).keyboardHeight,
            isKeyboardOpen: PersistentKeyboardHeight.of(context).keyboardHeight > 100.0,
          );
        }
      ),
    );
  }
}
