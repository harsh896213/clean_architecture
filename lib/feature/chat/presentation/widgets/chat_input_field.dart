import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/widgets/custom_bottomsheet.dart';
import 'package:pva/feature/chat/presentation/widgets/attachment_bottomsheet.dart';

import '../../../../core/widgets/custom_input_field.dart';

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
  bool _showEmojiPicker = false;

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
      if (!_showEmojiPicker) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    });
  }

  void _onEmojiSelected(Category? category, Emoji emoji) {
    print("Emoji selected: ${emoji.emoji}");

    setState(() {
      _controller.text += emoji.emoji;
    });

    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );

  }

  // void _showAttachmentOptions() {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 200,
  //         padding: const EdgeInsets.symmetric(vertical: 20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 20),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text(
  //                     'Add Attachment',
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   IconButton(
  //                     icon: const Icon(Icons.close),
  //                     onPressed: () => Navigator.of(context).pop(),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //             Expanded(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   _buildAttachmentOption(
  //                     icon: Icons.photo,
  //                     color: Colors.green,
  //                     label: 'Photo/Video',
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                       // Handle photo/video attachment
  //                     },
  //                   ),
  //                   _buildAttachmentOption(
  //                     icon: Icons.camera_alt,
  //                     color: Colors.blue,
  //                     label: 'Camera',
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                       // Handle camera attachment
  //                     },
  //                   ),
  //                   _buildAttachmentOption(
  //                     icon: Icons.description,
  //                     color: Colors.orange,
  //                     label: 'Document',
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                       // Handle document attachment
  //                     },
  //                   ),
  //                   _buildAttachmentOption(
  //                     icon: Icons.mic,
  //                     color: Colors.red,
  //                     label: 'Voice Message',
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                       // Handle voice message attachment
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.grey),
                  onPressed: () => showDynamicBottomSheet(
                    context: context,
                    child: AttachmentBottomsheet()
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomInputField(
                  controller: _controller,
                  focusNode: _focusNode,
                  hintText: 'Type a message...',
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  borderRadius: BorderRadius.circular(24),
                  backgroundColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    _showEmojiPicker
                        ? Icons.keyboard
                        : Icons.sentiment_satisfied_alt,
                    color: _showEmojiPicker ? Colors.blue : Colors.grey,
                  ),
                  onPressed: _toggleEmojiPicker,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.grey),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      widget.onSend(_controller.text.trim());
                      _controller.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: _showEmojiPicker,
          child: SizedBox(
            height: 250,
            child: EmojiPicker(
              onEmojiSelected: (Category? category, Emoji emoji) {
                _onEmojiSelected(category, emoji);
              },
              config: Config(
                columns: 7,
                emojiSizeMax: 32.0,
                verticalSpacing: 0,
                horizontalSpacing: 0,
                initCategory: Category.RECENT,
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                backspaceColor: Colors.blue,
                recentsLimit: 28,
                noRecents: const Text('No Recents', style: TextStyle(fontSize: 20, color: Colors.black26)),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL,
              ),
            ),
          ),
        ),
      ],
    );
  }
}