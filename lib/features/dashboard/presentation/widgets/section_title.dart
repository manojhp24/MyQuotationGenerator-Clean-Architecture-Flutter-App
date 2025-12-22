import 'package:flutter/material.dart';

class DashboardSectionTitle extends StatelessWidget {
  final String title;

  const DashboardSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
      child: Text(
        title,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
