import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final VoidCallback? onTap;
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
    this.prefixIcon,
    this.onTap,
    this.keyboardType,
    this.maxLength,
    this.controller,
    this.maxLines = 1,
    this.alignLabelWithHint,
    this.validator,
    this.onPrefixPressed,
    this.onSuffixPressed,
    this.focusNode,
    this.textInputAction,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: maxLines,
        readOnly: readOnly,
        validator: validator,
        style: textTheme.bodyLarge,
        onTap: onTap,
        onFieldSubmitted: (_) {
          if (nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: alignLabelWithHint,
          prefixIcon: prefixIcon != null
              ? IconButton(
            icon: Icon(prefixIcon),
            onPressed: onPrefixPressed,
          )
              : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(suffixIcon),
            onPressed: onSuffixPressed,
          )
              : null,
        ),
      ),
    );
  }
}
