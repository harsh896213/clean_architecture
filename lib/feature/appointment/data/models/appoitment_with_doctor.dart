class AppointmentWithDoctor {
  final String id;
  final String doctorId;
  final String patientId;
  final DateTime dateTime;
  final int isVirtual;
  final String doctorName;
  final String specialty;

  AppointmentWithDoctor({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.dateTime,
    required this.isVirtual,
    required this.doctorName,
    required this.specialty,
  });

  factory AppointmentWithDoctor.fromMap(Map<String, dynamic> map) {
    return AppointmentWithDoctor(
      id: map['id'],
      doctorId: map['doctorId'],
      patientId: map['patientId'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      isVirtual: map['isVirtual'],
      doctorName: map['doctorName'] ?? '',
      specialty: map['specialty'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctorId': doctorId,
      'patientId': patientId,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isVirtual': isVirtual,
      'doctorName': doctorName,
      'specialty': specialty,
    };
  }
}