import 'package:blogs_app/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color borderColor = AppPallete.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(23),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
  );
}
