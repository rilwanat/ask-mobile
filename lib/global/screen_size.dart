import 'package:flutter/material.dart';

// Screen size helper functions
class ScreenSize {
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double width(BuildContext context) => MediaQuery.of(context).size.width;

  // Scales width relative to a 390px design (iPhone 12)
  static double scaleWidth(BuildContext context, double size) {
    return size * width(context) / 390;
  }

  // Scales height relative to an 844px design
  static double scaleHeight(BuildContext context, double size) {
    return size * height(context) / 844;
  }
}

// Extension for direct calls like `20.w` or `30.h`
extension SizeExtension on num {
  double get w => this * WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width / 390;
  double get h => this * WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height / 844;
}
