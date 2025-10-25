import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../config/utils/app_sizes.dart';

class QuickActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;

  const QuickActionButton({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      splashColor: AppColors.white,
      highlightColor: AppColors.black.withValues(alpha: 0.1),
      child: Ink(
        padding: EdgeInsets.all(AppSizes.md(context)),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.border, width: 1.2),
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.sm(context)),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.white,
                size: AppSizes.iconSmall(context) * 1.2,
              ),
            ),

            SizedBox(width: AppSizes.md(context)),

            // Text
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.bodyMedium(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: AppSizes.iconSmall(context),
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
