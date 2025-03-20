import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/get_it.dart';
import '../bloc/appointment_state.dart';
import '../bloc/appoitment_bloc.dart';
import '../bloc/appoitment_event.dart';
import '../widgets/week_calender_widget.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => AppointmentPageState();
}

class AppointmentPageState extends State<AppointmentPage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    // Here you would fetch appointments for the selected date
    // and update the list below
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<AppointmentBloc>()..add(FetchAppointments(_selectedDate)),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                WeeklyCalendarWidget(
                  onDateSelected: _onDateSelected,
                ),
                Expanded(
                  child: _buildAppointmentsList(),
                ),
              ],
            ),
          ),
        ));
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
