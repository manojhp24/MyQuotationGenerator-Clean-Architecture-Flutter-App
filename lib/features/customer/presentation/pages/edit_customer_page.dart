import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';

import '../../../../config/utils/app_sizes.dart';
import '../../domain/entities/customer.dart';
import '../provider/customer_provider.dart';
import '../widgets/card/customer_alert_dialog.dart';
import '../widgets/forms/customer_form.dart';
import '../widgets/forms/customer_form_button.dart';
import '../widgets/forms/customer_remove_button.dart';

class EditCustomerPage extends ConsumerWidget {
  final CustomerEntity customer;

  const EditCustomerPage({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(customerNotifierProvider.notifier);
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
        padding: EdgeInsets.all(AppSizes.lg(context)), child: Row(
        children: [
          Expanded(
            child: CustomerRemoveButton(
              label: AppStrings.remove,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomerAlertDialogBox(
                      title: AppStrings.deleteCustomer,
                      message: AppStrings.deleteMessage,
                      onPressed: () async {
                        Navigator.pop(context);
                        final success = await notifier.deleteCustomer(
                          context,
                          customer.id!,
                        );
                        if (success) {
                          if (context.mounted) context.pop(true);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(width: AppSizes.sm(context)),
          Expanded(
            child: CustomerFormButton(
              label: AppStrings.update,
              isLoading: state.isLoading,
              onPressed: () async {
                final success = await notifier.updateCustomer(
                  context,
                  customer.id!,
                );
                if (success) {
                  if (context.mounted) context.pop(true);
                }
              },
            ),
          ),
        ],
        ),
      ),
    );
  }
}



