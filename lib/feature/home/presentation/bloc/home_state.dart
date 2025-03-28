part of 'home_bloc.dart';

abstract class HomeState {}

class ActivityLoadingState extends HomeState{}

class TipsOfDayLoadingState extends HomeState{}

class HomeDataState extends HomeState{
  final double progress;
  final String tipOfDay;
  final DateTime selectedTime;
  final List<Activity> activities;
  final List<Activity> filterActivity;
  final String selectedChip;
  final String? activityError;
  final String? tipsOfDayError;
  final int completedActivity;
  final int totalActivity;

   HomeDataState({
      required this.progress ,
      required this.tipOfDay ,
      required this.selectedTime,
      required this.filterActivity,
      required this.activities,
      required this.selectedChip,
      required this.totalActivity,
      required this.completedActivity,
      this.activityError,
      this.tipsOfDayError
  });

  HomeDataState copyWith({
    double? progress,
    String? tipOfDay,
    DateTime? selectedTime,
    List<Activity>? activities,
    List<Activity>? filterActivity,
    String? selectedChip,
    String? activityError,
    String? tipsOfDayError,
    int? totalActivity,
    int? completedActivity,

  }) {
    return HomeDataState(
      progress: progress ?? this.progress,
      tipOfDay: tipOfDay ?? this.tipOfDay,
      selectedTime: selectedTime ?? this.selectedTime,
      activities: activities ?? this.activities,
      filterActivity: filterActivity ?? this.filterActivity,
      selectedChip: selectedChip ?? this.selectedChip,
      totalActivity: totalActivity ?? this.totalActivity,
      completedActivity: completedActivity ?? this.completedActivity,
      activityError:  activityError ?? this.activityError,
      tipsOfDayError: tipsOfDayError ?? this.tipsOfDayError
    );
  }

}
