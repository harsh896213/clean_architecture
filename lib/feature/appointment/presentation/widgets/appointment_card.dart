import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String time;
  final bool isVirtual;
  final String profilePic;
  final VoidCallback onTap;
  final Color? buttonColor;
  final String buttonText;

  const AppointmentCard({
    Key? key,
    required this.doctorName,
    required this.specialty,
    required this.time,
    required this.isVirtual,
    required this.profilePic,
    required this.onTap,
    this.buttonColor,
    this.buttonText = 'Get Directions',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  profilePic.isNotEmpty ? NetworkImage(profilePic) : null,
                  onBackgroundImageError: (_, __) {},
                  child: profilePic.isEmpty
                      ? const Icon(Icons.person, size: 30, color: Colors.white)
                      : null,
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        specialty.isEmpty ? 'Cardiology' : specialty,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(
                            isVirtual ? Icons.videocam : Icons.location_on,
                            size: 16,
                            color: isVirtual
                                ? Colors.blue[600]
                                : Colors.orange[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isVirtual ? 'Virtual Visit' : 'In-Person Visit',
                            style: context.textTheme.labelMedium?.copyWith(
                              fontSize: 14,
                              color: isVirtual
                                  ? Colors.blue[600]
                                  : Colors.orange[600],
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

          Container(
            width: double.infinity,
            height: 56,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor ?? Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }
}