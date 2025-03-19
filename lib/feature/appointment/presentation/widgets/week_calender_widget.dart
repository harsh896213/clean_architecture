import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyCalendarWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  // final Function(DateTime)? checkAppointments;

  const WeeklyCalendarWidget({
    Key? key,
    required this.onDateSelected,
    // this.checkAppointments,
  }) : super(key: key);

  @override
  State<WeeklyCalendarWidget> createState() => _WeeklyCalendarWidgetState();
}

class _WeeklyCalendarWidgetState extends State<WeeklyCalendarWidget> {
  late DateTime _selectedDate;
  late DateTime _today;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _selectedDate = _today;
    _pageController = PageController(initialPage: 0);

    // Notify parent about initial selected date
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onDateSelected(_selectedDate);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Generate 7 dates for a week starting from the given date
  List<DateTime> _generateWeekDates(DateTime startDate) {
    // Find the previous Sunday (or the current day if it's Sunday)
    final firstDayOfWeek = startDate.subtract(Duration(days: startDate.weekday % 7));
    return List.generate(7, (index) =>
        firstDayOfWeek.add(Duration(days: index)));
  }

  void _onPageChanged(int page) {
    // Update the selected date when page changes
    final newStartDate = _today.add(Duration(days: page * 7));
    setState(() {
      // Keep the selected date in the new week
      _selectedDate = newStartDate;
    });
    widget.onDateSelected(_selectedDate);
  }

  void _previousWeek() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextWeek() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title with the current month and year
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Text(
            DateFormat('MMMM yyyy').format(_selectedDate),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Calendar week view with navigation arrows
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[300]!),
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Row(
            children: [
              // Left arrow
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _previousWeek,
              ),

              // Calendar days
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, page) {
                    final startDate = _today.add(Duration(days: page * 7));
                    final weekDates = _generateWeekDates(startDate);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: weekDates.map((date) {
                        // Check if this date is selected
                        final isSelected = date.day == _selectedDate.day &&
                            date.month == _selectedDate.month &&
                            date.year == _selectedDate.year;

                        // Check if this date has appointments
                        final hasAppointments = false;

                        // Day of week abbreviation
                        final dayOfWeek = DateFormat('EEE').format(date).toUpperCase();

                        return Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedDate = date;
                              });
                              widget.onDateSelected(date);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Day of week
                                Text(
                                  dayOfWeek,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Date number in a circle
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected ? Colors.blue : Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: isSelected ? Colors.white : Colors.black,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),

                                // Appointment indicator dot
                                const SizedBox(height: 4),
                                if (hasAppointments)
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),

              // Right arrow
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _nextWeek,
              ),
            ],
          ),
        ),

        // Appointments for the selected date
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerLeft,
          child: Text(
            'Appointments for ${DateFormat('MMMM d, yyyy').format(_selectedDate)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

