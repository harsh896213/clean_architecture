import 'package:flutter/material.dart';

class AttachmentBottomsheet extends StatelessWidget {
  const AttachmentBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildAttachmentOption(
                  icon: Icons.photo,
                  color: Colors.green,
                  label: 'Photo/Video',
                  onTap: () {
                    Navigator.of(context).pop();
                    // Handle photo/video attachment
                  },
                ),
                buildAttachmentOption(
                  icon: Icons.camera_alt,
                  color: Colors.blue,
                  label: 'Camera',
                  onTap: () {
                    Navigator.of(context).pop();
                    // Handle camera attachment
                  },
                ),
                buildAttachmentOption(
                  icon: Icons.description,
                  color: Colors.orange,
                  label: 'Document',
                  onTap: () {
                    Navigator.of(context).pop();
                    // Handle document attachment
                  },
                ),
                buildAttachmentOption(
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
  }
}

Widget buildAttachmentOption({
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
