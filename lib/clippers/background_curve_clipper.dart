import 'package:flutter/material.dart';

class BackgroundCurveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(900, 0);
    const startOffset = Offset(900, 0);

    path.moveTo(startOffset.dx, startOffset.dy);
    path = drawAllCurves(path, startOffset, size);

    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }

  Path drawAllCurves(
    Path path,
    Offset startOffset,
    Size size, [
    int? index = 0,
  ]) {
    if (startOffset.dx > size.width || startOffset.dy > size.height) {
      return path;
    } else {
      final controlOffset = (index! % 2) == 0
          ? Offset(startOffset.dx + 50, startOffset.dy + 7.5)
          : Offset(startOffset.dx - 25, startOffset.dy + 40);
      final endOffset = Offset(startOffset.dx + 25, startOffset.dy + 50);

      path.quadraticBezierTo(
        controlOffset.dx,
        controlOffset.dy,
        endOffset.dx,
        endOffset.dy,
      );
      drawAllCurves(path, endOffset, size, index + 1);
    }

    return path;
  }
}
