import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/features/Products/presentation/pages/products_page.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/provider/dashboard_provider.dart';

import '../../../business/presentation/pages/business_page.dart';
import '../../../customer/presentation/pages/customer_page.dart';
import '../../../quotation/presentation/pages/quotations_page.dart';
import '../widgets/dashboard_navbar.dart';
import 'dashboard_page.dart';

class DashboardNav extends ConsumerWidget {
  const DashboardNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(dashboardIndexProvider);

    const pages = [
      DashboardPage(),
      BusinessPage(),
      CustomerPage(),
      AddProductsPage(),
      QuotationsPage()
    ];

    return SafeArea(
      child: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: DashboardNavBar(
          currentIndex: currentIndex,
          onTap: (value) {
            ref.read(dashboardIndexProvider.notifier).setIndex(value);
          },
        ),
      ),
    );
  }
}
