import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/appointment_repository.dart';
import 'appointment_state.dart';
import 'appoitment_event.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository repository;

  AppointmentBloc({required this.repository}) : super(AppointmentInitial()) {
    on<FetchAppointments>(_onFetchAppointments);
  }

  Future<void> _onFetchAppointments(
      FetchAppointments event,
      Emitter<AppointmentState> emit,
      ) async {
    emit(AppointmentLoading());
    try {
      final appointments = await repository.getAppointments(event.date);
      print('All appointments $appointments');
      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError('Failed to fetch appointments: $e'));
    }
  }
}