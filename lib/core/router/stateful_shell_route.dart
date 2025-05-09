import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/core/common/widgets/button/button_factory.dart';
import 'package:pva/core/di/get_it.dart';
import 'package:pva/core/widgets/scaffold_with_bottom_navbar.dart';
import 'package:pva/feature/chat/presentation/pages/master_detail_chat_page.dart';
import 'package:pva/feature/home/presentation/bloc/home_bloc.dart';
import 'package:pva/feature/home/presentation/pages/home_page.dart';
import 'package:pva/feature/library%20/presentation/bloc/library_bloc.dart';
import 'package:pva/feature/library%20/presentation/pages/library_page.dart';
import 'package:pva/feature/library%20/presentation/pages/video_player_screen.dart';

import '../../feature/appointment/presentation/pages/appointment_page.dart';

RouteBase stateFulShellRoute() => StatefulShellRoute(
  builder: (context, state, navigationShell) {
    return navigationShell;
  },
  navigatorContainerBuilder: (context, navigationShell, children) {
    return ScaffoldWithBottomNavBar(navigationShell: navigationShell, children: children);
    // return BlocBuilder<DrawerBloc, DrawerState>(
    //   builder: (context, state) {
    //     final String appBarTitle = _getAppBarTitle(navigationShell.currentIndex);
    //
    //     if (state is DrawerInitial) {
    //       return ScaffoldWithBottomNavBar(
    //         navigationShell: navigationShell,
    //         children: children,
    //       );
    //     }
    //     else if (state is DrawerLoading) {
    //       return ScaffoldWithBottomNavBar(
    //         navigationShell: navigationShell,
    //         children: children,
    //       );
    //     } else if (state is DrawerLoaded) {
    //       return ScaffoldWithBottomNavBar(
    //         navigationShell: navigationShell,
    //         children: children,
    //         appBar: CustomAppBar(title: appBarTitle,
    //         actions:  _getAppBarActions(context,navigationShell.currentIndex)),
    //         drawer: state.config.showDrawer
    //             ? DrawerBuilder(items: state.config.drawerItems ?? [])
    //             : null,
    //         endDrawer: state.config.showEndDrawer
    //             ? DrawerBuilder(items: state.config.endDrawerItems ?? [])
    //             : null,
    //       );
    //     } else if (state is DrawerError) {
    //       return ScaffoldWithBottomNavBar(
    //         navigationShell: navigationShell,
    //         children: children,
    //         drawer: DrawerBuilder(
    //             items: DrawerConfigModel.fromJson({
    //               "showDrawer": true,
    //               "showEndDrawer": false,
    //               "drawerItems": [
    //                 {
    //                   "title": "Profile",
    //                   "iconName": "person",
    //                   "route": "/profile"
    //                 },
    //                 {
    //                   "title": "Notifications",
    //                   "iconName": "notifications",
    //                   "route": "/notifications"
    //                 },
    //                 {
    //                   "title": "Help & Support",
    //                   "iconName": "help",
    //                   "route": "/support"
    //                 },
    //                 {
    //                   "title": "About",
    //                   "iconName": "info",
    //                   "route": "/about"
    //                 }
    //               ],
    //               "endDrawerItems": [
    //
    //               ],
    //             }).drawerItems ??
    //                 []),
    //       );
    //     }
    //     return ScaffoldWithBottomNavBar(
    //       navigationShell: navigationShell,
    //       children: children,
    //     );
    //   },
    // );
  },
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => BlocProvider(
              create: (context) => getIt<HomeBloc>(),
              child: const HomePage()),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/medication',
          builder: (context, state) {
            return AppointmentPage();
          },
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/placeholder',
          builder: (context, state) {
            return SizedBox();
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
          path: '/library',
          builder: (context, state) => BlocProvider(
              create: (context) => getIt<LibraryBloc>(),
              child: const LibraryPage()),
          routes: [
            GoRoute(
              path: 'video',
              builder: (context, state) => VideoPlayerScreen(videoUrl: "https://www.youtube.com/watch?v=f_d3XDTk7K4", title: "title"),
            ),
          ]
        ),
      ],
    ),
  ],
);

List<Widget> _getAppBarActions(BuildContext context, int index) {
  switch (index) {
    case 0:
      return [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          decoration: ShapeDecoration(
               color: Colors.black26,
              shape: CircleBorder()
          ),
          child: ButtonFactory().createIconButton(
              icon: Icons.perm_identity, onPressed: (){
                context.push("/profile");
          }, iconSize: 17),
        ),
      ];
    default:
      return [];
  }
}


String _getAppBarTitle(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Medication';
    case 2:
      return 'Calendar';
    case 3:
      return 'Chat';
    case 4:
      return 'Library';
    default:
      return '';
  }
}
