import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pva/core/network/connection_checker.dart';
import 'package:pva/core/network/network_client.dart';
import 'package:pva/core/network/networkClient_impl.dart';
import 'package:pva/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:pva/feature/auth/domain/repository/auth_repository.dart';
import 'package:pva/feature/auth/domain/usecases/user_login.dart';
import 'package:pva/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:pva/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:pva/feature/drawer/data/datasources/drawer_remote_data_source.dart';
import 'package:pva/feature/drawer/data/repositories/drawer_repository_impl.dart';
import 'package:pva/feature/drawer/domain/repositories/drawer_repository.dart';
import 'package:pva/feature/drawer/domain/usecases/get_drawer_config.dart';
import 'package:pva/feature/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:pva/feature/drawer/presentation/bloc/drawer_event.dart';
import 'package:pva/feature/home/data/repositries/home_repository_impl.dart';
import 'package:pva/feature/home/domain/repositories/home_repositories.dart';
import 'package:pva/feature/home/domain/usecases/activities.dart';
import 'package:pva/feature/home/domain/usecases/tipsofday.dart';
import 'package:pva/feature/home/presentation/bloc/home_bloc.dart';
import 'package:pva/feature/library%20/data/datasources/library_datasource.dart';
import 'package:pva/feature/library%20/data/repositories/library_repository_impl.dart';
import 'package:pva/feature/library%20/domain/repository/library_repository.dart';
import 'package:pva/feature/library%20/domain/usecases/library_usecase.dart';
import 'package:pva/feature/library%20/presentation/bloc/library_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<InternetConnection>(
    () => InternetConnection(),
  );

  getIt.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(getIt()),
  );

  getIt.registerLazySingleton<Dio>(
    () {
      final dio = Dio();
      // Add any dio configurations here
      dio.options.baseUrl = ''; // Replace with your API base URL
      dio.options.connectTimeout = const Duration(seconds: 5);
      dio.options.receiveTimeout = const Duration(seconds: 3);
      return dio;
    },
  );

  getIt.registerLazySingleton<NetworkClient>(
    () => NetworkClientImpl(getIt()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton(
    () => UserLogin(getIt()),
  );

  getIt.registerFactory(
    () => UserSignUp(getIt()),
  );

  getIt.registerLazySingleton(
    () => AuthBloc(
      userSignUp: getIt(),
      userLogin: getIt(),
      appUserCubit: getIt(),
    ),
  );

  await _setupLibrary();
  await _setupHome();

  getIt.registerLazySingleton<DrawerRemoteDataSource>(
    () => DrawerRemoteDataSourceImpl(
      client: getIt(),
      baseUrl: getIt<Dio>().options.baseUrl,
    ),
  );

  getIt.registerLazySingleton<DrawerRepository>(
    () => DrawerRepositoryImpl(
      remoteDataSource: getIt(),
      connectionChecker: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetDrawerConfig(getIt()),
  );

  getIt.registerFactory(
    () => DrawerBloc(getDrawerConfig: getIt())..add(LoadDrawerConfig()),
  );
}

Future<void> _setupLibrary() async {
  getIt
    ..registerLazySingleton<LibraryDataSource>(() => LibraryDataSourceImpl())
    ..registerLazySingleton<LibraryRepository>(
        () => LibraryRepositoriesImpl(getIt(), getIt()))
    ..registerLazySingleton(() => LibraryUseCase(getIt()))
    ..registerFactoryParam(
      (context, _) => LibraryBloc(libraryUseCase: getIt()),
    );
}

Future<void> _setupHome() async {
  getIt
    ..registerLazySingleton<HomeRepositories>(
        () => HomeRepositoriesImpl())
    ..registerLazySingleton(() => Activities( homeRepositories: getIt()))
    ..registerLazySingleton(() => TipsOfDay( homeRepositories: getIt()))
    ..registerFactoryParam(
      (context, _) => HomeBloc( tipsOfDay: getIt(), activities: getIt()),
    );
}
