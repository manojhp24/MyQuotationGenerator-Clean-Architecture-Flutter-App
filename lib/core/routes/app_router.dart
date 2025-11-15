import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/features/Products/presentation/pages/add_product_page.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:my_quotation_generator/features/business/presentation/pages/add_business_page.dart';
import 'package:my_quotation_generator/features/business/presentation/pages/business_page.dart';
import 'package:my_quotation_generator/features/business/presentation/pages/update_business_page.dart';
import 'package:my_quotation_generator/features/customer/presentation/pages/add_customer_page.dart';
import 'package:my_quotation_generator/features/customer/presentation/pages/customer_page.dart';
import 'package:my_quotation_generator/features/customer/presentation/pages/edit_customer_page.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:my_quotation_generator/features/settings/presentation/pages/settings_page.dart';

import '../../features/customer/domain/entities/customer.dart';
import '../../features/dashboard/presentation/pages/dashboard_nav.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/dashboard-nav',
    routes: [
      GoRoute(
        path: '/dashboard-nav',
        builder: (context, state) => const DashboardNav(),
      ),GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),GoRoute(
        path: '/business',
        builder: (context, state) => const BusinessPage(),
      ),GoRoute(
        path: '/add-business',
        builder: (context, state) => const AddBusinessPage(),
      ),GoRoute(
        path: '/update-business',
        builder: (context, state) {
          final business = state.extra;
          if (business is! BusinessEntity) {
            throw Exception('BusinessEntity missing when navigating to /update-business');
          }
          return UpdateBusinessPage(business: business);
        },
      ),
      GoRoute(
        path: '/customer',
        builder: (context, state) => const CustomerPage(),
      ),GoRoute(
        path: '/add-customer',
        builder: (context, state) => const AddCustomerPage(),
      ),GoRoute(
        path: '/edit-customer',
        builder: (context, state) {
          final customer = state.extra as CustomerEntity;
          return EditCustomerPage(customer: customer);
        },
      ),
      GoRoute(
        path: '/add-products',
        builder: (context, state) => const AddProductPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsPage(),
      ),
    ],
  );
});
