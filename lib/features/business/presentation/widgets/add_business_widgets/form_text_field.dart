import 'package:flutter/material.dart';

import '../../../../../config/theme/app_text_styles.dart';
import '../../../../../config/utils/app_sizes.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final IconData? suffixIcon;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController controller;

  const AppFormField({
    super.key,
    required this.label,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
    this.keyboardType,
    this.maxLength,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          keyboardType: keyboardType,
          readOnly: readOnly,
          style: AppTextStyle.bodyRegular(context),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: AppTextStyle.bodyRegular(context),
            suffixIcon: Icon(suffixIcon),
          ),
          onTap: onTap,
        ),
        SizedBox(height: AppSizes.sectionVertical(context)),
      ],
    );
  }
}
