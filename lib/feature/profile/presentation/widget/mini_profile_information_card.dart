import 'package:flutter/material.dart';
import 'package:pva/core/theme/app_pallete.dart';

class MiniProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String patientId;
  final String gender;
  final int age;

  const MiniProfileCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.patientId,
    required this.gender,
    required this.age,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppPallete.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Profile image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 48,
                    height: 48,
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, size: 24, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Text(
                        'Patient ID: $patientId',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$gender ($age Years)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}