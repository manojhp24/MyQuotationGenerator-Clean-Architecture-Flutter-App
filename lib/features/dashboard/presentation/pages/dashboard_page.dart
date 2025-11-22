import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';

import '../widgets/sections/dashboard_app_bar.dart';
import '../widgets/sections/quick_action_section.dart';
import '../widgets/sections/recent_quotation_section.dart';
import '../widgets/sections/stats_section.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();

    // Trigger initial fetch for stats
    Future.microtask(() {
      ref.read(customerNotifierProvider.notifier).fetchCustomer();
      ref.read(productNotifierProvider.notifier).fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: const [
            /// App Bar
            DashboardAppBar(),

            /// Stats Grid
            StatsSection(),

            /// Quick Actions
            QuickActionSection(),

            /// Recent Quotations
            RecentQuotationSection(),
          ],
        ),
      ),
    );
  }
}
