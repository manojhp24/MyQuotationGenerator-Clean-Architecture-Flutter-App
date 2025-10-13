import 'package:flutter/material.dart';

import '../../utils/app_sizes.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class AppInputTheme {
  static InputDecorationTheme light(BuildContext context) =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.md(context),
          vertical: AppSizes.sm(context),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          borderSide: const BorderSide(color: AppColors.black, width: 1.5),
        ),
        hintStyle: AppTextStyle.bodySmall(
          context,
        ).copyWith(color: AppColors.textSecondary),
        labelStyle: AppTextStyle.bodyMedium(context),
      );
}
