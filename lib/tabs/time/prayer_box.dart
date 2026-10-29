import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/time/prayer.dart';

class PrayerBox extends StatelessWidget {
  final Prayer prayer;
  final bool selected;

  const PrayerBox({super.key, required this.prayer, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: selected ? 118 : 96,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF6B5A3E),
            AppTheme.black.withValues(alpha: 0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(selected ? 22 : 18),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppTheme.black.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            prayer.name,
            style: TextStyle(
              color: AppTheme.white,
              fontSize: selected ? 15 : 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: FittedBox(
              child: Text(
                prayer.time,
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: selected ? 24 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            prayer.period,
            style: TextStyle(
              color: AppTheme.white,
              fontSize: selected ? 14 : 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
