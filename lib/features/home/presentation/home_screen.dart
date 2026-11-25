import 'package:flutter/material.dart';
import 'package:islami/features/hadeth/presentation/hadeth_tab.dart';
import 'package:islami/features/quran/presentation/quran_tab.dart';
import 'package:islami/features/radio/presentation/radio_tab.dart';
import 'package:islami/features/sebha/presentation/sebha_tab.dart';
import 'package:islami/features/prayer_time/presentation/time_tab.dart';
import 'package:islami/core/widgets/active_nav_bar_icon.dart';
import 'package:islami/core/widgets/inactive_nav_bar_icon.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    QuranTab(),
    HadithTab(),
    SebhaTab(),
    RadioTab(),
    TimeTab(),
  ];
 
  List<String> backgroundImages = [
    "Quran_background",
    "Hadith_background",
    "Sebha_background",
    "Radio_background",
    "Time_background",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/${backgroundImages[currentIndex]}.png"),
            fit: BoxFit.fill,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              Image.asset("assets/images/islami_header.png",
              height:MediaQuery.sizeOf(context).height * 0.12,
              fit: BoxFit.fill
              ),
              Expanded(child: tabs[currentIndex]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
       currentIndex = value;
       setState(() {
       });
      },
      currentIndex: currentIndex,
       
        items: [
          BottomNavigationBarItem(
            icon: InactiveNavBarIcon(iconName: "Quran"),
            activeIcon: ActiveNavBarIcon(iconName: "Quran"),
            label: 'Quran',
          ),
           BottomNavigationBarItem(
            icon: InactiveNavBarIcon(iconName: "Hadith"),
            activeIcon: ActiveNavBarIcon(iconName: "Hadith"),
            label: 'Hadith',
          ),
           BottomNavigationBarItem(
            icon: InactiveNavBarIcon(iconName: "Sebha"),
            activeIcon: ActiveNavBarIcon(iconName: "Sebha"),
            label: 'Sebha',
          ),
           BottomNavigationBarItem(
            icon: InactiveNavBarIcon(iconName: "Radio"),
            activeIcon: ActiveNavBarIcon(iconName: "Radio"),
            label: 'Radio',
          ),
           BottomNavigationBarItem(
            icon: InactiveNavBarIcon(iconName: "Time"),
            activeIcon: ActiveNavBarIcon(iconName: "Time"),
            label: 'Time',
          ),
        ],
      ),
    );
  }
}
