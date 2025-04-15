import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String id;

  const ProfileHeader({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: const Icon(Icons.person, size: 40, color: Colors.grey),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // Name
        Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        // ID
        Text(
          id,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}