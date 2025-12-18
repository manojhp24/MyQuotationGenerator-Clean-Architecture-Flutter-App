import 'package:flutter/material.dart';

class BusinessFormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const BusinessFormButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
        ),
        child: Text(label),
      ),
    );
  }
}
