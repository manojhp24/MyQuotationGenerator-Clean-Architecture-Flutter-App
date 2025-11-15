import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/widgets/stats_card.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';

import '../../../../../config/utils/app_sizes.dart';
import '../../../../customer/presentation/provider/customer_provider.dart';

class StatsSection extends ConsumerWidget {
  const StatsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final customerState = ref.watch(customerNotifierProvider);
    final productState = ref.watch(productNotifierProvider);

    final totalCustomer = customerState.customer.length;
    final totalProducts = productState.product.length;

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
                    value: "$totalCustomer",
                    icon: Icons.people_outline,
                  ),
                ),
                SizedBox(width: AppSizes.md(context)),
                Expanded(
                  child: StatsCard(
                    title: "products",
                    value: "$totalProducts",
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