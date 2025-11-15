import 'package:flutter/material.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_styles.dart';

class CustomAlertDialogBox extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onPressed;

  const CustomAlertDialogBox({
    super.key,
    required this.title,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.surface,
      // use your theme color
      title: Text(title, style: AppTextStyle.h3(context)),
      content: Text(
        message,
        style: AppTextStyle.bodyMedium(
          context,
        ).copyWith(color: AppColors.textSecondary),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onPressed,
                child: Text("Confirm", style: AppTextStyle.buttonText(context)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
