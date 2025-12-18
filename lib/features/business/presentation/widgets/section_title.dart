import 'package:flutter/material.dart';
import '../../../../config/utils/app_sizes.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final scale = AppSizes.textScale(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.spaceS(context),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16 * scale,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
