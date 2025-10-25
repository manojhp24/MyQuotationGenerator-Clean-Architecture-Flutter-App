import 'package:flutter/material.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.dashboard, style: AppTextStyle.h2(context)),
            SizedBox(height: AppSizes.xs(context)),
            Text(
              AppStrings.welcomeGreeting,
              style: AppTextStyle.bodySmall(
                context,
              ).copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
