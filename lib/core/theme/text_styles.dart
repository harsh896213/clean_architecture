import 'package:flutter/material.dart';
import 'package:pva/core/router/approuter.dart';

class AppTextStyles {
  static TextStyle getTextStyle(double fontSize, FontWeight weight) {
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
    //regular
    bodyLarge: getTextStyle(16, FontWeight.w400),
    bodyMedium: getTextStyle(14, FontWeight.w400),
    bodySmall: getTextStyle(12, FontWeight.w400),

    // Medium (w500) with different sizes
    labelSmall: getTextStyle(18, FontWeight.w500),
    labelLarge: getTextStyle(16, FontWeight.w500),
    labelMedium: getTextStyle(14, FontWeight.w500),

    // SemiBold (w600) with different sizes
    titleMedium: getTextStyle(18, FontWeight.w600),
    titleLarge: getTextStyle(22, FontWeight.w600),
    titleSmall: getTextStyle(16, FontWeight.w600),

    // Bold (w700) with different sizes
    headlineLarge: getTextStyle(28, FontWeight.w700),
    headlineMedium: getTextStyle(24, FontWeight.w700),
    headlineSmall: getTextStyle(20, FontWeight.w700),

  );
}
