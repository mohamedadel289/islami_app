import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/sebha/beads_ring.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  static const int beadsCount = 30;
  static const int cycleLimit = 33;
  static const List<String> azkar = ['سبحان الله', 'الحمد لله', 'الله أكبر'];

  int counter = 0;
  int azkarIndex = 0;
  double turns = 0;

  void onBeadsTap() {
    HapticFeedback.lightImpact();
    setState(() {
      if (counter == cycleLimit) {
        counter = 1;
        azkarIndex = (azkarIndex + 1) % azkar.length;
      } else {
        counter++;
      }
      turns += 1 / beadsCount;
    });
  }

  void reset() {
    setState(() {
      counter = 0;
      azkarIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double ringSize = math.min(
          constraints.maxWidth * 0.8,
          constraints.maxHeight * 0.6,
        );

        return SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  'سَبِّحِ اسْمَ رَبِّكَ الأَعْلَى',
                  style: textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Transform.rotate(
                  angle: math.pi,
                  child: const Icon(
                    Icons.water_drop_rounded,
                    color: AppTheme.primary,
                    size: 38,
                  ),
                ),
                GestureDetector(
                  onTap: onBeadsTap,
                  child: SizedBox(
                    width: ringSize,
                    height: ringSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedRotation(
                          turns: turns,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeOut,
                          child: BeadsRing(size: ringSize, count: beadsCount),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              azkar[azkarIndex],
                              style: textTheme.headlineSmall?.copyWith(
                                color: AppTheme.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '$counter',
                              style: textTheme.headlineSmall?.copyWith(
                                color: AppTheme.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: reset,
                  icon: const Icon(Icons.refresh, color: AppTheme.primary),
                  label: const Text(
                    'Reset',
                    style: TextStyle(color: AppTheme.primary),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
