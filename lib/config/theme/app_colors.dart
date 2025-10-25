import 'package:flutter/material.dart';

class AppColors {
  // Core theme colors
  static const Color black = Color(0xFF222222);
  static const Color white = Colors.white;

  // Primary (used for buttons, icons, and key UI highlights)
  static const Color primary = black;
  static const Color onPrimary = white;

  // Accent / Link color
  static const Color accent = Color(0xFF2196F3); // Blue for links or interactive text
  static const Color accentHover = Color(0xFF1976D2); // Darker shade on hover
  static const Color accentDisabled = Color(0xFF90CAF9); // Lighter variant

  // Greys
  static const Color lightGrey = Color(0xFFF3F3F3);
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
  static const Color divider = Color(0xFFEEEEEE);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);

  // Backgrounds & Surfaces
  static const Color background = white;
  static const Color surface = lightGrey;

  // Overlay (for dialogs, modals, etc.)
  static const Color overlay = Color(0x66000000);
}
