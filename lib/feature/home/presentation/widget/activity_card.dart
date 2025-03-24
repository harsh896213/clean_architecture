import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/image_path/image_path.dart';
import 'package:pva/core/theme/shadow.dart';
import 'package:pva/core/widgets/svg_button_container.dart';
import 'package:pva/feature/home/domain/entity/activity.dart';
import 'package:pva/feature/home/presentation/widget/icon_btn.dart';

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
              child: SvgButtonContainer(
                svgPath: _getSvgPath(activity.type),
                padding: 12,
                size: 24,
                color: _getActivityColor(activity.type),
              ),
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
                        SvgPicture.asset(_getSvgPath(activity.type), width: 24, color: Colors.red,),
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
              spacing: 10,
              children: [
                IconContainer(icon: Icons.check, color: context.theme.primaryColor, padding: 10),
                SvgButtonContainer(svgPath: ImagePath.cancel, color: Colors.grey, size: 20, padding: 10,)
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
      case ActivityType.survey:
        return Colors.red;
    }
  }

  String _getSvgPath(ActivityType type) {
    switch (type) {
      case ActivityType.exercise:
        return ImagePath.dumble;
      case ActivityType.medication:
        return ImagePath.medication;
      case ActivityType.appointment:
        return ImagePath.appointment;
      case ActivityType.therapy:
        return ImagePath.surveyEdit;
      case ActivityType.survey:
        return ImagePath.surveyEdit;
      case ActivityType.other:
        return ImagePath.bellIcon;
    }
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}