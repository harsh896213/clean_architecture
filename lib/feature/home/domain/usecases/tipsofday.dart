import 'package:fpdart/src/either.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/usecase/usecase.dart';
import 'package:pva/feature/home/domain/repositories/home_repositories.dart';

class TipsOfDay implements UseCase<String, DateTime>{
  final HomeRepositories homeRepositories;

  TipsOfDay({required this.homeRepositories});

  @override
  Future<Either<ApiError, String>> call(DateTime params) {
    return homeRepositories.todayQuotes(params);
  }

}