import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../widget/profile_header.dart';
import '../widget/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'My Profile',
          style: TextStyle(
            fontSize: 24,
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
                  const SizedBox(height: 20),

                  const ProfileHeader(
                    imageUrl: 'assets/profile_image.png',
                    name: 'Simon Riley',
                    id: '89373652',
                  ),

                  const SizedBox(height: 20),

                  ProfileMenuItem(
                    title: 'Personal Information',
                    onTap: () {
                      context.push("/personal_information");
                    },
                  ),

                  ProfileMenuItem(
                    title: 'Care Team Information',
                    onTap: () {
                      context.push("/care_team_information");
                    },
                  ),

                  ProfileMenuItem(
                    title: 'Consent Document',
                    onTap: () {
                      context.push("/consent_document");
                    },
                  ),

                  ProfileMenuItem(
                    title: 'Care Plan',
                    onTap: () {
                      context.push("/care_plan");
                    },
                  ),

                  ProfileMenuItem(
                    title: 'Progress Tracker',
                    onTap: () {
                      context.push("/progress_tracker");
                    },
                  ),

                  ProfileMenuItem(
                    title: 'Change Password',
                    onTap: () {
                      context.push("/change_password");
                    },
                  ),

                  const SizedBox(height: 20),

                  // Logout button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle logout
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.logout, size: 20),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}