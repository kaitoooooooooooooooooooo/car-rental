import 'dart:ui';

import 'package:flutter/material.dart';

class LiquidGlass extends StatelessWidget {
  const LiquidGlass({super.key, required this.child, this.radius = 100});

  final Widget child;
  final double radius;

  static const _saturation = [
    [1.63, -0.572, -0.058, 0.0, 0.0],
    [-0.17, 1.228, -0.058, 0.0, 0.0],
    [-0.17, -0.572, 1.742, 0.0, 0.0],
    [0.0, 0.0, 0.0, 1.0, 0.0],
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.compose(
          outer: ColorFilter.matrix([for (final row in _saturation) ...row]),
          inner: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        ),
        child: CustomPaint(
          foregroundPainter: GlassRimPainter(radius: radius),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.14),
                  Colors.white.withValues(alpha: 0.04),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class GlassRimPainter extends CustomPainter {
  GlassRimPainter({this.radius = 100, this.intensity = 1});

  final double radius;
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final a = 0.55 * intensity;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(radius)).deflate(0.5),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: a),
            Colors.white.withValues(alpha: a * 0.08),
            Colors.white.withValues(alpha: a * 0.08),
            Colors.white.withValues(alpha: a * 0.55),
          ],
          stops: const [0, 0.35, 0.65, 1],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(GlassRimPainter old) =>
      old.radius != radius || old.intensity != intensity;
}
