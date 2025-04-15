import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/feature/profile/domain/entities/time_of_day.dart';

import '../../domain/entities/ActivitySchedule.dart';
import '../../domain/entities/acitivity_item.dart';
import '../../domain/entities/activity_category.dart';

abstract class DailyActivityEvent {}

class LoadDailyActivitiesEvent extends DailyActivityEvent {
  final DateTime date;

  LoadDailyActivitiesEvent(this.date);
}

class ToggleActivityStatusEvent extends DailyActivityEvent {
  final String activityId;
  final PartOfDay timeOfDay;
  final bool isChecked;

  ToggleActivityStatusEvent({
    required this.activityId,
    required this.timeOfDay,
    required this.isChecked,
  });
}

class ChangeDateEvent extends DailyActivityEvent {
  final DateTime date;

  ChangeDateEvent(this.date);
}

abstract class DailyActivityState {}

class DailyActivityInitial extends DailyActivityState {}

class DailyActivityLoading extends DailyActivityState {}

class DailyActivityLoaded extends DailyActivityState {
  final DateTime selectedDate;
  final List<ActivityCategory> categories;

  DailyActivityLoaded({
    required this.selectedDate,
    required this.categories,
  });

  DailyActivityLoaded copyWith({
    DateTime? selectedDate,
    List<ActivityCategory>? categories,
  }) {
    return DailyActivityLoaded(
      selectedDate: selectedDate ?? this.selectedDate,
      categories: categories ?? this.categories,
    );
  }
}

class DailyActivityError extends DailyActivityState {
  final String message;

  DailyActivityError(this.message);
}

class DailyActivityBloc extends Bloc<DailyActivityEvent, DailyActivityState> {
  DailyActivityBloc() : super(DailyActivityInitial()) {
    on<LoadDailyActivitiesEvent>(_onLoadDailyActivities);
    on<ToggleActivityStatusEvent>(_onToggleActivityStatus);
    on<ChangeDateEvent>(_onChangeDate);
  }

  void _onLoadDailyActivities(
      LoadDailyActivitiesEvent event,
      Emitter<DailyActivityState> emit,
      ) async {
    emit(DailyActivityLoading());

    try {
      final categories = _getMockData();

      emit(DailyActivityLoaded(
        selectedDate: event.date,
        categories: categories,
      ));
    } catch (e) {
      emit(DailyActivityError('Failed to load activities: $e'));
    }
  }

  void _onToggleActivityStatus(
      ToggleActivityStatusEvent event,
      Emitter<DailyActivityState> emit,
      ) {
    if (state is DailyActivityLoaded) {
      final currentState = state as DailyActivityLoaded;

      // Create a deep copy of categories and update the specific activity
      final updatedCategories = currentState.categories.map((category) {
        final updatedActivities = category.activities.map((activity) {
          if (activity.id == event.activityId) {
            // Create a new schedule with the updated status
            ActivitySchedule updatedSchedule;

            switch (event.timeOfDay) {
              case PartOfDay.morning:
                updatedSchedule = ActivitySchedule(
                  morning: event.isChecked,
                  morningTime: event.isChecked ? '00:00AM' : null,
                  afternoon: activity.schedule.afternoon,
                  afternoonTime: activity.schedule.afternoonTime,
                  evening: activity.schedule.evening,
                  eveningTime: activity.schedule.eveningTime,
                  night: activity.schedule.night,
                  nightTime: activity.schedule.nightTime,
                );
                break;
              case PartOfDay.afternoon:
                updatedSchedule = ActivitySchedule(
                  morning: activity.schedule.morning,
                  morningTime: activity.schedule.morningTime,
                  afternoon: event.isChecked,
                  afternoonTime: event.isChecked ? '00:00AM' : null,
                  evening: activity.schedule.evening,
                  eveningTime: activity.schedule.eveningTime,
                  night: activity.schedule.night,
                  nightTime: activity.schedule.nightTime,
                );
                break;
              case PartOfDay.evening:
                updatedSchedule = ActivitySchedule(
                  morning: activity.schedule.morning,
                  morningTime: activity.schedule.morningTime,
                  afternoon: activity.schedule.afternoon,
                  afternoonTime: activity.schedule.afternoonTime,
                  evening: event.isChecked,
                  eveningTime: event.isChecked ? '00:00AM' : null,
                  night: activity.schedule.night,
                  nightTime: activity.schedule.nightTime,
                );
                break;
              case PartOfDay.night:
                updatedSchedule = ActivitySchedule(
                  morning: activity.schedule.morning,
                  morningTime: activity.schedule.morningTime,
                  afternoon: activity.schedule.afternoon,
                  afternoonTime: activity.schedule.afternoonTime,
                  evening: activity.schedule.evening,
                  eveningTime: activity.schedule.eveningTime,
                  night: event.isChecked,
                  nightTime: event.isChecked ? '00:00AM' : null,
                );
                break;
            }

            return ActivityItem(
              id: activity.id,
              name: activity.name,
              schedule: updatedSchedule,
            );
          }
          return activity;
        }).toList();

        return ActivityCategory(
          id: category.id,
          name: category.name,
          activities: updatedActivities,
        );
      }).toList();

      emit(DailyActivityLoaded(
        selectedDate: currentState.selectedDate,
        categories: updatedCategories,
      ));
    }
  }

  void _onChangeDate(
      ChangeDateEvent event,
      Emitter<DailyActivityState> emit,
      ) {
    // Trigger a reload of activities for the new date
    add(LoadDailyActivitiesEvent(event.date));
  }

  // Mock data method - replace with real data fetching in production
  List<ActivityCategory> _getMockData() {
    return [
      ActivityCategory(
        id: '1',
        name: 'Medications',
        activities: [
          ActivityItem(
            id: '101',
            name: 'Take your pain medication as directed',
            schedule: ActivitySchedule(
              evening: true,
              eveningTime: '00:00AM',
            ),
          ),
        ],
      ),
      ActivityCategory(
        id: '2',
        name: 'Physical Activity',
        activities: [
          ActivityItem(
            id: '201',
            name: 'Complete the prescribed physical activity',
            schedule: ActivitySchedule(
              evening: true,
              eveningTime: '00:00AM',
            ),
          ),
          ActivityItem(
            id: '202',
            name: 'Complete your prescribed physical activity',
            schedule: ActivitySchedule(
              afternoon: true,
              afternoonTime: '00:00AM',
            ),
          ),
        ],
      ),
      ActivityCategory(
        id: '3',
        name: 'Survey',
        activities: [
          ActivityItem(
            id: '301',
            name: 'Tell Us About Your Physical Therapy Daily Exercise',
            schedule: ActivitySchedule(
              evening: true,
              eveningTime: '06:00PM',
            ),
          ),
          ActivityItem(
            id: '302',
            name: 'Enter Your Pain Level',
            schedule: ActivitySchedule(
              morning: true,
              morningTime: '00:00AM',
              night: true,
              nightTime: '08:00PM',
            ),
          ),
          ActivityItem(
            id: '303',
            name: 'Tell Us About Your Pain Medication',
            schedule: ActivitySchedule(
              morning: true,
              morningTime: '00:00AM',
            ),
          ),
          ActivityItem(
            id: '304',
            name: 'Tell Us About Your Anti-inflammatory Diet',
            schedule: ActivitySchedule(
              evening: true,
              eveningTime: '00:00AM',
            ),
          ),
          ActivityItem(
            id: '305',
            name: 'Functional Capability Survey',
            schedule: ActivitySchedule(
              evening: true,
              eveningTime: '00:00AM',
            ),
          ),
        ],
      ),
      ActivityCategory(
        id: '4',
        name: 'Tasks',
        activities: [
          ActivityItem(
            id: '401',
            name: 'Add Anti-Inflammatory foods to your meal',
            schedule: ActivitySchedule(
              evening: true,
              eveningTime: '00:00AM',
            ),
          ),
        ],
      ),
    ];
  }
}
