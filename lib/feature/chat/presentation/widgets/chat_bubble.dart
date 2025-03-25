import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/message.dart';

class ChatMessageBubble extends StatelessWidget {
  final Message message;
  final bool showAvatar;

  const ChatMessageBubble({
    Key? key,
    required this.message,
    this.showAvatar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFromMe = message.senderId == '1';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isFromMe ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: isFromMe ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (isFromMe)
            const SizedBox(width: 8),
        ],
      ),
    );
  }
}
