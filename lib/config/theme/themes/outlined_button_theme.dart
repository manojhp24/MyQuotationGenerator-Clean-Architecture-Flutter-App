import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';

import '../app_text_styles.dart';

class AppOutlinedButtonTheme {
  static OutlinedButtonThemeData light(BuildContext context) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          side: BorderSide(color: AppColors.primary),
          textStyle: AppTextStyle.buttonText(context)
        )
      );
}
