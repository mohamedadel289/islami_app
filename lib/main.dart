import 'package:flutter/material.dart';
import 'package:islami/features/home/presentation/home_screen.dart';
import 'package:islami/core/theme/app_theme.dart';
import 'package:islami/features/onboarding/presentation/intro_screen.dart';
import 'package:islami/features/quran/data/quran_services.dart';
import 'package:islami/features/quran/presentation/sura_details_screen.dart';
import 'package:islami/features/hadeth/presentation/hadeth_details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await QuranServices.getMostRecentlyRead();

  runApp(const ISLAMIAPP());
}

class ISLAMIAPP extends StatelessWidget {
  const ISLAMIAPP({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        SuraDetailsScreen.routeName: (_) => SuraDetailsScreen(),
        HadethDetailsScreen.routeName: (_) => HadethDetailsScreen(),
        IntroScreen.routeName: (_) => IntroScreen(),
      },
      initialRoute: IntroScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: .dark,
    );
  }
}
