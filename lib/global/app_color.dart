import 'package:flutter/material.dart';

class AppColors {
  static const transparent = Color(0x01FFFFFF);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static const askBlue = Color(0xFF161C34);
  static const askOrange = Color(0xFFD85A27);
  static const askLightRed = Color(0xFFFFC9C9);
  static const askGreen = Color(0xFF1CC939);
  static const askLightBlue = Color(0xFF323E70);
  static const askSoftTheme = Color(0xFFDEE8FF);
  static const askBackground = Color(0xFFF3F3F3);
  static const askText = Color(0xFF33335B);
  static const askGray = Color(0xFFAAAAAA);

  static const red = Color(0xFFFF2D55);


}

class SocialColors {
  static const black = Color(0xFF000000);
  static const whatsapp = Color(0xFF25D366);
  static const telegram = Color(0xFF26A5E4);
  static const facebook = Color(0xFF1877F2);
  static const twitter = Color(0xFF1DA1F2);
  static const instagramRed = Color(0xFFE4405F);
  static const instagramBlue = Color(0xFF405DE6);
  static const tiktok = Color(0xFF000000);
  static const tiktokRed = Color(0xFFFE2C55);
  static const tiktokTeal = Color(0xFF25F4EE);
  static const youtube = Color(0xFFFF0000);
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
