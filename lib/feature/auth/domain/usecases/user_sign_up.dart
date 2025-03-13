
import 'package:fpdart/fpdart.dart';
import 'package:pva/core/common/entities/user.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/usecase/usecase.dart';
import 'package:pva/feature/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<ApiError, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
