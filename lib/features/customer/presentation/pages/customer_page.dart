// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/common/widgets/empty_state_widget.dart';
import '../provider/customer_provider.dart';
import '../provider/customer_state.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Customer List"),
        elevation: 0,
      ),

      body: Builder(
        builder: (context) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.customer.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.people_alt_outlined,
              message: "No customers found",
            );
          }

          return CustomerListView(customers: state.customer);
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          final result = await context.push('/add-customer');
          if (result == true) {
            ref.read(customerNotifierProvider.notifier).fetchCustomer();
          }
        },
        child: const Icon(
          Icons.person_add_alt_outlined,
          color: AppColors.white,
        ),
      ),
    );
  }
}


