import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
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
    final scheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    final state = ref.watch(customerNotifierProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.customerList,
        showBack: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.screenPadding(context)),
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: scheme.primary,
                      strokeWidth: 2,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading customers...',
                      style: textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state.customer.isEmpty) {
              return EmptyStateWidget(
                actionText: "Add First Customer",
                icon: Icons.people_alt_outlined,
                message: AppStrings.noCustomersFound,
                onAction: () async {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  final result = await context.push('/add-customer');
                  if (result == true) {
                    ref.read(customerNotifierProvider.notifier).fetchCustomer();
                  }
                },
              );
            }

            return RefreshIndicator(
              color: scheme.primary,
              backgroundColor: scheme.surface,
              onRefresh: () async {
                ref.read(customerNotifierProvider.notifier).fetchCustomer();
              },
              child: CustomerListView(customers: state.customer),
            );
          },
        ),
      ),
      floatingActionButton: state.customer.isEmpty ? null : FloatingActionButton
          .extended(
        onPressed: () async {
          ScaffoldMessenger.of(context).clearSnackBars();
          final result = await context.push('/add-customer');
          if (result == true) {
            ref.read(customerNotifierProvider.notifier).fetchCustomer();
          }
        },
        icon: const Icon(Icons.person_add_alt_outlined),
        label: const Text('Add Customer'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        highlightElevation: 8,
      ),
    );
  }
}