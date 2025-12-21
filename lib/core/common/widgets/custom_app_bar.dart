import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final double? titleSpacing;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    this.titleSpacing = 16.0,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: scheme.surfaceContainer,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      titleSpacing: titleSpacing,
      automaticallyImplyLeading: false,

      leading: showBack
          ? IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: AppSizes.iconSize(context),
          color: scheme.onSurfaceVariant,
        ),
        onPressed: () => Navigator.pop(context),
      )
          : null,

      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.titleLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),

      actions: [
        if (actions != null) ...actions!,
        SizedBox(width: AppSizes.spaceS(context)),
      ],

      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
