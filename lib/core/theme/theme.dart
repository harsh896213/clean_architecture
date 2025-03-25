import 'package:flutter/material.dart';
import 'package:pva/core/router/approuter.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/core/theme/text_styles.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColorDark,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColorDark,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
          AppPallete.primaryColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );

  static final lightThemeMode = ThemeData.light().copyWith(
    primaryColor: AppPallete.primaryColor,
    secondaryHeaderColor: AppPallete.secondaryColor,
    scaffoldBackgroundColor: AppPallete.backgroundColorLight,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColorLight,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppPallete.primaryColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );

  static ListTileThemeData get listTileTheme => ListTileThemeData(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    tileColor: AppPallete.primaryColor,
    selectedTileColor: Colors.grey[100],
    titleTextStyle: AppTextStyles.getTextStyle(16, FontWeight.w500),
    subtitleTextStyle: AppTextStyles.getTextStyle(14, FontWeight.w400),
  );
}


////bottom nav shadow

bool isShadow = true;
List<BoxShadow> shadow = [
  if (isShadow)
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.06),
      spreadRadius: 0,
      blurRadius: 20,
      offset: Offset(0, 6), // changes position of shadow
    )
  else
    const BoxShadow(color: Colors.transparent)
];