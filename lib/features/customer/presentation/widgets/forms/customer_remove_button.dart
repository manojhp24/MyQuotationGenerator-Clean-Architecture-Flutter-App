import 'package:flutter/material.dart';

import '../../../../../config/utils/app_sizes.dart';

class CustomerRemoveButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool? isLoading;

  const CustomerRemoveButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, AppSizes.buttonHeight(context)),
      ),
      child: Text(label),
    );
  }
}
