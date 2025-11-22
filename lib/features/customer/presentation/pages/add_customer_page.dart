// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/common/App_snack_bar/custom_snack_bar.dart';
import 'package:my_quotation_generator/core/enums/customer_message.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';

import '../widgets/forms/customer_form.dart';
import '../widgets/forms/customer_form_button.dart';

class AddCustomerPage extends ConsumerWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(customerNotifierProvider.notifier);
    final state = ref.watch(customerNotifierProvider);


    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addCustomerAppBarTitle),
        elevation: 0,
        leading: IconButton(onPressed: () => context.pop(), icon: Icon(Icons.arrow_back)),
      ),

      body: Padding(
        padding: AppSizes.pagePadding(context),
        child: SingleChildScrollView(child: CustomerForm(isUpdate: false)),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.lg(context)),
        child: CustomerFormButton(
          onPressed: () async {
            final result = await notifier.saveCustomer(context);
            if (!context.mounted) return;

            final isSuccess = result is DataSuccess;
            showCustomSnackBar(context, message: isSuccess
                ? CustomerMessages.addSuccess.message
                : CustomerMessages.saveError.message,
                backgroundColor: AppColors.darkGrey2,
                durationSeconds: 2
            );
            if (isSuccess) context.pop(true);
          },

          label: AppStrings.addCustomerDetails,
          isLoading: state.isLoading,
        ),
      ),
    );
  }
}
