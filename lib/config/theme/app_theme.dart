import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/themes/app_bar_theme.dart';
import 'package:my_quotation_generator/config/theme/themes/bottom_navigation_theme.dart';
import 'package:my_quotation_generator/config/theme/themes/elevated_button_theme.dart';
import 'package:my_quotation_generator/config/theme/themes/floating_button_theme.dart';
import 'package:my_quotation_generator/config/theme/themes/input_theme.dart';
import 'package:my_quotation_generator/config/theme/themes/outlined_button_theme.dart';
import 'package:my_quotation_generator/config/theme/themes/show_modal_bottom_sheet_theme.dart';
import 'package:my_quotation_generator/config/theme/themes/text_selection_theme.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  ///Light Theme
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.background,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: AppAppBarTheme.light(context),
      inputDecorationTheme: AppInputTheme.light(context),
      textSelectionTheme: AppTextSelectionTheme.light(context),
      elevatedButtonTheme: AppElevatedButtonTheme.light(context),
      textTheme: TextTheme(
        bodyLarge: AppTextStyle.bodyLarge(context),
        bodyMedium: AppTextStyle.bodyMedium(context),
        bodySmall: AppTextStyle.bodySmall(context),
        displayMedium: AppTextStyle.h3(context),
        displayLarge: AppTextStyle.h1(context),
      ),
      bottomNavigationBarTheme: BottomNavBarTheme.light(context),
      floatingActionButtonTheme: AppFloatingButtonTheme.light(context),
      outlinedButtonTheme: AppOutlinedButtonTheme.light(context),
      bottomSheetTheme: AppBottomSheetTheme.light(context)
    );
  }
}
