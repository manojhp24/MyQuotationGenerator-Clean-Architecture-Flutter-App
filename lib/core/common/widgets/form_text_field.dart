import 'package:flutter/material.dart';

import '../../../config/theme/app_text_styles.dart';
import '../../../config/utils/app_sizes.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final void Function()? onTap;
  final FormFieldValidator<String?>? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? alignLabelWithHint;
  final VoidCallback? onPrefixPressed;
  final VoidCallback? onSuffixPressed;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final FocusNode? nextFocusNode;

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
    this.alignLabelWithHint,
    this.validator,
    this.prefixIcon, this.onPrefixPressed, this.onSuffixPressed,
    this.focusNode, this.textInputAction, this.nextFocusNode
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          focusNode: focusNode,
          textInputAction: textInputAction,
          controller: controller,
          maxLength: maxLength,
          keyboardType: keyboardType,
          readOnly: readOnly,
          maxLines: maxLines,
          validator: validator,
          style: AppTextStyle.bodyRegular(context),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: AppTextStyle.bodyRegular(context),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
              icon: Icon(suffixIcon),
              onPressed: onSuffixPressed, // your callback
            )
                : null,
            alignLabelWithHint: alignLabelWithHint,
          ),
          onTap: onTap,
        ),

        SizedBox(height: AppSizes.sectionVertical(context)),
      ],
    );
  }
}
