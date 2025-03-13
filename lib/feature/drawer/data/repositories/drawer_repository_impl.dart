import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/network/connection_checker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pva/feature/drawer/data/datasources/drawer_remote_data_source.dart';
import 'package:pva/feature/drawer/domain/entities/drawer_config.dart';
import 'package:pva/feature/drawer/domain/repositories/drawer_repository.dart';


class DrawerRepositoryImpl implements DrawerRepository {
  final DrawerRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  DrawerRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<ApiError, DrawerConfig>> getDrawerConfiguration() async {
    if (await connectionChecker.isConnected) {
      final result = await remoteDataSource.getDrawerConfig();
      return result.fold(
        (error) => Left(error),
        (config) => Right(config),
      );
    } else {
      return Left(ApiError.network());
    }
  }
}
