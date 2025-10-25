import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';

class AppFloatingButtonTheme {
  static FloatingActionButtonThemeData light(BuildContext context) {
    return FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      splashColor: AppColors.darkGrey2,
      shape: CircleBorder(),
    );
  }
}
