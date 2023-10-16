import 'package:flutter/material.dart';
import '../slides/slide_one.dart';

class BackgroundPainter extends CustomPainter {
  final List<Circle> circles;
  BackgroundPainter({required this.circles});
  @override
  void paint(Canvas canvas, Size size) {
    for (final circle in circles) {
      canvas.drawCircle(circle.offset, circle.radius, circle.paint);
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter backgroundPainter) {
    return false;
  }
}
