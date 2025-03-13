import 'dart:convert';
import '../../domain/entities/drawer_config.dart';

class DrawerConfigModel extends DrawerConfig {
  DrawerConfigModel({
    required bool showDrawer,
    required bool showEndDrawer,
    List<DrawerItemModel>? drawerItems,
    List<DrawerItemModel>? endDrawerItems,
  }) : super(
          showDrawer: showDrawer,
          showEndDrawer: showEndDrawer,
          drawerItems: drawerItems,
          endDrawerItems: endDrawerItems,
        );

  factory DrawerConfigModel.fromJson(Map<String, dynamic> json) {
    return DrawerConfigModel(
      showDrawer: json['showDrawer'] ?? false,
      showEndDrawer: json['showEndDrawer'] ?? false,
      drawerItems: json['drawerItems'] != null
          ? List<DrawerItemModel>.from(
              json['drawerItems'].map((x) => DrawerItemModel.fromJson(x)))
          : null,
      endDrawerItems: json['endDrawerItems'] != null
          ? List<DrawerItemModel>.from(
              json['endDrawerItems'].map((x) => DrawerItemModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showDrawer': showDrawer,
      'showEndDrawer': showEndDrawer,
      'drawerItems':
          drawerItems?.map((x) => (x as DrawerItemModel).toJson()).toList(),
      'endDrawerItems':
          endDrawerItems?.map((x) => (x as DrawerItemModel).toJson()).toList(),
    };
  }

  // Helper method to create from JSON string
  static DrawerConfigModel fromJsonString(String jsonString) {
    return DrawerConfigModel.fromJson(json.decode(jsonString));
  }
}

class DrawerItemModel extends DrawerItem {
  DrawerItemModel({
    required String title,
    required String iconName,
    required String route,
  }) : super(
          title: title,
          iconName: iconName,
          route: route,
        );

  factory DrawerItemModel.fromJson(Map<String, dynamic> json) {
    return DrawerItemModel(
      title: json['title'] ?? '',
      iconName: json['iconName'] ?? '',
      route: json['route'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'iconName': iconName,
      'route': route,
    };
  }
}
