import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xffB7935F);
 static const Color dark = Color(0xff202020);
 static const Color white = Color(0xffffffff);
  static ThemeData lightTheme =ThemeData();
  static ThemeData darkTheme =ThemeData(
    scaffoldBackgroundColor: dark,
    appBarTheme:const AppBarTheme(
    backgroundColor: dark,
    foregroundColor: primary,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: primary,
      ),
      centerTitle: true,
    ),
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
     backgroundColor:  primary,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        selectedItemColor:  Color(0xff202020),
    ),
    textTheme: const TextTheme(
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.white,
      ),
      
      titleLarge: TextStyle(
        fontSize: 20,
        color: white,
      ),
       titleMedium: TextStyle(
        fontSize: 24,
        color: primary,
      ),
    ),
  );
}