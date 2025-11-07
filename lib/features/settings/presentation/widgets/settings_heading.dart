import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/theme/app_text_styles.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';

class SettingsHeading extends StatelessWidget {
  final String title;

  const SettingsHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSizes.cardPadding(context) * 0.4,
        bottom: AppSizes.cardPadding(context) * 0.3,
      ),
      child: Text(
        title,
        style: AppTextStyle.bodyBold(context).copyWith(
          fontSize: 16,
          color: AppColors.primary.withValues(alpha: .7),
        ),
      ),
    );
  }
}
