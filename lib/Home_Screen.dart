import 'package:flutter/material.dart';
import 'package:islami/tabs/Hadith_tab.dart';
import 'package:islami/tabs/Quran_tab.dart';
import 'package:islami/tabs/Radio_tab.dart';
import 'package:islami/tabs/Sebha_tab.dart';
import 'package:islami/tabs/Time_tab.dart';
import 'package:islami/widgets/active_nav_bar_icon.dart';
import 'package:islami/widgets/inactive_nav_bar_icon.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
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
