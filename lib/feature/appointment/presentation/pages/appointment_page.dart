import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/get_it.dart';
import '../bloc/appointment_state.dart';
import '../bloc/appoitment_bloc.dart';
import '../bloc/appoitment_event.dart';
import '../widgets/appointment_card.dart';
import '../widgets/enhanced_weekly_calender.dart';
import '../widgets/week_calender_widget.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppointmentBloc>(),
      child: const AppointmentPageContent(),
    );
  }
}

class AppointmentPageContent extends StatefulWidget {
  const AppointmentPageContent({Key? key}) : super(key: key);

  @override
  State<AppointmentPageContent> createState() => AppointmentPageContentState();
}

class AppointmentPageContentState extends State<AppointmentPageContent> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    Future.microtask(() =>
        context.read<AppointmentBloc>().add(FetchAppointments(_selectedDate))
    );
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    context.read<AppointmentBloc>().add(FetchAppointments(_selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        elevation: 0,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            EnhancedWeeklyCalendarWidget(
              onDateSelected: _onDateSelected,
              selectedDate: _selectedDate,
            ),
            Expanded(
              child: _buildAppointmentsList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality to book a new appointment
        },
        child: const Icon(Icons.add),
        tooltip: 'Book Appointment',
      ),
    );
  }


  Widget _buildAppointmentsList() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AppointmentError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        } else if (state is AppointmentLoaded) {
          final appointments = state.appointments;

          if (appointments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No appointments on ${DateFormat('MMMM d').format(_selectedDate)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add functionality to book a new appointment
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Book an Appointment'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                final appointmentTime = DateFormat('h:mm a').format(appointment.dateTime);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: AppointmentCard(
                    doctorName: appointment.doctorName,
                    specialty: appointment.specialty,
                    time: appointmentTime,
                    isVirtual: appointment.isVirtual == 1,
                    profilePic: appointment.profilePic ?? '',
                    onTap: () {
                      // Navigate to appointment details
                    },
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No appointments found.'));
        }
      },
    );
  }
}

