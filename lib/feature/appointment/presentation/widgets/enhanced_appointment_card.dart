import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';
import 'appoitment_type_badge.dart';

class EnhancedAppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String time;
  final bool isVirtual;
  final String profilePic;
  final VoidCallback onTap;
  final bool showJoinButton;

  const EnhancedAppointmentCard({
    Key? key,
    required this.doctorName,
    required this.specialty,
    required this.time,
    required this.isVirtual,
    required this.profilePic,
    required this.onTap,
    this.showJoinButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(profilePic),
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
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        specialty,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: AppPallete.primaryBlue,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppPallete.primaryBlue,
                              fontWeight: FontWeight.w500,
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: Row(
              children: [
                AppointmentTypeBadge(isVirtual: isVirtual),
              ],
            ),
          ),
          if (showJoinButton)
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Join virtual appointment
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPallete.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Join Call'),
              ),
            ),
        ],
      ),
    );
  }
}