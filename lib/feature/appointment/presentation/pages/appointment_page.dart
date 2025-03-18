import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/get_it.dart';
import '../bloc/appointment_state.dart';
import '../bloc/appoitment_bloc.dart';
import '../bloc/appoitment_event.dart';
import '../widgets/calender_widget.dart';

class AppointmentPage extends StatelessWidget {
  final DateTime selectedDate;

  const AppointmentPage({
    super.key,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: BlocProvider(
        create: (context) => getIt<AppointmentBloc>()..add(FetchAppointments()),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CalendarWidget(selectedDate: selectedDate),
              _buildAppointmentsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentsList() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AppointmentError) {
          return Center(child: Text(state.message));
        } else if (state is AppointmentLoaded) {
          final appointments = state.appointments;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return ListTile(
                title: Text(appointment.doctorName),
                subtitle: Text(appointment.specialty),
                trailing: Text(appointment.dateTime.toString()),
              );
            },
          );
        } else {
          return Center(child: Text('No appointments found.'));
        }
      },
    );
  }
}