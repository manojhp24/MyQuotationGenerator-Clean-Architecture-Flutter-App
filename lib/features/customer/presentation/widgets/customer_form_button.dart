import 'package:flutter/material.dart';

import '../../../../config/theme/app_text_styles.dart';
import '../../../../config/utils/app_sizes.dart';


class CustomerFormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String message;

  const CustomerFormButton({
    super.key,
    required this.onPressed,
    required this.label, required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
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
    );
  }
}
