import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';

class CustomerAlertDialogBox extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onPressed;

  const CustomerAlertDialogBox({
    super.key,
    required this.title,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: scheme.surfaceContainerHigh,
      title: Text(
        title,
        style: textTheme.titleLarge,
      ),
      content: Text(
        message,
        style: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(AppStrings.cancel),
              ),
            ),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: scheme.error,
                  foregroundColor: scheme.onError,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onPressed,
                child: const Text(AppStrings.delete),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
