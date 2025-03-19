class CalendarDate {
  final DateTime date;
  final bool isSelected;

  CalendarDate({required this.date, this.isSelected = false});

  CalendarDate copyWith({DateTime? date, bool? isSelected}) {
    return CalendarDate(
      date: date ?? this.date,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}