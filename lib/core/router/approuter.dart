import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/core/router/route_observer.dart';
import 'package:pva/core/router/stateful_shell_route.dart';
import 'package:pva/feature/assistant/presentation%20/assistant_page.dart';
import 'package:pva/feature/auth/presentation/pages/login_page.dart';
import 'package:pva/feature/auth/presentation/pages/signup_page.dart';
import 'package:pva/feature/home/presentation/details_page.dart';
import 'package:pva/feature/splash/bloc/test_bloc.dart';
import 'package:pva/feature/splash/splash_page.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

GoRouter goRouter = GoRouter(
  errorBuilder: (context, state) => SizedBox(),
  redirect: (context, state) {
    debugPrint("Current uri ${state.uri}");
    return null;
  },
  navigatorKey: navigationKey,
  observers: [routeObserver],
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => BlocProvider(
        create: (context) => TestBloc(),
        child: SplashPage(),
      ),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: "/assistant",
      builder: (context, state) => AssistantPage(),
    ),
    GoRoute(
      path: "/signUp",
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: "/details",
      builder: (context, state) => DetailsPage(),
    ),
    stateFulShellRoute()
  ],
);
