import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';

import '../../../../core/theme/app_pallete.dart';

class ProfileInfoCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String gender;
  final int age;
  final String patientId;
  final String carePlanStartDate;

  const ProfileInfoCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.gender,
    required this.age,
    required this.patientId,
    required this.carePlanStartDate,
  });

  @override
  Widget build(BuildContext context) {
    return  Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        color: AppPallete.cardBackground,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // return context.isTablet ? _buildWideLayout() : _buildNarrowLayout();
              return _buildWideLayout();
            },
          ),
        ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imageUrl,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 150,
                height: 150,
                color: Colors.grey[300],
                child: const Icon(Icons.person, size: 60, color: Colors.grey),
              );
            },
          ),
        ),
        const SizedBox(width: 16),

        // Profile details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildProfileDetails(),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 60, color: Colors.grey),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),

        ..._buildProfileDetails(),
      ],
    );
  }

  List<Widget> _buildProfileDetails() {
    return [
      // Name
      Text(
        name,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),

      Text(
        '$gender ( $age Years)',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 16),

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 120,
            child: Text(
              'Patient ID:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              patientId,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),

      // Care Plan Start Date
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 120,
            child: Text(
              'Care Plan Start Date:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              carePlanStartDate,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
