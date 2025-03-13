import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/core/widgets/custom_bottom_nav.dart';

class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    required this.navigationShell,
    required this.children,
    this.drawer,
    this.endDrawer,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;
  final Widget? drawer;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        drawer: drawer,
        endDrawer: endDrawer,
        body: children[navigationShell.currentIndex],
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: navigationShell.currentIndex,
          onItemTapped: (index) => navigationShell.goBranch(index) ,
        ),
        // bottomNavigationBar: NavigationBar(
        //   selectedIndex: navigationShell.currentIndex,
        //   onDestinationSelected: (index) => navigationShell.goBranch(index),
        //   destinations: const [
        //     NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        //     NavigationDestination(
        //         icon: Icon(Icons.medication), label: 'Medication'),
        //     NavigationDestination(
        //         icon: Icon(Icons.calendar_today), label: 'Calendar'),
        //     NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
        //     NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        //   ],
        // ),
      ),
    );
  }
}
