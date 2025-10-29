import 'package:flutter/material.dart';

import '../../../../config/utils/app_sizes.dart';
import '../../domain/entities/customer.dart';
import '../provider/customer_provider.dart';
import '../widgets/forms/customer_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class EditCustomerPage extends ConsumerWidget {
  final CustomerEntity customer;

  const EditCustomerPage({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customerNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Customer"),
      ),
      body: Padding(
        padding: AppSizes.pagePadding(context),
        child: SingleChildScrollView(
          child: CustomerForm(
            isUpdate: true,
            customer: customer,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.lg(context)),
        child: ElevatedButton(
          onPressed: () async {
            // final success = await notifier.updateCustomer(context, customer.id);
            // if (success) {
            //   await Future.delayed(const Duration(seconds: 2));
            //   if (context.mounted) context.pop(true);
            // }
          },
          child: Text(
            state.isLoading ? 'Updating...' : 'Update Customer',
          ),
        ),
      ),
    );
  }
}




