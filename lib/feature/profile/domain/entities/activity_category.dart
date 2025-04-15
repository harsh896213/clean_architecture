import 'acitivity_item.dart';

class ActivityCategory {
  final String id;
  final String name;
  final List<ActivityItem> activities;

  ActivityCategory({
    required this.id,
    required this.name,
    required this.activities,
  });
}