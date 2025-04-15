import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/entities/tracker_data.dart';
import '../widget/daliy_activity_widget.dart';
import '../widget/mini_profile_information_card.dart';
import '../widget/weekly_tracker_widget.dart';

class ProgressTrackerPage extends StatelessWidget {
  const ProgressTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, TrackerData> trackerData = {
      'medication': TrackerData(
        progress: 0.83,
        color: const Color(0xFF8896FF),  // Blue color
      ),
      'activity': TrackerData(
        progress: 0.64,
        color: const Color(0xFFFFA78F),  // Coral color
      ),
      'survey': TrackerData(
        progress: 0.72,
        color: const Color(0xFF7DEBC8),  // Mint green color
      ),
      'task': TrackerData(
        progress: 0.68,
        color: const Color(0xFF7FD4FF),  // Light blue color
      ),
    };

    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Progress Tracker',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        titleColor: Colors.black,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MiniProfileCard(
                imageUrl: 'assets/profile_image.png',
                name: 'Simon Riley',
                patientId: '89373652',
                gender: 'Male',
                age: 52,
              ),
              const Divider(height: 1, thickness: 1),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 0,
                  color: AppPallete.cardBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: WeeklyTrackerWidget(
                    trackerData: trackerData,
                    onTimeFrameChanged: () {},
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DailyActivityWidget(
                  initialDate: DateTime(2023, 1, 3), // 03 Jan 23
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
