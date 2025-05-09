import 'package:flutter/material.dart';

class AppColors {
  static const transparent = Color(0x01FFFFFF);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static const askBlue = Color(0xFF161C34);
  static const askOrange = Color(0xFFD85A27);
  static const askGreen = Color(0xFF1CC939);
  static const askLightBlue = Color(0xFF323E70);
  static const askSoftTheme = Color(0xFFDEE8FF);
  static const askBackground = Color(0xFFF3F3F3);
  static const askText = Color(0xFF33335B);
  static const askGray = Color(0xFFAAAAAA);

  static const red = Color(0xFFFF2D55);


}

List<BoxShadow> shadowDefault = [
  const BoxShadow(color: Colors.white, blurRadius: 4, offset: Offset(0, 0))
];

List<BoxShadow> shadowLight = [
  const BoxShadow(color: Color(0xFFC9C9C9), blurRadius: 8, offset: Offset(0, 0))
];

List<BoxShadow> shadowVeryLight = [
  const BoxShadow(color: Colors.white, blurRadius: 32, offset: Offset(0, 0))
];
