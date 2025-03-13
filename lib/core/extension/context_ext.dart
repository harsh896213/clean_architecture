import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExtension on BuildContext {
  // Theme extensions
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Media query extensions
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  Brightness get brightness => mediaQuery.platformBrightness;
  bool get isDarkMode => brightness == Brightness.dark;

  // GoRouter Navigation extensions with popUntil functionality

  void popUntil(String location) {
    while (GoRouter.of(this).state?.name != location && canPop()) {
      pop();
    }
  }

  void popUntilNamed(String routeName) {
    while (GoRouterState.of(this).name != routeName && canPop()) {
      pop();
    }
  }

  void popUntilRoot() {
    while (canPop()) {
      pop();
    }
  }

  // Responsive breakpoints
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1200;
  bool get isDesktop => width >= 1200;
}
