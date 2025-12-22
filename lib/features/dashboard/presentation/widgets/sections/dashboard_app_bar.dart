import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/constants/app_strings.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.dashboard,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.welcomeGreeting,
                    style: textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}