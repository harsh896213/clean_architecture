import 'package:flutter/services.dart' show rootBundle;
import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/network/network_client.dart';
import 'package:fpdart/fpdart.dart';
import '../models/drawer_config_model.dart';

abstract class DrawerRemoteDataSource {
  Future<Either<ApiError, DrawerConfigModel>> getDrawerConfig();
}

class DrawerRemoteDataSourceImpl implements DrawerRemoteDataSource {
  final NetworkClient client;
  final String baseUrl;

  DrawerRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<Either<ApiError, DrawerConfigModel>> getDrawerConfig() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Load mock JSON from assets
      // final jsonString =
      //     await rootBundle.loadString('lib/core/mock/drawer_config.json');
      final config = DrawerConfigModel.fromJson({
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
          },
          {
            "title": "Help & Support",
            "iconName": "help",
            "route": "/support"
          },
          {
            "title": "My Test",
            "iconName": "info",
            "route": "/myTest"
          },
          {
            "title": "My Test1",
            "iconName": "help",
            "route": "/support"
          },
          {
            "title": "My Test2",
            "iconName": "info",
            "route": "/about"
          }
        ],
        "endDrawerItems": [
          {
            "title": "Drawer 1",
            "iconName": "info",
            "route": "/about"
          }
        ]
      });

      return Right(config);

      // When ready to switch to real API, use this instead:
      /*
      return await client.get<DrawerConfigModel>(
        '$baseUrl/api/drawer-config',
        fromJson: (json) => DrawerConfigModel.fromJson(json),
      );
      */
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
