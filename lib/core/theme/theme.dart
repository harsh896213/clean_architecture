import 'package:flutter/material.dart';
import 'package:pva/core/router/approuter.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/core/theme/text_styles.dart';

class AppTheme {
  //border of TextFormField
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      );
  //Dark Theme
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColorDark,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColorDark,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppPallete.backgroundColorDark,
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      )
  );

  //Light Theme
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
        AppPallete.backgroundColorLight,
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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    )
  );

  static InputDecoration searchInputDecoration() {
    return const InputDecoration(
      hintText: 'Search conversations',
      hintStyle: TextStyle(
        color: AppPallete.searchBarTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: EdgeInsets.only(bottom: 2),
    );
  }

  static BoxDecoration searchBarDecoration() {
    return BoxDecoration(
      color: AppPallete.searchBarBackground,
      borderRadius: BorderRadius.circular(20),
    );
  }
}

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