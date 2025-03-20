
import 'package:pva/core/constants/constants.dart';
import 'package:pva/core/di/get_it.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../../../core/local/database/data/database_helper.dart';
import '../models/appointment.dart';
import '../models/appoitment_with_doctor.dart';

abstract class AppointmentLocalDataSource {
  Future<List<AppointmentWithDoctor>> getAppointments(DateTime date);
}

class AppointmentLocalDataSourceImpl implements AppointmentLocalDataSource {
  final DatabaseHelper databaseHelper;

  AppointmentLocalDataSourceImpl({required this.databaseHelper});


  @override
  Future<List<AppointmentWithDoctor>> getAppointments(DateTime date) async {
    // Create start and end of the selected day in milliseconds
    final startOfDay = DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
    final endOfDay = DateTime(date.year, date.month, date.day + 1).millisecondsSinceEpoch;

    // Debug: Print date range for verification
    print('Getting appointments for: ${date.toString()}');
    print('Start of Day: $startOfDay (${DateTime.fromMillisecondsSinceEpoch(startOfDay)})');
    print('End of Day: $endOfDay (${DateTime.fromMillisecondsSinceEpoch(endOfDay)})');

    // Check if there are any appointments in the database
    final countResult = await databaseHelper.database.rawQuery(
        'SELECT COUNT(*) as count FROM Appointments'
    );
    final count = Sqflite.firstIntValue(countResult) ?? 0;
    print('Total appointments in database: $count');

    // Get a sample appointment to inspect its dateTime format
    if (count > 0) {
      final sampleAppointment = await databaseHelper.database.query(
          'Appointments',
          limit: 1
      );
      print('Sample appointment: $sampleAppointment');
      print('Sample dateTime value: ${sampleAppointment.first['dateTime']}');
      print('Sample dateTime type: ${sampleAppointment.first['dateTime'].runtimeType}');
    }

    // Fetch data using a JOIN query with correct dateTime comparison
    final result = await databaseHelper.database.rawQuery('''
      SELECT 
        Appointments.id,
        Appointments.doctorId,
        Appointments.patientId,
        Appointments.dateTime,
        Appointments.isVirtual,
        Users.name AS doctorName,
        Users.specialty
      FROM Appointments
      JOIN Users ON Appointments.doctorId = Users.id
      WHERE Appointments.dateTime >= ? AND Appointments.dateTime < ?
    ''', [startOfDay, endOfDay]);

    // Debug: Print query results
    print('Query Results: $result');

    // Convert the result into a list of AppointmentWithDoctor objects
    return result.map((map) => AppointmentWithDoctor.fromMap(map)).toList();
  }
}