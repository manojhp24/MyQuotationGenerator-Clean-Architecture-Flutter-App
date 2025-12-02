import 'package:flutter/material.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_styles.dart';
import '../../../../../config/utils/app_sizes.dart';

class ActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ActionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.md(context),
        vertical: AppSizes.sm(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppSizes.iconMedium(context),
            color: AppColors.primary,
          ),
          SizedBox(width: AppSizes.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bodyRegular(context)
                ),
                SizedBox(height: 4),
                Text(subtitle, style: AppTextStyle.bodySmall(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
