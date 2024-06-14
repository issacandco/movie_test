import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const _primaryValue = 0xFFb5cff8;
  static const primaryColor = Colors.deepPurple;

  static const white = Colors.white;
  static const paleLilac = Color(0xFFF8F6FE);
  static const offWhiteColor = Color(0xFFEEEEEE);
  static const yellowColor = Color(0xFFFFC107);
  static const lightGrayColor = Color(0xFFe6e6e6);
  static const black = Colors.black;
  static const lightShadeGray = Color(0xFFbbbbbb);
  static const shadeGray = Color(0xFFcccccc);
  static const paleGrayColor = Color(0xFFEAEAEA);
  static const dimGray = Color(0xFF868686);

  // Dark theme colors
  static const eerieBlack = Color(0xFF1b1b1b);
  static const darkCharcoalColor = Color(0xFF2A2B32);
  static const deepCharcoal = Color(0xFF25262D);
  static const charcoalGrayColor = Color(0xFF262626);
  static const gray = Color(0xFF80858E);
  static const darkGray = Color(0xFF707070);
  static const oil = Color(0xFF2a2c29);
  static const lotion = Color(0xFFfafafa);

  static const scaffoldBackgroundColor = lotion;
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
