import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/custom_input_field.dart';
import '../bloc/edit_profile_bloc.dart';

class ProfileEditWidget extends StatelessWidget {
  ProfileEditWidget({super.key});

  // Basic Information controllers
  final TextEditingController dateController = TextEditingController();
  final TextEditingController raceController = TextEditingController();
  final TextEditingController ethnicityController = TextEditingController();

  // Contact Information controllers
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Emergency Contact controllers
  final TextEditingController emergencyNameController = TextEditingController();
  final TextEditingController emergencyRelationController = TextEditingController();
  final TextEditingController emergencyContactController = TextEditingController();
  final TextEditingController emergencyEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab bar
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  _buildTabItem(
                    context: context,
                    title: 'Basic Information',
                    isSelected: state.currentTabIndex == 0,
                    onTap: () => context.read<EditProfileBloc>().add(TabChanged(0)),
                  ),
                  _buildTabItem(
                    context: context,
                    title: 'Contact Information',
                    isSelected: state.currentTabIndex == 1,
                    onTap: () => context.read<EditProfileBloc>().add(TabChanged(1)),
                  ),
                  _buildTabItem(
                    context: context,
                    title: 'Emergency Contact',
                    isSelected: state.currentTabIndex == 2,
                    onTap: () => context.read<EditProfileBloc>().add(TabChanged(2)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Content based on selected tab
            if (state.currentTabIndex == 0)
              _buildBasicInformationContent(context, state),
            if (state.currentTabIndex == 1)
              _buildContactInformationContent(context, state),
            if (state.currentTabIndex == 2)
              _buildEmergencyContactContent(context, state),

            const Padding(padding: EdgeInsets.only(bottom: 40)),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: state.isValid
                      ? () {
                    context.read<EditProfileBloc>().add(SaveProfilePressed());
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    disabledBackgroundColor: AppPallete.primaryColor.withOpacity(0.5),
                  ),
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Tab Builders
  Widget _buildBasicInformationContent(BuildContext context, ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Date Of Birth'),
        const SizedBox(height: 8),
        _buildDateField(
          context: context,
          controller: dateController,
          hintText: 'DD / MM / YYYY',
          onChanged: (value) {
            context.read<EditProfileBloc>().add(DateOfBirthChanged(value));
          },
        ),
        const SizedBox(height: 16),

        // Race Field
        _buildLabel('Race'),
        const SizedBox(height: 8),
        _buildInputField(
          context: context,
          controller: raceController,
          hintText: 'Placeholder',
          onChanged: (value) {
            context.read<EditProfileBloc>().add(RaceChanged(value));
          },
        ),
        const SizedBox(height: 16),

        // Ethnicity Field
        _buildLabel('Ethnicity'),
        const SizedBox(height: 8),
        _buildInputField(
          context: context,
          controller: ethnicityController,
          hintText: 'Enter text',
          onChanged: (value) {
            context.read<EditProfileBloc>().add(EthnicityChanged(value));
          },
        ),
      ],
    );
  }

  Widget _buildContactInformationContent(BuildContext context, ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Number Field
        _buildLabel('Contact No'),
        const SizedBox(height: 8),
        _buildInputField(
          context: context,
          controller: contactNumberController,
          hintText: 'Enter contact number',
          onChanged: (value) {
            context.read<EditProfileBloc>().add(ContactNumberChanged(value));
          },
        ),
        const SizedBox(height: 16),

        // Email Field
        _buildLabel('Email ID'),
        const SizedBox(height: 8),
        _buildInputField(
          context: context,
          controller: emailController,
          hintText: 'Enter email',
          onChanged: (value) {
            context.read<EditProfileBloc>().add(EmailChanged(value));
          },
        ),
        const SizedBox(height: 16),

        // Address Field
        _buildLabel('Address'),
        const SizedBox(height: 8),
        _buildInputField(
          context: context,
          controller: addressController,
          hintText: 'Enter address',
          onChanged: (value) {
            context.read<EditProfileBloc>().add(AddressChanged(value));
          },
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildEmergencyContactContent(BuildContext context, ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Name'),
        const SizedBox(height: 8),
        _buildInputField(
          context: context,
          controller: emergencyNameController,
          hintText: 'Enter name',
          onChanged: (value) {
            context.read<EditProfileBloc>().add(EmergencyNameChanged(value));
          },
        ),
        const SizedBox(height: 16),

        _buildLabel('Relation'),
        const SizedBox(height: 8),
        _buildInputField(
          context: context,
          controller: emergencyRelationController,
          hintText: 'Enter relation',
          onChanged: (value) {
            context.read<EditProfileBloc>().add(EmergencyRelationChanged(value));
          },
        ),
        const SizedBox(height: 16),

        _buildLabel('Alternate Contact'),
        const SizedBox(height: 8),
        _buildInputField(
          context: context,
          controller: emergencyContactController,
          hintText: 'Enter contact number',
          onChanged: (value) {
            context.read<EditProfileBloc>().add(EmergencyContactChanged(value));
          },
        ),
        const SizedBox(height: 16),

        _buildLabel('Email'),
        const SizedBox(height: 8),
        _buildInputField(
          context: context,
          controller: emergencyEmailController,
          hintText: 'Enter email',
          onChanged: (value) {
            context.read<EditProfileBloc>().add(EmergencyEmailChanged(value));
          },
        ),
      ],
    );
  }

  Widget _buildTabItem({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: isSelected
                ? Border(
              bottom: BorderSide(
                color: AppPallete.primaryColor,
                width: 2.0,
              ),
            )
                : null,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? AppPallete.primaryColor : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required Function(String) onChanged,
    int maxLines = 1,
  }) {
    return SizedBox(
      height: maxLines > 1 ? maxLines * 24.0 : 50,
      child: CustomInputField(
        controller: controller,
        hintText: hintText,
        onChanged: onChanged,
        customDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppPallete.dividerColor),
        ),
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required Function(String) onChanged,
  }) {
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          CustomInputField(
            controller: controller,
            hintText: hintText,
            onChanged: onChanged,
            customDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppPallete.dividerColor),
            ),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            maxLines: 1,
          ),
          Positioned(
            right: 12,
            child: Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
