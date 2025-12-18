import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/core/common/widgets/custom_app_bar.dart';

import '../../../../core/common/widgets/empty_state_widget.dart';
import '../provider/customer_provider.dart';
import '../widgets/list/customer_list_view.dart';

class CustomerPage extends ConsumerStatefulWidget {
  const CustomerPage({super.key});

  @override
  ConsumerState<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends ConsumerState<CustomerPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(customerNotifierProvider.notifier).fetchCustomer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerNotifierProvider);

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.customerList,showBack: false),
      body: Builder(
        builder: (context) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.customer.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.people_alt_outlined,
              message: AppStrings.noCustomersFound,
            );
          }

          return CustomerListView(customers: state.customer);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ScaffoldMessenger.of(context).clearSnackBars();
          final result = await context.push('/add-customer');
          if (result == true) {
            ref.read(customerNotifierProvider.notifier).fetchCustomer();
          }
        },
        child: const Icon(Icons.person_add_alt_outlined),
      ),
    );
  }
}
