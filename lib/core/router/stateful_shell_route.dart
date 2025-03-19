import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/core/widgets/drawer_builder.dart';
import 'package:pva/core/widgets/scaffold_with_bottom_navbar.dart';
import 'package:pva/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:pva/feature/chat/presentation/pages/master_detail_chat_page.dart';
import 'package:pva/feature/drawer/data/models/drawer_config_model.dart';
import 'package:pva/feature/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:pva/feature/drawer/presentation/bloc/drawer_state.dart';
import 'package:pva/feature/home/presentation/home_page.dart';
import 'package:pva/feature/home/presentation/medication_page.dart';
import 'package:pva/feature/home/presentation/settings_page.dart';

import '../../feature/appointment/presentation/pages/appointment_page.dart';

RouteBase stateFulShellRoute() => StatefulShellRoute(
  builder: (context, state, navigationShell) {
    return navigationShell;
  },
  navigatorContainerBuilder: (context, navigationShell, children) {
    return BlocBuilder<DrawerBloc, DrawerState>(
      builder: (context, state) {
        if (state is DrawerInitial) {
          return ScaffoldWithBottomNavBar(
            navigationShell: navigationShell,
            children: children,
          );
        } else if (state is DrawerLoading) {
          return ScaffoldWithBottomNavBar(
            navigationShell: navigationShell,
            children: children,
          );
        } else if (state is DrawerLoaded) {
          return ScaffoldWithBottomNavBar(
            navigationShell: navigationShell,
            children: children,
            drawer: state.config.showDrawer
                ? DrawerBuilder(items: state.config.drawerItems ?? [])
                : null,
            endDrawer: state.config.showEndDrawer
                ? DrawerBuilder(items: state.config.endDrawerItems ?? [])
                : null,
          );
        } else if (state is DrawerError) {
          return ScaffoldWithBottomNavBar(
            navigationShell: navigationShell,
            children: children,
            drawer: DrawerBuilder(
                items: DrawerConfigModel.fromJson({
                  "showDrawer": true,
                  "showEndDrawer": false,
                  "drawerItems": [
                    {
                      "title": "Profile",
                      "iconName": "person",
                      "route": "/profile"
                    },
                    {
                      "title": "Notifications",
                      "iconName": "notifications",
                      "route": "/notifications"
                    },
                    {
                      "title": "Help & Support",
                      "iconName": "help",
                      "route": "/support"
                    },
                    {
                      "title": "About",
                      "iconName": "info",
                      "route": "/about"
                    }
                  ],
                  "endDrawerItems": [

                  ],
                }).drawerItems ??
                    []),
          );
        }
        return ScaffoldWithBottomNavBar(
          navigationShell: navigationShell,
          children: children,
        );
      },
    );
  },
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/medication',
          builder: (context, state) {
            final DateTime today = DateTime.now();
            return AppointmentPage(selectedDate: today);
          },
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/appointments',
          builder: (context, state) {
            final DateTime today = DateTime.now();
            return AppointmentPage(selectedDate: today);
          },
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/chat',
          builder: (context, state) => const MasterDetailChatPage(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
