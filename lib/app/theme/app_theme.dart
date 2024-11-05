import 'package:flutter/material.dart';

final ThemeData appDarkThemeData = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.amber,
  ),
);
final ThemeData appLightThemeData = ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.red,
  ),
);
