import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/core/common/App_snack_bar/custom_snack_bar.dart';
import 'package:my_quotation_generator/core/enums/customer_message.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';

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
                        final result = await notifier.deleteCustomer(
                          context,
                          customer.id!,
                        );
                        if (!context.mounted) return;
                        final isDeleted = result is DataSuccess;
                        showCustomSnackBar(context,
                            message: isDeleted ? CustomerMessages.deleteSuccess
                                .message : CustomerMessages.deleteError.message,
                          durationSeconds: 2,
                          backgroundColor: AppColors.darkGrey2
                        );
                        if (isDeleted) context.pop(true);

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
                final result = await notifier.updateCustomer(
                  context,
                  customer.id!,
                );
                if (!context.mounted) return;
                final isSuccess = result is DataSuccess;
                showCustomSnackBar(context, message: isSuccess
                    ? CustomerMessages.updateSuccess.message
                    : CustomerMessages.updateError.message,
                    backgroundColor: AppColors.darkGrey2,
                    durationSeconds: 2
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



