import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProfileEvent {}

class DateOfBirthChanged extends ProfileEvent {
  final String dateOfBirth;
  DateOfBirthChanged(this.dateOfBirth);
}

class RaceChanged extends ProfileEvent {
  final String race;
  RaceChanged(this.race);
}

class EthnicityChanged extends ProfileEvent {
  final String ethnicity;
  EthnicityChanged(this.ethnicity);
}

class ContactNumberChanged extends ProfileEvent {
  final String contactNumber;
  ContactNumberChanged(this.contactNumber);
}

class EmailChanged extends ProfileEvent {
  final String email;
  EmailChanged(this.email);
}

class AddressChanged extends ProfileEvent {
  final String address;
  AddressChanged(this.address);
}

class EmergencyNameChanged extends ProfileEvent {
  final String name;
  EmergencyNameChanged(this.name);
}

class EmergencyRelationChanged extends ProfileEvent {
  final String relation;
  EmergencyRelationChanged(this.relation);
}

class EmergencyContactChanged extends ProfileEvent {
  final String contact;
  EmergencyContactChanged(this.contact);
}

class EmergencyEmailChanged extends ProfileEvent {
  final String email;
  EmergencyEmailChanged(this.email);
}

class SaveProfilePressed extends ProfileEvent {}

class TabChanged extends ProfileEvent {
  final int tabIndex;
  TabChanged(this.tabIndex);
}

// States
class ProfileState {
  // Basic Information
  final String dateOfBirth;
  final String race;
  final String ethnicity;

  // Contact Information
  final String contactNumber;
  final String email;
  final String address;

  // Emergency Contact
  final String emergencyName;
  final String emergencyRelation;
  final String emergencyContact;
  final String emergencyEmail;

  // UI State
  final int currentTabIndex;
  final bool isValid;

  ProfileState({
    // Basic Information
    this.dateOfBirth = '',
    this.race = '',
    this.ethnicity = '',

    // Contact Information
    this.contactNumber = '',
    this.email = '',
    this.address = '',

    // Emergency Contact
    this.emergencyName = '',
    this.emergencyRelation = '',
    this.emergencyContact = '',
    this.emergencyEmail = '',

    // UI State
    this.currentTabIndex = 0,
    this.isValid = false,
  });

  ProfileState copyWith({
    // Basic Information
    String? dateOfBirth,
    String? race,
    String? ethnicity,

    // Contact Information
    String? contactNumber,
    String? email,
    String? address,

    // Emergency Contact
    String? emergencyName,
    String? emergencyRelation,
    String? emergencyContact,
    String? emergencyEmail,

    // UI State
    int? currentTabIndex,
    bool? isValid,
  }) {
    return ProfileState(
      // Basic Information
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      race: race ?? this.race,
      ethnicity: ethnicity ?? this.ethnicity,

      // Contact Information
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      address: address ?? this.address,

      // Emergency Contact
      emergencyName: emergencyName ?? this.emergencyName,
      emergencyRelation: emergencyRelation ?? this.emergencyRelation,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyEmail: emergencyEmail ?? this.emergencyEmail,

      // UI State
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      isValid: isValid ?? this.isValid,
    );
  }
}

// BLoC
class EditProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  EditProfileBloc({int initialTabIndex = 0}) : super(ProfileState(currentTabIndex: initialTabIndex)) {
    on<DateOfBirthChanged>(_onDateOfBirthChanged);
    on<RaceChanged>(_onRaceChanged);
    on<EthnicityChanged>(_onEthnicityChanged);

    on<ContactNumberChanged>(_onContactNumberChanged);
    on<EmailChanged>(_onEmailChanged);
    on<AddressChanged>(_onAddressChanged);

    on<EmergencyNameChanged>(_onEmergencyNameChanged);
    on<EmergencyRelationChanged>(_onEmergencyRelationChanged);
    on<EmergencyContactChanged>(_onEmergencyContactChanged);
    on<EmergencyEmailChanged>(_onEmergencyEmailChanged);

    on<TabChanged>(_onTabChanged);
    on<SaveProfilePressed>(_onSaveProfilePressed);
  }

  void _onDateOfBirthChanged(DateOfBirthChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      dateOfBirth: event.dateOfBirth,
      isValid: _validateCurrentTab(state.currentTabIndex, dateOfBirth: event.dateOfBirth),
    ));
  }

  void _onRaceChanged(RaceChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      race: event.race,
      isValid: _validateCurrentTab(state.currentTabIndex, race: event.race),
    ));
  }

  void _onEthnicityChanged(EthnicityChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      ethnicity: event.ethnicity,
      isValid: _validateCurrentTab(state.currentTabIndex, ethnicity: event.ethnicity),
    ));
  }

  void _onContactNumberChanged(ContactNumberChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      contactNumber: event.contactNumber,
      isValid: _validateCurrentTab(state.currentTabIndex, contactNumber: event.contactNumber),
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      email: event.email,
      isValid: _validateCurrentTab(state.currentTabIndex, email: event.email),
    ));
  }

  void _onAddressChanged(AddressChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      address: event.address,
      isValid: _validateCurrentTab(state.currentTabIndex, address: event.address),
    ));
  }

  void _onEmergencyNameChanged(EmergencyNameChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      emergencyName: event.name,
      isValid: _validateCurrentTab(state.currentTabIndex, emergencyName: event.name),
    ));
  }

  void _onEmergencyRelationChanged(EmergencyRelationChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      emergencyRelation: event.relation,
      isValid: _validateCurrentTab(state.currentTabIndex, emergencyRelation: event.relation),
    ));
  }

  void _onEmergencyContactChanged(EmergencyContactChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      emergencyContact: event.contact,
      isValid: _validateCurrentTab(state.currentTabIndex, emergencyContact: event.contact),
    ));
  }

  void _onEmergencyEmailChanged(EmergencyEmailChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      emergencyEmail: event.email,
      isValid: _validateCurrentTab(state.currentTabIndex, emergencyEmail: event.email),
    ));
  }

  void _onTabChanged(TabChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      currentTabIndex: event.tabIndex,
      isValid: _validateCurrentTab(event.tabIndex),
    ));
  }

  void _onSaveProfilePressed(SaveProfilePressed event, Emitter<ProfileState> emit) {
    if (state.isValid) {
      print('Profile saved successfully for tab ${state.currentTabIndex}');
    }
  }

  // Validation
  bool _validateCurrentTab(int tabIndex, {
    String? dateOfBirth,
    String? race,
    String? ethnicity,
    String? contactNumber,
    String? email,
    String? address,
    String? emergencyName,
    String? emergencyRelation,
    String? emergencyContact,
    String? emergencyEmail,
  }) {
    switch (tabIndex) {
      case 0: // Basic Information
        return _validateBasicInformation(
          dateOfBirth ?? state.dateOfBirth,
          race ?? state.race,
          ethnicity ?? state.ethnicity,
        );
      case 1: // Contact Information
        return _validateContactInformation(
          contactNumber ?? state.contactNumber,
          email ?? state.email,
          address ?? state.address,
        );
      case 2: // Emergency Contact
        return _validateEmergencyContact(
          emergencyName ?? state.emergencyName,
          emergencyRelation ?? state.emergencyRelation,
          emergencyContact ?? state.emergencyContact,
          emergencyEmail ?? state.emergencyEmail,
        );
      default:
        return false;
    }
  }

  bool _validateBasicInformation(String dateOfBirth, String race, String ethnicity) {
    return dateOfBirth.isNotEmpty;
  }

  bool _validateContactInformation(String contactNumber, String email, String address) {
    return contactNumber.isNotEmpty || email.isNotEmpty;
  }

  bool _validateEmergencyContact(String name, String relation, String contact, String email) {
    return name.isNotEmpty && contact.isNotEmpty;
  }
}

// Main Edit Profile Page