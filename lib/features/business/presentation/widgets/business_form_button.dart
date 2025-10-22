import 'package:flutter/material.dart';

import '../../../../config/theme/app_text_styles.dart';
import '../../../../config/utils/app_sizes.dart';

class BusinessFormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const BusinessFormButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.lg(context)),
      child: ElevatedButton(
        onPressed: () {
          onPressed(); // 🔹 executes passed function

        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, AppSizes.buttonHeight(context)),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.lg(context),
            vertical: AppSizes.sm(context),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.buttonText(context),
        ),
      ),
    );
  }
}
