import '../../data/models/appointment.dart';

abstract interface class AppointmentRepository {
  Future<List<Appointment>> getAppointments();
}