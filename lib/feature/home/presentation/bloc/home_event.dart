part of 'home_bloc.dart';


abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class NextSelectedTime extends HomeEvent {

  const NextSelectedTime();

  @override
  List<Object?> get props => [];
}

class PrevSelectedTime extends HomeEvent {

  const PrevSelectedTime();

  @override
  List<Object?> get props => [];
}

class ActivityActionEvent extends HomeEvent{
  final String id;
  final ActivityState activityState;

  const ActivityActionEvent({required this.activityState, required this.id});
}

class UpdateProgress extends HomeEvent {
  final double progress;

  const UpdateProgress(this.progress);

  @override
  List<Object?> get props => [progress];
}

class FilterTimeActivities extends HomeEvent{
  final String time;

  FilterTimeActivities({required this.time});
}

class LoadActivities extends HomeEvent {
  final DateTime timeSlot;

  const LoadActivities(this.timeSlot);

  @override
  List<Object?> get props => [timeSlot];
}

class LoadTipsOfDay extends HomeEvent {
  final DateTime timeSlot;

  const LoadTipsOfDay(this.timeSlot);

  @override
  List<Object?> get props => [timeSlot];
}

