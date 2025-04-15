import 'ActivitySchedule.dart';

class ActivityItem {
  final String id;
  final String name;
  final ActivitySchedule schedule;

  ActivityItem({
    required this.id,
    required this.name,
    required this.schedule,
  });
}
