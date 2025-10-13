import 'package:flutter/material.dart';
import '../../utils/app_sizes.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class AppElevatedButtonTheme {
  static ElevatedButtonThemeData light(BuildContext context) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.white,
          minimumSize: Size(double.infinity, AppSizes.buttonHeight(context)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          ),
          textStyle: AppTextStyle.buttonText(context),
        ),
      );
}
