import 'package:flutter/material.dart';
import 'package:islami/features/home/presentation/home_screen.dart';
import 'package:islami/core/theme/app_theme.dart';

void main() {
  runApp(const ISLAMIAPP());
}

class ISLAMIAPP extends StatelessWidget {
  const ISLAMIAPP({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes:{
HomeScreen.routeName:(_)=> HomeScreen(),
        },
        initialRoute: HomeScreen.routeName,
        theme:AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:.dark
    );
    
  }
}