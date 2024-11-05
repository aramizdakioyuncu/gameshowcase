import 'package:flutter/material.dart';

final ThemeData appDarkThemeData = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
  ),
);
final ThemeData appLightThemeData = ThemeData.light().copyWith(
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: Colors.black,
    // ),
    );
