import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/widgets/quick_action_button.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/widgets/section_title.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';

import '../../../../../config/utils/app_sizes.dart';

class QuickActionSection extends ConsumerWidget {
  const QuickActionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: EdgeInsets.all(AppSizes.md(context)),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardSectionTitle(title: "Quick Actions"),
            QuickActionButton(
              onTap: () async {
                final result = await context.push('/add-customer');
                if (result == true) {
                  ref.read(customerNotifierProvider.notifier).fetchCustomer();
                }
              },
              icon: Icons.person_add_alt_outlined,
              label: "Add Customer",
            ),
            SizedBox(height: AppSizes.sm(context)),
            QuickActionButton(
              onTap: () async {
                final result = await context.push('/add-products');
                if (result == true) {
                  ref.read(productNotifierProvider.notifier).fetchProduct();
                }
              },
              icon: Icons.add_shopping_cart_outlined,
              label: "Add Product",
            ),
            SizedBox(height: AppSizes.sm(context)),

            QuickActionButton(
              onTap: () => context.push('/create-quotation'),
              icon: Icons.receipt_long_outlined,
              label: "Generate Quotation",
            ),
          ],
        ),
      ),
    );
  }
}
