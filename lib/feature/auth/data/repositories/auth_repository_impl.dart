
import 'package:fpdart/fpdart.dart';
import 'package:pva/core/common/entities/user.dart';
import 'package:pva/core/constants/constants.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/network/connection_checker.dart';
import 'package:pva/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pva/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<ApiError, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<ApiError, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<ApiError, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(ApiError(message:Constants.noConnectionErrorMessage));
      }
      final user = await fn();

      return right(user);
    }  catch (e) {
      return left(ApiError(message:e.toString()));
    }
  }
}
