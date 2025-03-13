
import 'package:fpdart/fpdart.dart';
import 'package:pva/core/common/entities/user.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/usecase/usecase.dart';
import 'package:pva/feature/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<ApiError, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
