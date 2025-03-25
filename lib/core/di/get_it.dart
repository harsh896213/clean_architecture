import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pva/core/network/connection_checker.dart';
import 'package:pva/core/network/network_client.dart';
import 'package:pva/core/network/networkClient_impl.dart';
import 'package:pva/feature/appointment/data/datasources/appointment_local_data_source.dart';
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

import '../../feature/appointment/data/repositories/appointment_repository_impl.dart';
import '../../feature/appointment/domain/repository/appointment_repository.dart';
import '../../feature/appointment/presentation/bloc/appoitment_bloc.dart';
import '../../feature/chat/data/datasources/local_chat_data_source_impl.dart';
import '../../feature/chat/data/repositories/chat_repository_impl.dart';
import '../../feature/chat/domain/repository/chat_repository.dart';
import '../../feature/chat/presentation/bloc/chat/chat_bloc.dart';
import '../local/database/data/database_helper.dart';

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

  final databaseHelper = DatabaseHelper();
  await databaseHelper.getDatabase();
  getIt.registerSingleton<DatabaseHelper>(databaseHelper);

  // Data Source
  getIt.registerLazySingleton<ChatLocalDataSource>(
        () => ChatLocalDataSourceImpl(databaseHelper: getIt()),
  );

  getIt.registerLazySingleton<AppointmentLocalDataSource>(() => AppointmentLocalDataSourceImpl(databaseHelper: getIt()));

  getIt.registerLazySingleton<AppointmentRepository>(
        () => AppointmentRepositoryImpl(localDataSource: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImpl(localDataSource: getIt()),
  );

  // BLoC
  getIt.registerFactory(() => ChatBloc(getIt<ChatRepository>()));

  getIt.registerFactory<AppointmentBloc>(
          () => AppointmentBloc(repository: getIt()));

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
