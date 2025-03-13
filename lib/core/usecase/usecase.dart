
import 'package:fpdart/fpdart.dart';
import 'package:pva/core/network/api_error.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<ApiError, SuccessType>> call(Params params);
}

class NoParams {}
