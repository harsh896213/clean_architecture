import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pva/core/theme/shadow.dart';
import 'package:pva/feature/home/domain/entity/activity.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback onComplete;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: cardShadow
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: ShapeDecoration(
                  color: _getActivityColor(activity.type),
                  shape: CircleBorder()),
              child: Icon(_getIcons(activity.type), size: 17,),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Container(
                    decoration: ShapeDecoration(
                        color:  Colors.red.shade100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 8,
                      children: [
                      Icon(_getIcons(activity.type), size: 10, color: Colors.red,),
                      Text("Medication")

                    ],),
                  ),
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    activity.description,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '${_formatTime(activity.startTime)} - ${_formatTime(activity.endTime)} AM',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: activity.isCompleted ? null : onComplete,
                  icon: Icon(
                    Icons.check_circle,
                    color:  Colors.green,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: activity.isCompleted ? null : onComplete,
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black26,
                    size: 35,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getActivityColor(ActivityType type) {
    switch (type) {
      case ActivityType.exercise:
        return Colors.blue;
      case ActivityType.medication:
        return Colors.red;
      case ActivityType.appointment:
        return Colors.purple;
      case ActivityType.therapy:
        return Colors.orange;
      case ActivityType.other:
        return Colors.grey;
    }
  }

  IconData _getIcons(ActivityType type) {
    switch (type) {
      case ActivityType.exercise:
        return Icons.sports_gymnastics;
      case ActivityType.medication:
        return Icons.medical_information_outlined;
      case ActivityType.appointment:
        return Icons.perm_identity;
      case ActivityType.therapy:
        return Icons.theater_comedy;
      case ActivityType.other:
        return Icons.devices_other;
    }
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}