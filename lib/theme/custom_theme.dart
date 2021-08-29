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
  static Color red = Color.fromARGB(255, 220, 76, 65);
}