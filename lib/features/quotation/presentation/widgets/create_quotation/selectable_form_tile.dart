import 'package:flutter/material.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_styles.dart';
import '../../../../../config/utils/app_sizes.dart';

class SelectableFormTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final String? subtitle;

  const SelectableFormTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          border: Border.all(color: AppColors.border),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.cardPadding(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add Icon Badge
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.all(AppSizes.xs(context)),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: AppSizes.iconSmall(context),
                  ),
                ),
              ),

              SizedBox(height: AppSizes.xs(context)),

              // Main Icon
              Container(
                padding: EdgeInsets.all(AppSizes.sm(context)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                ),
                child: Icon(
                  icon,
                  size: AppSizes.iconMedium(context),
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: AppSizes.sm(context)),

              // Title
              Text(
                title,
                style: AppTextStyle.bodyMedium(context),
                textAlign: TextAlign.center,
              ),

              if (subtitle != null) ...[
                SizedBox(height: AppSizes.xs(context)),
                Text(
                  subtitle!,
                  style: AppTextStyle.label(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
