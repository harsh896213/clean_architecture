import 'package:fpdart/src/either.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/usecase/usecase.dart';
import 'package:pva/feature/home/domain/entity/activity.dart';
import 'package:pva/feature/home/domain/repositories/home_repositories.dart';

class Activities implements UseCase<List<Activity>, DateTime>{
  final  HomeRepositories homeRepositories;

  Activities({required this.homeRepositories});

  @override
  Future<Either<ApiError, List<Activity>>> call(DateTime params) {
    return homeRepositories.getAllActivity(params);
  }

}