abstract class AppointmentEvent {}

class FetchAppointments extends AppointmentEvent {
  final DateTime date;

  FetchAppointments(this.date);

  @override
List<Object?> get props => [date];
}