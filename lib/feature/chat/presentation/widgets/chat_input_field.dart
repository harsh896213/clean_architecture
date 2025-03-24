import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final Function(String) onSend;

  const ChatInputField({
    super.key,
    required this.onSend,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Attachment',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAttachmentOption(
                      icon: Icons.photo,
                      color: Colors.green,
                      label: 'Photo/Video',
                      onTap: () {
                        Navigator.of(context).pop();
                        // Handle photo/video attachment
                      },
                    ),
                    _buildAttachmentOption(
                      icon: Icons.camera_alt,
                      color: Colors.blue,
                      label: 'Camera',
                      onTap: () {
                        Navigator.of(context).pop();
                        // Handle camera attachment
                      },
                    ),
                    _buildAttachmentOption(
                      icon: Icons.description,
                      color: Colors.orange,
                      label: 'Document',
                      onTap: () {
                        Navigator.of(context).pop();
                        // Handle document attachment
                      },
                    ),
                    _buildAttachmentOption(
                      icon: Icons.mic,
                      color: Colors.red,
                      label: 'Voice Message',
                      onTap: () {
                        Navigator.of(context).pop();
                        // Handle voice message attachment
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.grey),
            onPressed: _showAttachmentOptions,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
                minLines: 1,
                maxLines: 5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.sentiment_satisfied_alt, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.grey),
            onPressed: () {
              if (_controller.text.trim().isNotEmpty) {
                widget.onSend(_controller.text.trim());
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}