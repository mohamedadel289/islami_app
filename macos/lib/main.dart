import 'package:flutter/material.dart';
import 'package:islami/Home_Screen.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/intro_screen.dart';
import 'package:islami/tabs/Quran/sura_details_screen.dart';

void main() {
  runApp(const ISLAMIAPP());
}

class ISLAMIAPP extends StatelessWidget {
  const ISLAMIAPP({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        routes:{
HomeScreen.routeName:(_)=> HomeScreen(),
SuraDetailsScreen.routeName:(_) => SuraDetailsScreen(),
IntroScreen.routeName:(_)=> IntroScreen(),
        },
        initialRoute: IntroScreen.routeName,
        theme:AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:.dark
    );
  }
}