import 'package:flutter/material.dart';
import 'package:islami/features/home/presentation/home_screen.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/features/quran/presentation/sura_details_screen.dart';

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
SuraDetailsScreen.routeName:(_) => SuraDetailsScreen(
  
),
        },
        initialRoute: HomeScreen.routeName,
        theme:AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:.dark
    );
    
  }
}