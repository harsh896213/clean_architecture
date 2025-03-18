
import 'package:pva/core/constants/constants.dart';

import '../../../../core/local/database/data/database_helper.dart';
import '../models/appointment.dart';

abstract class AppointmentLocalDataSource {
  Future<List<AppointmentModel>> getAppointments();
}

class AppointmentLocalDataSourceImpl implements AppointmentLocalDataSource {
  final DatabaseHelper databaseHelper;

  AppointmentLocalDataSourceImpl({required this.databaseHelper});


  @override
  Future<List<AppointmentModel>> getAppointments() async {
    final db = databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(Constants.tableNameAppointments);

    return List.generate(maps.length, (i) {
      return AppointmentModel.fromJson(maps[i]);
    });
  }
}