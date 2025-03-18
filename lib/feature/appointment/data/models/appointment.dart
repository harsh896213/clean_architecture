class Appointment {
  final String id;
  final String doctorName;
  final String specialty;
  final DateTime dateTime;
  final int isVirtual;

  Appointment({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
    required this.isVirtual,
  });
}

class AppointmentModel extends Appointment {
  AppointmentModel({
    required super.id,
    required super.doctorName,
    required super.specialty,
    required super.dateTime,
    required super.isVirtual,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      doctorName: json['doctorName'],
      specialty: json['specialty'],
      dateTime: DateTime.parse(json['dateTime']),
      isVirtual: json['isVirtual'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorName': doctorName,
      'specialty': specialty,
      'dateTime': dateTime.toIso8601String(),
      'isVirtual': isVirtual,
    };
  }
}

extension AppointmentModelExtension on AppointmentModel {
  Appointment toEntity() {
    return Appointment(
      id: id,
      doctorName: doctorName,
      specialty: specialty,
      dateTime: dateTime,
      isVirtual: isVirtual,
    );
  }
}