import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pva/core/extension/context_ext.dart';

class WeeklyCalendarWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime selectedDate;

  const WeeklyCalendarWidget({
    super.key,
    required this.onDateSelected,
    required this.selectedDate,
  });

  @override
  _WeeklyCalendarWidgetState createState() => _WeeklyCalendarWidgetState();
}

class _WeeklyCalendarWidgetState extends State<WeeklyCalendarWidget> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late DateTime _today;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _pageController = PageController(initialPage: 0);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Generate dates based on device size
  List<DateTime> _generateDates(DateTime startDate, int daysToShow) {
    final firstDayOfWeek = startDate.subtract(Duration(days: startDate.weekday % 7));
    return List.generate(daysToShow, (index) => firstDayOfWeek.add(Duration(days: index)));
  }

  void _onPageChanged(int page) {
    _animationController.reset();
    _animationController.forward();

    setState(() {
      _currentPage = page;
    });

    // Get the number of days to show based on screen size
    final daysToShow = _getDaysToShow(context);

    // Update the selected date when page changes
    final newStartDate = _today.add(Duration(days: page * daysToShow));
    widget.onDateSelected(newStartDate);
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  int _getDaysToShow(BuildContext context) {
    if (context.isDesktop) {
      return 14;
    } else if (context.isTablet) {
      return 10;
    } else {
      return 7;
    }
  }

  Widget _buildDayItem(DateTime date, bool isSelected, double itemWidth) {
    // Day of week abbreviation
    final dayOfWeek = DateFormat('EEE').format(date).toUpperCase();
    final isToday = date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year;

    return Container(
      width: itemWidth,
      child: GestureDetector(
        onTap: () {
          widget.onDateSelected(date);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Day of week
              Text(
                dayOfWeek,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),

              // Date number in a circle
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : (isToday ? Colors.grey[200] : Colors.transparent),
                  border: isToday && !isSelected
                      ? Border.all(color: Theme.of(context).primaryColor, width: 1.5)
                      : null,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Colors.white
                          : (isToday ? Theme.of(context).primaryColor : Colors.black87),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the number of days to show based on screen size
    final daysToShow = _getDaysToShow(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          // Month and year header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Month and year
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildDateRangeText(daysToShow),
                ),

                // Navigation buttons
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 28),
                      onPressed: _previousPage,
                      splashRadius: 24,
                      tooltip: 'Previous period',
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 28),
                      onPressed: _nextPage,
                      splashRadius: 24,
                      tooltip: 'Next period',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Calendar days
          SizedBox(
            height: 100,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, page) {
                final startDate = _today.add(Duration(days: page * daysToShow));
                final dates = _generateDates(startDate, daysToShow);

                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = constraints.maxWidth / (constraints.maxWidth < 700 ? 7 : daysToShow);

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: constraints.maxWidth < 700 ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: dates.map((date) {
                            // Check if this date is selected
                            final isSelected = date.day == widget.selectedDate.day &&
                                date.month == widget.selectedDate.month &&
                                date.year == widget.selectedDate.year;

                            return _buildDayItem(date, isSelected, itemWidth);
                          }).toList(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
        ],
      ),
    );
  }

  Widget _buildDateRangeText(int daysToShow) {
    final startDate = _today.add(Duration(days: _currentPage * daysToShow));
    final endDate = startDate.add(Duration(days: daysToShow - 1));

    // If the range spans multiple months
    if (startDate.month != endDate.month || startDate.year != endDate.year) {
      return Text(
        "${DateFormat('MMM d').format(startDate)} - ${DateFormat('MMM d, yyyy').format(endDate)}",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      // If the range is within the same month
      return Text(
        DateFormat('MMMM yyyy').format(startDate),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}