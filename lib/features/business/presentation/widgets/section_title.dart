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
    final textTheme =Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.spaceS(context),
      ),
      child: Text(
        title,style:textTheme.titleMedium ,
      ),
    );
  }
}
