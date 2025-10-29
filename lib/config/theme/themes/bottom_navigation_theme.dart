import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';

class BottomNavBarTheme {
  static BottomNavigationBarThemeData light(BuildContext context) {
    return BottomNavigationBarThemeData(
      backgroundColor: AppColors.primary,
      selectedItemColor: AppColors.textOnPrimary,
      unselectedItemColor: AppColors.darkGrey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }
}
