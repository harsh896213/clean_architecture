
import 'package:fpdart/fpdart.dart';
import 'package:pva/core/common/entities/user.dart';
import 'package:pva/core/network/api_error.dart';

abstract interface class AuthRepository {
  Future<Either<ApiError, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<ApiError, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
