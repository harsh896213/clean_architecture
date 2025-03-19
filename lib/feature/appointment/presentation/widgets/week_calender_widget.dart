import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekCalendar extends StatefulWidget {
  final DateTime currentDate; // Current date passed from the parent
  final Function(DateTime) onDateSelected; // Callback for date selection

  const WeekCalendar({
    super.key,
    required this.currentDate,
    required this.onDateSelected,
  });

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  late DateTime _selectedDate;
  late ScrollController _scrollController;
  final double _itemWidth = 80.0; // Width of each day cell

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.currentDate; // Initialize with the current date
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelectedDate());
  }

  // Scroll to the selected date when the widget is first built
  void _scrollToSelectedDate() {
    final offset = (_selectedDate.weekday - 1) * _itemWidth;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // Handle scroll end event to snap to the nearest date
  void _handleScrollEnd() {
    final scrollOffset = _scrollController.offset;
    final index = (scrollOffset / _itemWidth).round();
    final newDate = _getDateForIndex(index);

    if (newDate != _selectedDate) {
      setState(() => _selectedDate = newDate);
      widget.onDateSelected(newDate); // Notify parent of the new selected date
    }
  }

  // Handle date selection when a day is clicked
  void _handleDateClick(DateTime date) {
    setState(() => _selectedDate = date);
    widget.onDateSelected(date); // Notify parent of the new selected date
    _scrollToSelectedDate(); // Scroll to the selected date
  }

  // Get the date for a specific index in the list
  DateTime _getDateForIndex(int index) {
    // Calculate the start of the week (Monday)
    final startOfWeek = widget.currentDate.subtract(Duration(days: widget.currentDate.weekday - 1));
    // Return the date for the given index
    return startOfWeek.add(Duration(days: index));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            _handleScrollEnd();
          }
          return false;
        },
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemExtent: _itemWidth,
          itemBuilder: (context, index) {
            final date = _getDateForIndex(index);
            final isSelected = date == _selectedDate;
            return _DayCell(
              date: date,
              isSelected: isSelected,
              onTap: () => _handleDateClick(date),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _DayCell extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const _DayCell({
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle date click
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('E').format(date), // Day of the week (e.g., Mon, Tue)
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            Text(
              date.day.toString(), // Day of the month
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}