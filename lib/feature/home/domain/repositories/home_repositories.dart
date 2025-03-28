import 'package:fpdart/fpdart.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/feature/home/domain/entity/activity_entity.dart';

abstract class HomeRepositories{
  Future<Either<ApiError, List<Activity>>> getAllActivity(DateTime dateTime);

  Future<Either<ApiError, String>>todayQuotes (DateTime dateTime);

}