import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/feature/drawer/domain/entities/drawer_config.dart';

class DrawerBuilder extends StatelessWidget {
  final List<DrawerItem> items;
  const DrawerBuilder({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'App Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ...items.map((item) => ListTile(
              leading: Icon(_getIconData(item.iconName)),
              title: Text(item.title),
              onTap: () {
                context.go(item.route);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      );
  }
}


IconData _getIconData(String iconName) {
  switch (iconName) {
    case 'home':
      return Icons.home;
    case 'settings':
      return Icons.settings;
    case 'person':
      return Icons.person;
    case 'notifications':
      return Icons.notifications;
    case 'help':
      return Icons.help;
    case 'info':
      return Icons.info;
    default:
      return Icons.circle;
  }
}

