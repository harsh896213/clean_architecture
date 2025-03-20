import 'package:pva/feature/appointment/data/models/appoitment_with_doctor.dart';


abstract interface class AppointmentRepository {
  Future<List<AppointmentWithDoctor>> getAppointments(DateTime selectedDate);
}