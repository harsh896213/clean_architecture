import 'package:pva/feature/home/domain/entity/activity.dart';

class HomePageEntity{
  final List<Activity> allActivities;
  final String tipsOfDay;

  HomePageEntity({required this.allActivities, required this.tipsOfDay});
}