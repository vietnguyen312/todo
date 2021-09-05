import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.red,
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.veryLightGrey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class AppColors {
  static const red = Color.fromARGB(255, 220, 76, 65);
  static const veryLightGrey = Color(0x55999999);
}