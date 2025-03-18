import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime selectedDate;

  const CalendarWidget({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMonthHeader(),
        _buildWeekDaysRow(),
        _buildCalendarGrid(),
      ],
    );
  }

  Widget _buildMonthHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'March 2025',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildWeekDaysRow() {
    return Row(
      children: ['TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN', 'MON']
          .map((day) => Expanded(
        child: Center(
          child: Text(
            day,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ))
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    List<Widget> days = [];
    int startDay = 2; // Tuesday

    for (int i = 0; i < startDay; i++) {
      days.add(Container());
    }

    for (int day = 1; day <= 31; day++) {
      days.add(
        Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              color: day == selectedDate.day ? Colors.blue : Colors.black,
              fontWeight: day == selectedDate.day ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: days,
    );
  }
}