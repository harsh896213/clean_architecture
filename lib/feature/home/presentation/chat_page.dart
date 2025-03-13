import 'dart:async';

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  StreamController streamController = StreamController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text("Chat Page"),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamController.close();
    super.dispose();
  }
}
