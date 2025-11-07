import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_styles.dart';
import '../../../../../config/utils/app_sizes.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.md(context),
          AppSizes.lg(context),
          AppSizes.md(context),
          AppSizes.sm(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side: Title and subtitle
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.dashboard,
                  style: AppTextStyle.h2(context),
                ),
                SizedBox(height: AppSizes.xs(context)),
                Text(
                  AppStrings.welcomeGreeting,
                  style: AppTextStyle.bodySmall(context)
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),

            // Right side: Settings icon
            IconButton(
              icon: Icon(
                Icons.tune_rounded,
                color: AppColors.textPrimary,
                size: AppSizes.iconMedium(context),
              ),
              onPressed: () => context.push('/settings'),
              tooltip: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
