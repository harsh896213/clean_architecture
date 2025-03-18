
import 'package:pva/feature/appointment/data/datasources/appointment_local_data_source.dart';

import '../../domain/repository/appointment_repository.dart';
import '../models/appointment.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentLocalDataSource localDataSource;

  AppointmentRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Appointment>> getAppointments() async {
    final models = await localDataSource.getAppointments();
    return models.map((model) => model.toEntity()).toList();
  }
}
