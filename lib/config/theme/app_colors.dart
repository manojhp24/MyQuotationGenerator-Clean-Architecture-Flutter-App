import 'package:flutter/material.dart';

class AppColors {
  // Core theme colors
  static const Color black = Color(0xFF222222);
  static const Color white = Colors.white;

  // Primary UI color
  static const Color primary = black;
  static const Color onPrimary = white;

  // Accent / Link color
  static const Color accent = Color(0xFF2196F3);
  static const Color accentHover = Color(0xFF1976D2);
  static const Color accentDisabled = Color(0xFF90CAF9);

  // Greys & Neutral palette
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color grey = Color(0xFFBDBDBD);
  static const Color darkGrey = Color(0xFF757575);
  static const Color darkGrey2 = Color(0xFF535353);

  // Text colors
  static const Color textPrimary = black;
  static const Color textSecondary = darkGrey;
  static const Color textDisabled = grey;
  static const Color textOnPrimary = white;
  static const Color textOnBackground = black;
  static const Color textTertiary = grey;

  // Borders & Dividers
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocused = Color(0xFF9E9E9E); // TextField focus outline
  static const Color divider = Color(0xFFEAEAEA);

  // Button states
  static const Color primaryHover = Color(0xFF1A1A1A);
  static const Color primaryPressed = Color(0xFF000000);
  static const Color disabled = Color(0xFFDADADA);

  // UI States
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF0288D1);

  // Backgrounds
  static const Color background = white;
  static const Color surface = lightGrey;
  static const Color surfaceAlt = Color(0xFFF0F0F0);

  // Selection & Highlight
  static const Color highlight = Color(0xFFEEEEEE);
  static const Color selection = Color(0xFFDDDDDD);

  // Shadow (for cards, dialogs)
  static const Color shadow = Color(0x22000000);

  // Overlay (dialogs, bottom sheet)
  static const Color overlay = Color(0x66000000);
}
