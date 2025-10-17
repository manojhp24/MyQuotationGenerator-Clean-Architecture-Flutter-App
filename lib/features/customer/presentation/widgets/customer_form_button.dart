import 'package:flutter/material.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../config/utils/app_sizes.dart';
import '../../../../core/common/App_snack_bar/custom_snack_bar.dart';
import '../../../../core/enums/messages_enums.dart';

class CustomerFormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CustomerFormButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
        showCustomSnackBar(
          context,
          message: AppMessages.customerDataStoreSuccess.message,
          isSuccess: true,
          backgroundColor: AppColors.darkGrey2,
          durationSeconds: 3,
        );
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
