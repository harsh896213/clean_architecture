import 'package:pva/core/local/database/domain/database_repository.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/network/network_client.dart';
import 'package:pva/feature/home/data/model/home_data_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class HomeDataSource {
  Future<Either<ApiError, HomeDataModel>> getHomeData(int userId);
}

class HomeDataSourceImpl extends HomeDataSource {
  final NetworkClient networkClient;
  final DatabaseRepository databaseRepository;

  HomeDataSourceImpl(
      {required this.databaseRepository, required this.networkClient});

  @override
  Future<Either<ApiError, HomeDataModel>> getHomeData(int userId) async {
    try {
      final res = await networkClient.get<HomeDataModel>("apipath");
      return res.fold(
        (error) => Left(error),
        (success) => Right(success),
      );
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
