import 'dart:ui';

import 'package:flutter/material.dart';

class CustomColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color fontBlack = Color(0xDE000000);
  static const Color logoBlue = Color(0xFF245f97);
  static const Color textFieldBackground = Color(0x1E000000);
  static const Color hintColor = Color(0x99000000);
  static const Color statusBarColor = Color(0x1e000000);
}

class CustomTheme {
  static ThemeData mainTheme = ThemeData(
    // Default brightness and colors.
    brightness: Brightness.light,
    primaryColor: CustomColor.logoBlue,
    accentColor: Colors.cyan[600],

    // Default font family.
    fontFamily: 'Roboto',

    // Default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and etc.
    textTheme: TextTheme(
      headline: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: CustomColor.fontBlack,
      ),
      title: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: CustomColor.fontBlack,
      ),
      body1: TextStyle(fontSize: 16.0, color: CustomColor.fontBlack),
      body2: TextStyle(fontSize: 16.0, color: CustomColor.hintColor),
      button: TextStyle(
        color: CustomColor.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 2,
      ),
    ),
  );
}
