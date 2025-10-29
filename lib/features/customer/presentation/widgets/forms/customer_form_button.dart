import 'package:flutter/material.dart';

import '../../../../../config/theme/app_text_styles.dart';
import '../../../../../config/utils/app_sizes.dart';

class CustomerFormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isLoading;

  const CustomerFormButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Disable button when loading
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, AppSizes.buttonHeight(context)),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.lg(context),
          vertical: AppSizes.sm(context),
        ),
      ),
      child: isLoading
          ? SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
          : Text(
        label,
        style: AppTextStyle.buttonText(context),
      ),
    );
  }
}
