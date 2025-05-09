import 'package:flutter/material.dart';

class InvertedRadiusClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);

    // Inverted arc at the top
    path.quadraticBezierTo(
      size.width / 2, -20, // control point above the top
      size.width, size.height,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
