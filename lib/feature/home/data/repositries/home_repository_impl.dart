import 'package:fpdart/src/either.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/feature/home/domain/entity/activity_entity.dart';
import 'package:pva/feature/home/domain/repositories/home_repositories.dart';
class HomeRepositoriesImpl implements HomeRepositories{

  @override
  Future<Either<ApiError, List<Activity>>> getAllActivity(DateTime dateTime) async{
    return Right([
      Activity(
      id: '1',
      title: 'Morning Walk ${dateTime.day}',
      description: '30 minutes morning walk in the park',
      startTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 0),
      endTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 30),
      timeSlot: 'Morning',
      type: ActivityType.exercise,
    ),
      Activity(
        id: '2',
        title: 'Take Medication${dateTime.day}',
        description: 'Morning medication after breakfast',
        startTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 0),
        endTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 30),
        timeSlot: 'Morning',
        type: ActivityType.medication,
      ),
      Activity(
        id: '3',
        title: 'Take Medication ${dateTime.day}',
        description: 'Weekly therapy session',
        startTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 0),
        endTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 30),
        timeSlot: 'Afternoon',
        type: ActivityType.medication,
      ),
      Activity(
        id: '4',
        title: 'Physical Therapy ${dateTime.day}',
        description: 'Weekly therapy session',
        startTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 0),
        endTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 30),
        timeSlot: 'Afternoon',
        type: ActivityType.therapy,
      ),
      Activity(
        id: '5',
        title: 'Doctor Appointment ${dateTime.day}',
        description: 'Regular checkup with Dr. Smith',
        startTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 0),
        endTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 30),
        timeSlot: 'Evening',
        type: ActivityType.appointment,
      ),
      Activity(
        id: '6',
        title: 'Evening Meditation ${dateTime.day}',
        description: '15 minutes mindfulness session',
        startTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 0),
        endTime: DateTime(dateTime.year, dateTime.month, dateTime.day, 7, 30),
        timeSlot: 'Night',
        type: ActivityType.medication,
      ),
    ]);
  }

  @override
  Future<Either<ApiError, String>> todayQuotes(DateTime dateTime) async {
    return Right("Stay positive every day counts toward better positive ");
  }
}
