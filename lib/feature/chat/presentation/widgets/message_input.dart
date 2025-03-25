import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/message.dart';
import '../bloc/chat/chat_bloc.dart';
import '../bloc/chat/chat_event.dart';
import '../bloc/chat/chat_state.dart';

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
    final isEnabled = _controller.text.trim().isNotEmpty;
    if (_isSendButtonEnabled != isEnabled) {
      setState(() {
        _isSendButtonEnabled = isEnabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              minLines: 1,
              maxLines: 4,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isSendButtonEnabled
                ? () {
              // Get the current state of the bloc to extract necessary information
              final currentState = context.read<ChatBloc>().state;
              String chatId;

              // Extract the chat ID from the current state
              if (currentState is MessagesLoaded) {
                chatId = currentState.chatId;
              } else {
                // Fallback - this should not happen in normal operation
                print('Warning: Unable to determine chat ID from state');
                return;
              }

              final message = Message(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                chatId: chatId,
                // Use a consistent user ID or get it from your auth system
                senderId: 'currentUserId', // Replace with actual user ID from your auth system
                content: _controller.text.trim(),
                timestamp: DateTime.now(),
              );

              context.read<ChatBloc>().add(SendMessage(message));
              _controller.clear();
            }
                : null,
            color: _isSendButtonEnabled
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor,
          ),
        ],
      ),
    );
  }
}