import 'package:flutter/material.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/widgets/quick_action_button.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/widgets/section_title.dart';

import '../../../../../config/utils/app_sizes.dart';

class QuickActionSection extends StatelessWidget {
  const QuickActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(AppSizes.md(context)),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardSectionTitle(title: "Quick Actions"),
            QuickActionButton(
              onTap: () {},
              icon: Icons.person_add_alt_outlined,
              label: "Add Customer",
            ),
            SizedBox(height: AppSizes.sm(context)),
            QuickActionButton(
              onTap: () {},
              icon: Icons.add_shopping_cart_outlined,
              label: "Add Product",
            ),
            SizedBox(height: AppSizes.sm(context)),

            QuickActionButton(
              onTap: () {},
              icon: Icons.receipt_long_outlined,
              label: "Generate Quotation",
            ),
          ],
        ),
      ),
    );
  }
}
