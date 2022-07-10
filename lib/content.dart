import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String title;
  final double keyboardHeight;
  final bool isKeyboardOpen;

  const ChatScreen({
    required this.title,
    required this.keyboardHeight,
    required this.isKeyboardOpen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(title),),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const TextField(),
                const TextField(
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),
                Text('keyboardHeight: $keyboardHeight'),
                Text('isKeyBoardOpen: $isKeyboardOpen'),
                Expanded(child: Container()),
                Container(
                  height: 20.0,
                  color: Colors.green,
                  child: const Text('this green should be always no top of the keyboard'),
                ),
              ],
            ),
          ),
          Offstage(
            offstage: !isKeyboardOpen,
            child: SizedBox(
              height: keyboardHeight,
              child: Container(
                color: Colors.red,
                child: const Text('this should be hidden by the keyboard'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
