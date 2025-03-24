import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get toYMD => '$year-${_twoDigits(month)}-${_twoDigits(day)}';
  String get toHMS =>
      '${_twoDigits(hour)}:${_twoDigits(minute)}:${_twoDigits(second)}';
  String get toYMDHMS => '$toYMD $toHMS';

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool isSameMonth(DateTime other) =>
      year == other.year && month == other.month;

  bool isSameYear(DateTime other) => year == other.year;

  bool get isToday => isSameDay(DateTime.now());
  bool get isYestierday =>
      isSameDay(DateTime.now().subtract(const Duration(days: 1)));
  bool get isTomorrow => isSameDay(DateTime.now().add(const Duration(days: 1)));

  bool get isPast => isBefore(DateTime.now());
  bool get isFuture => isAfter(DateTime.now());

  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
  DateTime get startOfMonth => DateTime(year, month, 1);
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);
  DateTime get startOfYear => DateTime(year, 1, 1);
  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59, 999);

  DateTime addYears(int years) =>
      DateTime(year + years, month, day, hour, minute, second);
  DateTime addMonths(int months) =>
      DateTime(year, month + months, day, hour, minute, second);
  DateTime addWeeks(int weeks) => add(Duration(days: weeks * 7));
  DateTime addDays(int days) => add(Duration(days: days));
  DateTime get previousDay => subtract(const Duration(days: 1));
  DateTime get nextDay => add(const Duration(days: 1));


  int get minutesFromNow => difference(DateTime.now()).inMinutes;
  int get hoursFromNow => difference(DateTime.now()).inHours;
  int get daysFromNow => difference(DateTime.now()).inDays;

  String get getMonthDate => DateFormat.MMMd().format(this);

  // Relative time
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  // Week related
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;
  bool get isWeekday => !isWeekend;

  int get weekOfYear {
    final startOfYear = DateTime(year, 1, 1);
    final firstMonday = startOfYear.add(
      Duration(days: (8 - startOfYear.weekday) % 7),
    );
    final diff = difference(firstMonday);
    if (diff.isNegative) return 0;
    return (diff.inDays / 7).floor() + 1;
  }

  // Quarter related
  int get quarter => (month / 3).ceil();
  DateTime get startOfQuarter => DateTime(year, (quarter - 1) * 3 + 1, 1);
  DateTime get endOfQuarter {
    final lastMonth = quarter * 3;
    return DateTime(year, lastMonth + 1, 0, 23, 59, 59, 999);
  }

  // Basic date formatting using intl package

}
