import 'package:fpdart/fpdart.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/feature/drawer/domain/entities/drawer_config.dart';

abstract class DrawerRepository {
  Future<Either<ApiError,DrawerConfig>> getDrawerConfiguration();
}
