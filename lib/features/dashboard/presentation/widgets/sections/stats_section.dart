import 'package:flutter/material.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/widgets/stats_card.dart';

import '../../../../../config/utils/app_sizes.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.md(context)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: "Customer",
                    value: "35",
                    icon: Icons.people_outline,
                  ),
                ),
                SizedBox(width: AppSizes.md(context)),
                Expanded(
                  child: StatsCard(
                    title: "Products",
                    value: "12",
                    icon: Icons.shopping_cart,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.md(context)),
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: "Quotations",
                    value: "10",
                    icon: Icons.description_outlined,
                  ),
                ),
                SizedBox(width: AppSizes.md(context)),
                Expanded(
                  child: StatsCard(
                    title: "Pending",
                    value: "5",
                    icon: Icons.schedule_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}