extension StringExtension on String {
  String get capitalize => "${this[0].toUpperCase()}${substring(1)}";

  String get titleCase => split(' ').map((word) => word.capitalize).join(' ');

  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isValidPhone => RegExp(r'^\+?[\d-]{10,}$').hasMatch(this);

  String get removeSpaces => replaceAll(' ', '');

  bool get isNumeric => num.tryParse(this) != null;

  String truncate(int length) =>
      length < this.length ? '${substring(0, length)}...' : this;

  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }
}
