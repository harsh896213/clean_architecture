class DrawerConfig {
  final bool showDrawer;
  final bool showEndDrawer;
  final List<DrawerItem>? drawerItems;
  final List<DrawerItem>? endDrawerItems;

  const DrawerConfig({
    this.showDrawer = false,
    this.showEndDrawer = false,
    this.drawerItems,
    this.endDrawerItems,
  });
}

class DrawerItem {
  final String title;
  final String iconName;
  final String route;

  const DrawerItem({
    required this.title,
    required this.iconName,
    required this.route,
  });
}
