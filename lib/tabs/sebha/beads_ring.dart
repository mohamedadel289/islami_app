import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

class BeadsRing extends StatelessWidget {
  final double size;
  final int count;

  const BeadsRing({super.key, required this.size, required this.count});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size.square(size),
        painter: _BeadsPainter(size: size, count: count),
      ),
    );
  }
}

class _BeadsPainter extends CustomPainter {
  final double size;
  final int count;

  const _BeadsPainter({required this.size, required this.count});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final double beadSize = size * 0.085;
    final double radius = size / 2 - beadSize / 2;
    final double center = size / 2;
    final Paint shadowPaint = const BoxShadow(
      color: Color(0x66000000),
      blurRadius: 4,
      offset: Offset(1, 2),
    ).toPaint();

    for (int i = 0; i < count; i++) {
      final double angle = 2 * math.pi * i / count - math.pi / 2;
      final Offset beadCenter = Offset(
        center + radius * math.cos(angle),
        center + radius * math.sin(angle),
      );
      final Rect beadBounds = Rect.fromCircle(
        center: beadCenter,
        radius: beadSize / 2,
      );

      canvas.drawCircle(
        beadCenter + const Offset(1, 2),
        beadSize / 2,
        shadowPaint,
      );
      canvas.drawCircle(
        beadCenter,
        beadSize / 2,
        Paint()
          ..shader = const RadialGradient(
            center: Alignment(-0.3, -0.3),
            colors: [Color(0xFFF6E3B0), AppTheme.primary, Color(0xFF9C7A33)],
          ).createShader(beadBounds),
      );
    }
  }

  @override
  bool shouldRepaint(_BeadsPainter oldDelegate) =>
      oldDelegate.size != size || oldDelegate.count != count;
}
