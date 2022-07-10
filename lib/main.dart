import 'package:flutter/material.dart';

import 'solutions/flutter_persistent_keyboard_height.dart';
import 'solutions/keyboard_size.dart';
import 'solutions/keyboard_utils.dart';
import 'solutions/view_insets.dart';
import 'solutions/keyboard_utils_with_workaround.dart';
import 'solutions/media_query.dart';

void main() => runApp(const MyApp());

const DATA = [
  'MediaQuery'
  'view insets',
  'keyboard_utils',
  'flutter_persistent_keyboard_height',
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  void navigate(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('keyboard height test'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('MediaQuery'),
            onTap: () => navigate(context, const SolutionMediaQuery()),
          ),
          ListTile(
            title: const Text('ViewInsets'),
            onTap: () => navigate(context, const SolutionViewInsets()),
          ),
          ListTile(
            title: const Text('keyboard_utils'),
            onTap: () => navigate(context, const SolutionKeyboardUtils()),
          ),
          ListTile(
            title: const Text('keyboard_utils with workaround'),
            onTap: () => navigate(context, const SolutionKeyboardUtilsWithWorkaround()),
          ),
          ListTile(
            title: const Text('flutter_persistent_keyboard_height'),
            onTap: () => navigate(context, const SolutionPersistentKeyboardHeight()),
          ),
          ListTile(
            title: const Text('flutter_keyboard_size'),
            onTap: () => navigate(context, const SolutionKeyboardSize()),
          ),
        ],
      ),
    );
  }
}
