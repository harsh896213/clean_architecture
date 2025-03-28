import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pva/core/extension/date_time_ext.dart';
import 'package:pva/feature/home/domain/entity/activity_entity.dart';
import 'package:pva/feature/home/domain/usecases/activities.dart';
import 'package:pva/feature/home/domain/usecases/tipsofday.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Activities activities;
  final TipsOfDay tipsOfDay;

  HomeBloc({required this.tipsOfDay, required this.activities})
      : super(ActivityLoadingState()) {
    on<LoadActivities>(_onLoadHomeData);
    on<FilterTimeActivities>(_filterTimeActivities);
    on<NextSelectedTime>(_nextSelectedTime);
    on<PrevSelectedTime>(_prevSelectedTime);
    on<ActivityActionEvent>(_activityActionEvent);
  }

  void _onLoadHomeData(LoadActivities event, Emitter<HomeState> emit) async {
    var results = await Future.wait([
      activities(event.timeSlot),
      tipsOfDay(event.timeSlot),
    ]);

    var currentState = state is HomeDataState ? state as HomeDataState : null;

    String tipOfDay = currentState?.tipOfDay ?? "";
    List<Activity> activitiesList = currentState?.activities ?? [];
    String? activityError;
    String? tipError;

    results[0].fold(
      (error) => activityError = error.message, // Store error
      (success) {
        if (success is List<Activity>) {
          activitiesList = success; // Ensure success is a List<Activity>
        }
      },
    );

    results[1].fold(
      (error) => tipError = error.message, // Store error
      (success) {
        if (success is String) {
          tipOfDay = success; // Ensure success is a String (Tip of the Day)
        }
      },
    );

    emit(HomeDataState(
      progress: currentState?.progress ?? 0,
      tipOfDay: tipOfDay,
      filterActivity: activitiesList
          .where(
            (element) =>
                element.timeSlot == (currentState?.selectedChip ?? "Morning"),
          )
          .toList(),
      selectedChip: currentState?.selectedChip ?? "Morning",
      selectedTime: event.timeSlot,
      activities: activitiesList,
      totalActivity: activitiesList.length,
      completedActivity: activitiesList
          .where(
            (element) => element.activityState == ActivityState.completed,
          )
          .length,
      activityError: activityError,
      tipsOfDayError: tipError,
    ));
  }

  void _filterTimeActivities(
      FilterTimeActivities event, Emitter<HomeState> emit) async {
    if (state is! HomeDataState) return;

    var currentState = state as HomeDataState;

    var resultList = currentState.activities
        .where(
          (element) => element.timeSlot == event.time,
        )
        .toList();

    emit(currentState.copyWith(
        filterActivity: resultList, selectedChip: event.time));
  }

  void _nextSelectedTime(NextSelectedTime event, Emitter<HomeState> emit) {
    if (state is! HomeDataState) return;

    var homeDataState = state as HomeDataState;

    add(LoadActivities(homeDataState.selectedTime.nextDay));

    // emit(homeDataState.copyWith(selectedTime:homeDataState.selectedTime.nextDay));
  }

  void _prevSelectedTime(PrevSelectedTime event, Emitter<HomeState> emit) {
    if (state is! HomeDataState) return;

    var homeDataState = state as HomeDataState;

    add(LoadActivities(homeDataState.selectedTime.previousDay));

    // emit(homeDataState.copyWith(selectedTime:homeDataState.selectedTime.previousDay));
  }

  void _activityActionEvent(
      ActivityActionEvent event, Emitter<HomeState> emit) {
    if (state is! HomeDataState) return;

    var homeDataState = state as HomeDataState;

    var filterList = homeDataState.filterActivity.map(
      (e) {
        if (e.id == event.id) {
          e.activityState = event.activityState;
        }
        return e;
      },
    ).toList();

    var completedActivity = homeDataState.activities
        .where(
          (element) => element.activityState == ActivityState.completed,
        )
        .length;

    emit(homeDataState.copyWith(
        filterActivity: filterList,
        completedActivity: completedActivity,
        totalActivity: homeDataState.activities.length));
  }
}
