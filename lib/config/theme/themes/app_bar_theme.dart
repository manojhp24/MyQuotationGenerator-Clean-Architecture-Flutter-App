import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../app_text_styles.dart';


class AppAppBarTheme {
  static AppBarTheme light(BuildContext context) => AppBarTheme(
    backgroundColor: AppColors.primary,
    elevation: 0,
    centerTitle: true,
    foregroundColor: AppColors.white,
    titleTextStyle: AppTextStyle.appBarText(context),
    iconTheme: const IconThemeData(color: AppColors.textOnPrimary),
  );
}
