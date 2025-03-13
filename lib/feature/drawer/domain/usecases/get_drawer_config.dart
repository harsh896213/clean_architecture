import 'package:fpdart/fpdart.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/feature/drawer/domain/entities/drawer_config.dart';
import 'package:pva/feature/drawer/domain/repositories/drawer_repository.dart';

class GetDrawerConfig {
  final DrawerRepository repository;

  GetDrawerConfig(this.repository);

  Future<Either<ApiError, DrawerConfig >> call() async {
    return await repository.getDrawerConfiguration();
  }
}
