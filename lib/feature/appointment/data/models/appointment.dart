class Appointment {
  final String id;
  final String doctorId;
  final String patientId;
  final DateTime dateTime;
  final int isVirtual;
  final String profilePic;


  Appointment({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.dateTime,
    required this.isVirtual,
    required this.profilePic
  });

  @override
  String toString() {
    return 'Appointment(id: $id, doctorId: $doctorId, patientId: $patientId, dateTime: $dateTime, isVirtual: $isVirtual)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctorId': doctorId,
      'patientId': patientId,
      'dateTime': dateTime.millisecondsSinceEpoch, // Store as milliseconds
      'isVirtual': isVirtual,
      'profilePic': profilePic,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      doctorId: map['doctorId'],
      patientId: map['patientId'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      isVirtual: map['isVirtual'],
      profilePic: map['profilePic'] ?? '',
    );
  }
}

class AppointmentModel extends Appointment {
  AppointmentModel({
    required super.id,
    required super.doctorId,
    required super.patientId,
    required super.dateTime,
    required super.isVirtual,
    required super.profilePic
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
        doctorId: json['doctorId'],
        patientId: json['patientId'],
      dateTime: DateTime.parse(json['dateTime']),
      isVirtual: json['isVirtual'],
      profilePic: json['profilePic']
    );
  }
}

extension AppointmentModelExtension on AppointmentModel {
  Appointment toEntity() {
    return Appointment(
      id: id,
        doctorId: doctorId,
        patientId: patientId,
      dateTime: dateTime,
      isVirtual: isVirtual,
      profilePic: profilePic
    );
  }
}