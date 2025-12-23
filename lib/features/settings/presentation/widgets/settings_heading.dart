import 'package:flutter/material.dart';

class SettingsHeading extends StatelessWidget {
  final String title;

  const SettingsHeading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Text(
        title,
        style: textTheme.titleSmall?.copyWith(
          color: scheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
