import 'package:pva/feature/drawer/domain/entities/drawer_config.dart';

abstract class DrawerState {
  const DrawerState();
}

class DrawerInitial extends DrawerState {
  const DrawerInitial();
}

class DrawerLoading extends DrawerState {
  const DrawerLoading();
}

class DrawerLoaded extends DrawerState {
  final DrawerConfig config;

  const DrawerLoaded(this.config);
}

class DrawerError extends DrawerState {
  final String message;

  const DrawerError(this.message);
}
