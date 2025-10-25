import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/features/business/presentation/pages/add_business_page.dart';
import 'package:my_quotation_generator/features/business/presentation/pages/business_page.dart';
import 'package:my_quotation_generator/features/customer/presentation/pages/add_customer_page.dart';
import 'package:my_quotation_generator/features/customer/presentation/pages/customer_page.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/pages/dashboard_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),GoRoute(
        path: '/business',
        builder: (context, state) => const BusinessPage(),
      ),GoRoute(
        path: '/add-business',
        builder: (context, state) => const AddBusinessPage(),
      ),GoRoute(
        path: '/customer',
        builder: (context, state) => const CustomerPage(),
      ),GoRoute(
        path: '/add-customer',
        builder: (context, state) => const AddCustomerPage(),
      ),
    ],
  );
});
