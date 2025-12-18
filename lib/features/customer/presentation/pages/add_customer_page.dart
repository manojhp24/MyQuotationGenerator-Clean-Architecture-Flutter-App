import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/common/App_snack_bar/custom_snack_bar.dart';
import 'package:my_quotation_generator/core/common/widgets/custom_app_bar.dart';
import 'package:my_quotation_generator/core/enums/customer_message.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';

import '../widgets/forms/customer_form.dart';
import '../widgets/forms/customer_form_button.dart';

class AddCustomerPage extends ConsumerWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(customerNotifierProvider.notifier);
    final state = ref.watch(customerNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: const CustomAppBar(
        title: AppStrings.addCustomer,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.screenPadding(context)),
            child: CustomerForm(isUpdate: false),
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomerFormButton(
            isLoading: state.isLoading,
            label: AppStrings.addCustomerDetails,
            onPressed: () async {
              final result = await notifier.saveCustomer(context);
              if (!context.mounted) return;

              final isSuccess = result is DataSuccess;

              showCustomSnackBar(
                context,
                message: isSuccess
                    ? CustomerMessages.addSuccess.message
                    : CustomerMessages.saveError.message,
                durationSeconds: 2,
              );

              if (isSuccess) context.pop(true);
            },
          ),
        ),
      ),
    );
  }
}
