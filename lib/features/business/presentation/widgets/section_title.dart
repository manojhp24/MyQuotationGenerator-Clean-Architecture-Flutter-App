import 'package:flutter/material.dart';

import '../../../../config/utils/app_sizes.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.sm(context),
        horizontal: AppSizes.md(context),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.textMedium(context),
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
