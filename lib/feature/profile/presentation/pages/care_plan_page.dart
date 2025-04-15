import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../widget/profile_information_card.dart';
import '../widget/responsivetable_widget.dart';

class CarePlanPage extends StatelessWidget {
  const CarePlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final medicationItems = [
      {
        'name': 'Take your Pain medication',
        'startDate': 'Sep 06, 2024',
        'duration': '360 Days',
        'morning': '08:02 AM',
        'afternoon': '02:00 PM',
        'evening': '-',
        'night': '-',
      },
    ];

    // Sample data for activity items
    final activityItems = [
      {
        'name': 'Complete the prescribed physical activity',
        'startDate': 'Sep 06, 2024',
        'duration': '360 Days',
        'morning': '08:02 AM',
        'afternoon': '02:00 PM',
        'evening': '-',
        'night': '-',
      },
    ];

    // Sample data for survey items
    final surveyItems = [
      {
        'name': 'Tell Us About Your Physical Therapy Daily Exercise',
        'startDate': 'Sep 06, 2024',
        'duration': '360 Days',
        'frequency': 'Daily',
      },
      {
        'name': 'Enter Your Pain Level',
        'startDate': 'Sep 06, 2024',
        'duration': '360 Days',
        'frequency': 'Daily',
      },
      {
        'name': 'Tell Us About Your Pain Medication',
        'startDate': 'Sep 06, 2024',
        'duration': '360 Days',
        'frequency': 'Daily',
      },
      {
        'name': 'Tell Us About Your Anti-inflammatory Diet',
        'startDate': 'Sep 06, 2024',
        'duration': '360 Days',
        'frequency': 'Daily',
      },
      {
        'name': 'Functional Capability Survey',
        'startDate': 'Sep 06, 2024',
        'duration': '360 Days',
        'frequency': 'Daily',
      },
    ];

    // Sample data for task items
    final taskItems = [
      {
        'name': 'Take your Pain medication',
        'startDate': 'Sep 06, 2024',
        'duration': '360 Days',
        'morning': '08:02 AM',
        'afternoon': '02:00 PM',
        'evening': '-',
        'night': '-',
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Care Plan',
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
      // Make the entire body scrollable using SingleChildScrollView
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Info Card
            const ProfileInfoCard(
              imageUrl: 'assets/profile_image.png',
              name: 'Simon Riley',
              gender: 'Male',
              age: 52,
              patientId: '89373652',
              carePlanStartDate: 'Nov 01, 2024',
            ),

            // Care Plan Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Care Plan Details with Download button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Care Plan Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.download,
                            color: Colors.white, size: 16),
                        label: const Text(
                          'Download',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Downloading Care Plan')),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Medications Section
                  const Text(
                    'Medications',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ScheduleTable(type: 'medication', items: medicationItems),
                  const SizedBox(height: 24),

                  // Physical Activity Section
                  const Text(
                    'Physical Activity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ScheduleTable(type: 'activity', items: activityItems),
                  const SizedBox(height: 24),

                  // Survey Section
                  const Text(
                    'Survey',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SurveyTable(items: surveyItems),
                  const SizedBox(height: 24),

                  // Task Section
                  const Text(
                    'Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ScheduleTable(type: 'task', items: taskItems),

                  const SizedBox(height: 40), // Bottom padding
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}