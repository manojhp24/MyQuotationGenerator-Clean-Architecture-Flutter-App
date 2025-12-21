import 'package:flutter/material.dart';

void showCustomSnackBar(
    BuildContext context, {
      required String message,
      bool isSuccess = true,
      int durationSeconds = 4,
    }) {
  final scheme = Theme.of(context).colorScheme;

  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: durationSeconds),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    backgroundColor: isSuccess
        ? scheme.inverseSurface
        : scheme.errorContainer,
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          isSuccess ? Icons.check_circle_rounded : Icons.error_rounded,
          size: 22,
          color: isSuccess
              ? scheme.onInverseSurface
              : scheme.onErrorContainer,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSuccess
                  ? scheme.onInverseSurface
                  : scheme.onErrorContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
