import 'package:flutter/material.dart';
import 'package:pva/core/di/get_it.dart';
import 'package:pva/core/router/approuter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/feature/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/theme/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  ///sentry initialisation
  // await SentryService().init(
  //   dsn: 'YOUR_SENTRY_DSN',
  //   environment: kDebugMode ? 'development' : 'production',
  //   release: '1.0.0+1', // Use your app's version
  // );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<DrawerBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PVA',
      theme: AppTheme.lightThemeMode,
      routerConfig: goRouter,
    );
  }
}
