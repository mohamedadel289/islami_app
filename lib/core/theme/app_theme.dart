import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xffB7935F);
  static const Color dark = Color(0xff202020);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color gray = Color(0xff707070);
  static ThemeData lightTheme = ThemeData();
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: dark,
      foregroundColor: primary,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      centerTitle: true,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primary,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      selectedItemColor: Color(0xff202020),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: white.withValues(alpha: 0.7),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primary),
      ),
      filled: true,
      fillColor: dark.withValues(alpha: 0.7),
    ),

    textTheme: const TextTheme(
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.white,
      ),

      titleLarge: TextStyle(fontSize: 20, color: white),
      titleMedium: TextStyle(fontSize: 24, color: primary, fontWeight: .w700),
      headlineMedium: TextStyle(
        fontSize: 36,
        color: white,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
