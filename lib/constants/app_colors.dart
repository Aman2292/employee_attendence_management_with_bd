import 'package:flutter/material.dart';

class AppColors {
  // Primary & Brand Colors
  static const Color success = Color(0xFF01A63C); // Success green
  static const Color buttonColor = Color(0xFFFFCC00); // Buttons
  static const Color warning = Color(0xFFDD1217); // Red warning
  static const Color alertYellow = Color(0xFFFFF4DA); // Yellow shade

  // Background Colors
  static const Color background = Color(0xFFFFFFFF); // White background
  static const Color foreground = Color(0xFFF9F0EA); // Foreground color
  static const Color cardBackground = Color(0xFFF9F0EA); // Can reuse foreground if consistent
  static const Color darkBackground = Color(0xFF1B1E25);

  // Text Colors
  static const Color textDark = Color(0xFF1B1E25); // Dark text
  static const Color textLight = Color(0xFFE9E9E9); // Light text

  // Optional Defaults 
  static const Color divider = Color(0xFFE0E0E0);
  static const Color inactive = Color(0xFFBDBDBD);
  static const Color shadow = Color(0x1A000000); // 10% opacity black
  static const Color overlay = Color(0x80000000); // 50% opacity black

  // attendence status (mapped from status)
  static const Color attendencepresent = success;
  static const Color attendencelate = buttonColor;
  static const Color attendenceabsent = Color.fromARGB(255, 254, 31, 35);

  static const Color secondary = Color(0xFF6C757D); 
}
