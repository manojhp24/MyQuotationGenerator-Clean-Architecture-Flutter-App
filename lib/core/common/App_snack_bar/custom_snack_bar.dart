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
    backgroundColor: isSuccess
        ? scheme.inverseSurface
        : scheme.errorContainer,
    content: Row(
      children: [
        Icon(
          isSuccess ? Icons.check_circle : Icons.error_outline,
          color: isSuccess
              ? scheme.onInverseSurface
              : scheme.onErrorContainer,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
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
