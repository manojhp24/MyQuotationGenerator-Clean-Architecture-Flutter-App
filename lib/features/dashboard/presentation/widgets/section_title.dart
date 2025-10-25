import 'package:flutter/material.dart';

import '../../../../config/theme/app_text_styles.dart';
import '../../../../config/utils/app_sizes.dart';

class DashboardSectionTitle extends StatelessWidget {
  final String title;

  const DashboardSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppTextStyle.h2(context)),
        SizedBox(height: AppSizes.md(context)),
      ],
    );
  }
}
