
import 'package:pva/feature/appointment/data/models/appoitment_with_doctor.dart';

import '../../data/models/appointment.dart';

abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final List<AppointmentWithDoctor> appointments;

  AppointmentLoaded(this.appointments);
}

class AppointmentError extends AppointmentState {
  final String message;

  AppointmentError(this.message);
}