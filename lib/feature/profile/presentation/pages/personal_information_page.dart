import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../widget/information_section_card.dart';
import '../widget/profile_information_card.dart';
import 'edit_profile_page.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Personal Information',
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
        children: [
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ProfileInfoCard(
                    imageUrl: 'assets/profile_image.png',
                    name: 'Simon Riley',
                    gender: 'Male',
                    age: 52,
                    patientId: '89373652',
                    carePlanStartDate: 'Nov 01, 2024',
                  ),

                  InformationSectionCard(
                    title: 'Basic Information',
                    infoItems: [
                      {'label': 'Date Of Birth:', 'value': 'Mar 28, 2072'},
                      {'label': 'Race:', 'value': 'Asia'},
                      {'label': 'Ethnicity:', 'value': 'Non Hispanic'},
                    ],
                    onEdit: () {
                      context.push("/edit_profile");
                    },
                  ),

                  InformationSectionCard(
                    title: 'Contact Information',
                    infoItems: [
                      {'label': 'Contact No:', 'value': '83736 73499'},
                      {'label': 'Email ID:', 'value': 'simonr@gmail.com'},
                      {
                        'label': 'Address:',
                        'value': '70 Washington Square South,\nNew York, NY 10012, United States'
                      },
                    ],
                    onEdit: () {
                    },
                  ),

                  InformationSectionCard(
                    title: 'Emergency Contact',
                    infoItems: [
                      {'label': 'Name:', 'value': 'Gabriela Huang'},
                      {'label': 'Relation:', 'value': 'Spouse'},
                      {'label': 'Alternate Contact:', 'value': '83363 83725'},
                      {'label': 'Email:', 'value': 'gabrielahuang@gmail.com'},
                    ],
                    onEdit: () {
                    },
                  ),

                  // Bottom padding
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}