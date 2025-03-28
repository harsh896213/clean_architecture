import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String timeSlot;
  ActivityState activityState;
  final ActivityType type;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.timeSlot,
    this.activityState = ActivityState.noActivity,
    required this.type,
  });

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? timeSlot,
    bool? isCompleted,
    ActivityType? type,
    ActivityState? activityState,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timeSlot: timeSlot ?? this.timeSlot,
      activityState: activityState ?? this.activityState,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    startTime,
    endTime,
    timeSlot,
    activityState,
    type,
  ];
}

enum ActivityType {
  exercise,
  medication,
  appointment,
  therapy,
  survey,
  other;

  String get displayName {
    switch (this) {
      case ActivityType.exercise:
        return 'Exercise';
      case ActivityType.medication:
        return 'Medication';
      case ActivityType.appointment:
        return 'Appointment';
      case ActivityType.therapy:
        return 'Therapy';
      case ActivityType.survey:
        return 'Survey';
      case ActivityType.other:
        return 'Other';
    }
  }
}

enum ActivityState{
  completed,
  notCompleted,
  noActivity
}


