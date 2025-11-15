import 'package:flutter/material.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_styles.dart';
import '../../../../../config/utils/app_sizes.dart';

class ProductFormButton extends StatelessWidget {
  const ProductFormButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    required this.label,
    this.background,
  });

  final VoidCallback onPressed;
  final String label;
  final bool isLoading;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, AppSizes.buttonHeight(context)),
        backgroundColor: background,
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
                color: AppColors.white,
              ),
            )
          : Text(label, style: AppTextStyle.buttonText(context)),
    );
  }
}
