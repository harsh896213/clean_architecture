import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/message.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isSendButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateSendButtonState);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSendButtonState);
    _controller.dispose();
    super.dispose();
  }

  void _updateSendButtonState() {
    setState(() {
      _isSendButtonEnabled = _controller.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isSendButtonEnabled
                ? () {
              final message = Message(
                id: DateTime.now().toString(),
                chatId: 'chat1',
                senderId: '1',
                content: _controller.text,
                timestamp: DateTime.now(),
              );
              context.read<ChatBloc>().add(SendMessage(message));
              _controller.clear();
            }
                : null,
          ),
        ],
      ),
    );
  }
}