import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: const Color(0xFFF5F5FF),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
  ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
