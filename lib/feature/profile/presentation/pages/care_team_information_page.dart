import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../widget/profile_information_card.dart';
import '../widget/team_member_card.dart';

class CareTeamInformationPage extends StatelessWidget {
  const CareTeamInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Care Team Information',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileInfoCard(
                    imageUrl: 'assets/profile_image.png',
                    name: 'Simon Riley',
                    gender: 'Male',
                    age: 52,
                    patientId: '89373652',
                    carePlanStartDate: 'Nov 01, 2024',
                  ),

                  // Physician Section
                  const SectionTitle(title: 'Physician'),
                  CareTeamMemberCard(
                    imageUrl: 'assets/doctor_image.png',
                    name: 'Joseph Rodriguez',
                    role: 'Physician',
                    badge: 'Physician',
                    specialization: 'Cardiologist',
                    qualifications: 'MBBS, MD - General Medicine, DNB - Cardiology',
                    experience: '35 Years experience overall',
                    availability: 'MON-SAT\n09:00 AM - 07:00 PM',
                    showMessageButton: true,
                    showCallButton: false,
                  ),

                  // Care Coordinator Section
                  const SectionTitle(title: 'Care Coordinator'),
                  CareTeamMemberCard(
                    imageUrl: 'assets/coordinator1_image.png',
                    name: 'Olivia Jones',
                    role: 'Care Coordinator',
                    badge: 'Care Team Member',
                    email: 'oliviaj@holistiqhealth.com',
                    contact: '98373 73635',
                    availability: 'MON-SAT\n09:00 AM - 07:00 PM',
                    showMessageButton: true,
                    showCallButton: true,
                  ),

                  CareTeamMemberCard(
                    imageUrl: 'assets/coordinator2_image.png',
                    name: 'Mike Jones',
                    role: 'Care Coordinator',
                    badge: 'Care Team Member',
                    email: 'mikej@holistiqhealth.com',
                    contact: '98373 73635',
                    showMessageButton: true,
                    showCallButton: true,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}