import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/core/common/App_snack_bar/custom_snack_bar.dart';
import 'package:my_quotation_generator/core/common/widgets/alert_dialog.dart';
import 'package:my_quotation_generator/core/enums/customer_message.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';

import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../domain/entities/customer.dart';
import '../provider/customer_provider.dart';
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
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.editCustomerAppBarTitle),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: CustomerForm(isUpdate: true, customer: customer),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: CustomerRemoveButton(
                label: AppStrings.remove,
                onPressed: () {
                  customAlertDialog(
                    context: context,
                    scheme: scheme,
                    title: AppStrings.deleteCustomer,
                    content: AppStrings.deleteMessage,
                    onConfirm: () async {
                      Navigator.pop(context);
                        final result = await notifier.deleteCustomer(
                          context,
                          customer.id!,
                        );
                        if (!context.mounted) return;

                        final isDeleted = result is DataSuccess;

                        showCustomSnackBar(
                          context,
                          message: isDeleted
                              ? CustomerMessages.deleteSuccess.message
                              : CustomerMessages.deleteError.message,
                          durationSeconds: 2,
                        );

                        if (isDeleted) context.pop(true);
                      },
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomerFormButton(
                label: AppStrings.update,
                isLoading: state.isLoading,
                onPressed: () async {
                  final result = await notifier.updateCustomer(customer.id!);
                  if (!context.mounted) return;

                  final isSuccess = result is DataSuccess;

                  showCustomSnackBar(
                    context,
                    message: isSuccess
                        ? CustomerMessages.updateSuccess.message
                        : CustomerMessages.updateError.message,
                    durationSeconds: 2,
                  );

                  if (isSuccess) context.pop(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

