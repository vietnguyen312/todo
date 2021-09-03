import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: AppColors.red,
        scaffoldBackgroundColor: Colors.white,
    );
  }
}

class AppColors {
  static const red = Color.fromARGB(255, 220, 76, 65);
  static const veryLightGrey = Color(0x55999999);
}