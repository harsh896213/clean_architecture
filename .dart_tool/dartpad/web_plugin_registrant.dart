// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

// @dart = 2.13
// ignore_for_file: type=lint

import 'package:connectivity_plus/src/connectivity_plus_web.dart';
import 'package:flutter_localization/flutter_localization_web.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:package_info_plus/src/package_info_plus_web.dart';
import 'package:sentry_flutter/sentry_flutter_web.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  ConnectivityPlusWebPlugin.registerWith(registrar);
  FlutterLocalizationWeb.registerWith(registrar);
  ImagePickerPlugin.registerWith(registrar);
  PackageInfoPlusWebPlugin.registerWith(registrar);
  SentryFlutterWeb.registerWith(registrar);
  SharedPreferencesPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
