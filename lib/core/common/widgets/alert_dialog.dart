import 'package:flutter/material.dart';

Future<void> customAlertDialog({
  required BuildContext context,
  required ColorScheme scheme,
  required String title,
  required String content,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        icon: Icon(
          Icons.warning_amber_rounded,
          color: scheme.error,
        ),
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: scheme.error,
              foregroundColor: scheme.onError,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              onConfirm();
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}

