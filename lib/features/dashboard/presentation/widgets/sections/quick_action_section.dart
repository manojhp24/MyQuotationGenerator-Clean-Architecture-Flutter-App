import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/widgets/quick_action_button.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/widgets/section_title.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';

class QuickActionSection extends ConsumerWidget {
  const QuickActionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashboardSectionTitle(
              title: AppStrings.quickActions,
            ),

            const SizedBox(height: 16),

            // Quick actions with staggered animation
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [
                  QuickActionButton(
                    onTap: () async {
                      final result = await context.push('/add-customer');
                      if (result == true) {
                        ref
                            .read(customerNotifierProvider.notifier)
                            .fetchCustomer();
                      }
                    },
                    icon: Icons.person_add_alt_outlined,
                    label: AppStrings.addCustomer,

                  ),

                  const SizedBox(height: 12),

                  QuickActionButton(
                    onTap: () async {
                      final result = await context.push('/add-products');
                      if (result == true) {
                        ref
                            .read(productNotifierProvider.notifier)
                            .fetchProduct();
                      }
                    },
                    icon: Icons.add_shopping_cart_outlined,
                    label: AppStrings.addProduct,

                  ),

                  const SizedBox(height: 12),

                  QuickActionButton(
                    onTap: () => context.push('/create-quotation'),
                    icon: Icons.receipt_long_outlined,
                    label: AppStrings.generateQuotation,

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}