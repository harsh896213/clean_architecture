import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';

class AppointmentTypeBadge extends StatelessWidget {
  final bool isVirtual;

  const AppointmentTypeBadge({
    Key? key,
    required this.isVirtual,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isVirtual ? AppPallete.virtualBadgeBg : AppPallete.inPersonBadgeBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVirtual ? Icons.videocam : Icons.location_on,
            size: 14,
            color: isVirtual ? AppPallete.virtualBadgeText : AppPallete.inPersonBadgeText,
          ),
          const SizedBox(width: 4),
          Text(
            isVirtual ? 'Virtual Visit' : 'In-Person',
            style: TextStyle(
              fontSize: 12,
              color: isVirtual ? AppPallete.virtualBadgeText : AppPallete.inPersonBadgeText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
