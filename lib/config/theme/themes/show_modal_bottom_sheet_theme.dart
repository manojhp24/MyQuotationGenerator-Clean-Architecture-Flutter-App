import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';

class AppBottomSheetTheme {
  static BottomSheetThemeData light(BuildContext context) {
    return BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      modalBackgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.scale(context, 20)),
        ),
      ),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
    );
  }
}
