import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/widgets/stats_card.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_provider.dart';

import '../../../../customer/presentation/provider/customer_provider.dart';

class StatsSection extends ConsumerWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerState = ref.watch(customerNotifierProvider);
    final productState = ref.watch(productNotifierProvider);
    final quotationState = ref.watch(quotationNotifierProvider);

    final items = [
      StatsCard(
        title: AppStrings.customer,
        value: customerState.customer.length.toString(),
        icon: Icons.people_outline,
      ),
      StatsCard(
        title: AppStrings.products,
        value: productState.product.length.toString(),
        icon: Icons.shopping_cart_outlined,
      ),
      StatsCard(
        title: AppStrings.quotations,
        value: quotationState.quotations.length.toString(),
        icon: Icons.description_outlined,
      ),
      const StatsCard(
        title: AppStrings.pending,
        value: "5",
        icon: Icons.schedule_outlined,
      ),
    ];

    return SliverGrid.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => items[index],
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.3,
      ),
    );
  }
}
