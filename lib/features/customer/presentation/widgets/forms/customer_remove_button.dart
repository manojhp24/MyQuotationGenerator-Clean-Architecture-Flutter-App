import 'package:flutter/material.dart';
import '../../../../../config/utils/app_sizes.dart';

class CustomerRemoveButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomerRemoveButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final scale = AppSizes.textScale(context);

    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, AppSizes.spaceL(context) * 2),
      ),
      child: isLoading
          ? SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      )
          : Text(
        label,
        style: TextStyle(
          fontSize: 14 * scale,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
