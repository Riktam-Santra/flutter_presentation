import 'package:flutter/material.dart';

class UpperHalfCurveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 25);

    path = _drawAllCurves(path, Offset(0, size.height - 25), size);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }

  Path _drawAllCurves(
    Path path,
    Offset startOffset,
    Size size, [
    int? index = 0,
  ]) {
    if (startOffset.dx > size.width || startOffset.dy > size.height) {
      return path;
    } else {
      final controlOffset = (index! % 2 == 0)
          ? Offset(startOffset.dx + 100, startOffset.dy - 50)
          : Offset(startOffset.dx + 100, startOffset.dy + 50);
      final endOffset = Offset(startOffset.dx + 200, startOffset.dy);

      path.quadraticBezierTo(
        controlOffset.dx,
        controlOffset.dy,
        endOffset.dx,
        endOffset.dy,
      );
      _drawAllCurves(path, endOffset, size, index + 1);
    }

    return path;
  }
}

class BottomHalfCurveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 25);

    path = _drawAllCurves(path, const Offset(0, 25), size);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }

  Path _drawAllCurves(
    Path path,
    Offset startOffset,
    Size size, [
    int? index = 0,
  ]) {
    if (startOffset.dx > size.width || startOffset.dy > size.height) {
      return path;
    } else {
      final controlOffset = (index! % 2 == 0)
          ? Offset(startOffset.dx + 100, startOffset.dy - 50)
          : Offset(startOffset.dx + 100, startOffset.dy + 50);
      final endOffset = Offset(startOffset.dx + 200, startOffset.dy);

      path.quadraticBezierTo(
        controlOffset.dx,
        controlOffset.dy,
        endOffset.dx,
        endOffset.dy,
      );
      _drawAllCurves(path, endOffset, size, index + 1);
    }

    return path;
  }
}
