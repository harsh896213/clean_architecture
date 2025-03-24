import 'package:flutter/material.dart';
import 'package:pva/core/router/approuter.dart';

class AppTextStyles {
  static TextStyle _getTextStyle(double fontSize, FontWeight weight) {
    return TextStyle(
      fontFamily: 'PlusJakartaSans',
      fontWeight: weight,
      fontSize: fontSize,
      color: Colors.black
      // fontSize: MediaQueryData.fromView(View.of(navigationKey.currentContext!))
      //     .textScaler
      //     .scale(fontSize),
    );
  }

  static var textTheme = TextTheme(
    bodyLarge: _getTextStyle(16, FontWeight.w400),
    bodyMedium: _getTextStyle(14, FontWeight.w400),
    bodySmall: _getTextStyle(12, FontWeight.w400),

    // Medium (w500) with different sizes
    labelSmall: _getTextStyle(18, FontWeight.w500),
    labelLarge: _getTextStyle(16, FontWeight.w500),
    labelMedium: _getTextStyle(14, FontWeight.w500),

    // SemiBold (w600) with different sizes
    titleMedium: _getTextStyle(18, FontWeight.w600),
    titleLarge: _getTextStyle(22, FontWeight.w600),
    titleSmall: _getTextStyle(16, FontWeight.w600),

    // Bold (w700) with different sizes
    headlineLarge: _getTextStyle(28, FontWeight.w700),
    headlineMedium: _getTextStyle(24, FontWeight.w700),
    headlineSmall: _getTextStyle(20, FontWeight.w700),

  );
}
