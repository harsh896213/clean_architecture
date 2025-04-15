import 'package:flutter/material.dart';
import 'package:pva/core/theme/app_pallete.dart';

import '../../../../core/widgets/animated_progressbar.dart';
import '../../domain/entities/tracker_data.dart';

class WeeklyTrackerWidget extends StatelessWidget {
  final String timeFrame;
  final Map<String, TrackerData> trackerData;
  final VoidCallback? onTimeFrameChanged;

  const WeeklyTrackerWidget({
    super.key,
    this.timeFrame = 'Weekly',
    required this.trackerData,
    this.onTimeFrameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPallete.cardBackground,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Weekly Tracker',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        timeFrame,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Medication
                AnimatedProgressIndicator(
                  progress: trackerData['medication']!.progress,
                  color: trackerData['medication']!.color,
                  completed: 'Medication',
                ),

                AnimatedProgressIndicator(
                  progress: trackerData['activity']!.progress,
                  color: trackerData['activity']!.color,
                  completed: 'Physical Activity',
                ),

                AnimatedProgressIndicator(
                  progress: trackerData['survey']!.progress,
                  color: trackerData['survey']!.color,
                  completed: 'Survey',
                ),

                AnimatedProgressIndicator(
                  progress: trackerData['task']!.progress,
                  color: trackerData['task']!.color,
                  completed: 'Task',
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(trackerData['medication']!.color, 'Medication'),
                const SizedBox(width: 24),
                _buildLegendItem(trackerData['activity']!.color, 'Physical Activity'),
                const SizedBox(width: 24),
                _buildLegendItem(trackerData['survey']!.color, 'Survey'),
                const SizedBox(width: 24),
                _buildLegendItem(trackerData['task']!.color, 'Task'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
