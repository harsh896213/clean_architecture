import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PasswordEvent {}

class OldPasswordChanged extends PasswordEvent {
  final String password;
  OldPasswordChanged(this.password);
}

class NewPasswordChanged extends PasswordEvent {
  final String password;
  NewPasswordChanged(this.password);
}

class ConfirmPasswordChanged extends PasswordEvent {
  final String password;
  ConfirmPasswordChanged(this.password);
}

class SavePasswordPressed extends PasswordEvent {}

class PasswordState {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isValid;
  final String? errorMessage;
  final String passwordStrength;

  PasswordState({
    this.oldPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isValid = false,
    this.errorMessage,
    this.passwordStrength = '',
  });

  PasswordState copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isValid,
    String? errorMessage,
    String? passwordStrength,
  }) {
    return PasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage,
      passwordStrength: passwordStrength ?? this.passwordStrength,
    );
  }
}

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordState()) {
    on<OldPasswordChanged>(_onOldPasswordChanged);
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SavePasswordPressed>(_onSavePasswordPressed);
  }

  void _onOldPasswordChanged(OldPasswordChanged event, Emitter<PasswordState> emit) {
    emit(state.copyWith(
      oldPassword: event.password,
      isValid: _validateForm(event.password, state.newPassword, state.confirmPassword),
    ));
  }

  void _onNewPasswordChanged(NewPasswordChanged event, Emitter<PasswordState> emit) {
    String strength = _calculatePasswordStrength(event.password);
    emit(state.copyWith(
      newPassword: event.password,
      passwordStrength: strength,
      isValid: _validateForm(state.oldPassword, event.password, state.confirmPassword),
    ));
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<PasswordState> emit) {
    emit(state.copyWith(
      confirmPassword: event.password,
      isValid: _validateForm(state.oldPassword, state.newPassword, event.password),
    ));
  }

  void _onSavePasswordPressed(SavePasswordPressed event, Emitter<PasswordState> emit) {
    // Implement save functionality
    // This would connect to your authentication service
    if (state.isValid) {
      // Save logic here
      print('Password changed successfully');
    }
  }

  bool _validateForm(String oldPassword, String newPassword, String confirmPassword) {
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      return false;
    }

    if (newPassword.length < 8) {
      return false;
    }

    if (newPassword != confirmPassword) {
      return false;
    }

    return true;
  }

  String _calculatePasswordStrength(String password) {
    if (password.isEmpty) return '';

    if (password.length < 8) return 'Weak';

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    int strength = 0;
    if (hasUppercase) strength++;
    if (hasLowercase) strength++;
    if (hasDigits) strength++;
    if (hasSpecialCharacters) strength++;

    if (strength <= 2) return 'Medium';
    if (strength <= 3) return 'Strong';
    return 'Very Strong';
  }
}
