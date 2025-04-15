import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/custom_input_field.dart';
import '../bloc/change_password_bloc.dart';

class PasswordChangeWidget extends StatelessWidget {
  PasswordChangeWidget({super.key});

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppPallete.iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.key,
                  color: Colors.black54,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Old Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildPasswordField(
                context,
                controller: oldPasswordController,
                hintText: 'Enter old password',
                onChanged: (value) {
                  context.read<PasswordBloc>().add(OldPasswordChanged(value));
                },
              ),
              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'New Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildPasswordField(
                context,
                controller: newPasswordController,
                hintText: 'Enter Password',
                onChanged: (value) {
                  context.read<PasswordBloc>().add(NewPasswordChanged(value));
                },
              ),
              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Re-enter Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildPasswordField(
                context,
                controller: confirmPasswordController,
                hintText: 'Re-Enter Password',
                onChanged: (value) {
                  context.read<PasswordBloc>().add(ConfirmPasswordChanged(value));
                },
              ),
              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password must be more than 8 character',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  Text(
                    'Password Strength:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.passwordStrength,
                    style: TextStyle(
                      fontSize: 14,
                      color: _getStrengthColor(state.passwordStrength),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

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
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: state.isValid
                        ? () {
                      context.read<PasswordBloc>().add(SavePasswordPressed());
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPallete.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
          ),
        );
      },
    );
  }

  Widget _buildPasswordField(
      BuildContext context, {
        required TextEditingController controller,
        required String hintText,
        required Function(String) onChanged,
      }) {
    return CustomInputField(
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      // obscureText: true,
      customDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppPallete.dividerColor),
      ),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      maxLines: 1,
    );
  }

  Color _getStrengthColor(String strength) {
    switch (strength) {
      case 'Weak':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Strong':
        return Colors.green;
      case 'Very Strong':
        return Colors.green.shade800;
      default:
        return Colors.grey;
    }
  }
}