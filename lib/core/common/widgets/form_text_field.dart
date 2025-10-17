import 'package:flutter/material.dart';

import '../../../config/theme/app_text_styles.dart';
import '../../../config/utils/app_sizes.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final IconData? suffixIcon;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? alignLabelWithHint;

  const AppFormField({
    super.key,
    required this.label,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
    this.keyboardType,
    this.maxLength,
    this.controller,
    this.maxLines,
    this.alignLabelWithHint
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
          maxLines: maxLines,

          style: AppTextStyle.bodyRegular(context),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: AppTextStyle.bodyRegular(context),
            suffixIcon: Icon(suffixIcon),
            alignLabelWithHint: alignLabelWithHint,
          ),
          onTap: onTap,
        ),
        SizedBox(height: AppSizes.sectionVertical(context)),
      ],
    );
  }
}
