
import 'package:pva/feature/appointment/data/datasources/appointment_local_data_source.dart';
import 'package:pva/feature/appointment/data/models/appoitment_with_doctor.dart';

import '../../domain/repository/appointment_repository.dart';
import '../models/appointment.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentLocalDataSource localDataSource;

  AppointmentRepositoryImpl({required this.localDataSource});

  @override
  Future<List<AppointmentWithDoctor>> getAppointments(DateTime selectedDate) async {
    final models = await localDataSource.getAppointments(selectedDate);
    return models;
  }
}
