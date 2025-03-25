import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/get_it.dart';
import '../bloc/appointment_state.dart';
import '../bloc/appoitment_bloc.dart';
import '../bloc/appoitment_event.dart';
import '../widgets/appointment_card.dart';
import '../widgets/weekly_calender.dart';

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
        context.read<AppointmentBloc>().add(FetchAppointments(_selectedDate)));
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
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WeeklyCalendarWidget(
              onDateSelected: _onDateSelected,
              selectedDate: _selectedDate,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
              child: Text(
                'Appointments for ${DateFormat('MMMM d, yyyy').format(_selectedDate)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: _buildAppointmentsList(),
            ),
          ],
        ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      backgroundColor: const Color(0xFF4285F4),
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                final appointmentTime =
                    DateFormat('h:mm a').format(appointment.dateTime);

                // Determine button properties based on appointment type
                final isVirtual = appointment.isVirtual == 1;
                final buttonText = isVirtual ? 'Join Call' : 'Get Directions';
                final buttonColor = isVirtual
                    ? const Color(0xFF4285F4) // Blue for virtual
                    : const Color(0xFFF9A825); // Orange for in-person

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: AppointmentCard(
                    doctorName: appointment.doctorName,
                    specialty: appointment.specialty,
                    time: appointmentTime,
                    isVirtual: isVirtual,
                    profilePic: appointment.profilePic ?? '',
                    onTap: () {
                      // Handle tap based on appointment type
                      if (isVirtual) {
                        // Launch video call
                      } else {
                        // Open map/directions
                      }
                    },
                    buttonColor: buttonColor,
                    buttonText: buttonText,
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
