import 'package:flutter/material.dart';
import 'package:pva/core/theme/app_pallete.dart';

class DocumentCard extends StatelessWidget {
  final String title;
  final String fileType;
  final String fileSize;

  const DocumentCard({
    Key? key,
    required this.title,
    required this.fileType,
    required this.fileSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPallete.cardBackground,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFE8DFFF),
              child: Icon(
                Icons.description,
                color: Colors.deepPurple.shade300,
              ),
            ),
            const SizedBox(height: 16),

            // Document title
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // File type and size
            Text(
              fileType,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'File Size: $fileSize',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.download, color: Colors.white, size: 16),
                label: const Text(
                  'Download',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Downloading $title')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}