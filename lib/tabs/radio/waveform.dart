import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

/// Decorative waveform drawn behind the radio card controls.
class Waveform extends StatelessWidget {
  final bool animated;

  const Waveform({super.key, required this.animated});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final int barsCount = (constraints.maxWidth / 7).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(barsCount, (i) {
            final double height =
                8 + (math.sin(i * 0.9) * math.cos(i * 0.35)).abs() * 40;
            return AnimatedContainer(
              duration: Duration(milliseconds: 300 + (i % 5) * 80),
              width: 3,
              height: animated ? height : height * 0.6,
              decoration: BoxDecoration(
                color: AppTheme.black.withValues(alpha: animated ? 0.35 : 0.18),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}
