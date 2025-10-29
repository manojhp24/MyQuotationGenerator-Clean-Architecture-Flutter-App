// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';

import '../../../../core/enums/messages_enums.dart';
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
            final isSaved = await notifier.saveCustomer(context);
            if (isSaved) {
              await Future.delayed(const Duration(seconds: 3));
              if (context.mounted) {
                context.pop(true);
              }
            }
          },

          label: AppStrings.addCustomerDetails,
          isLoading: state.isLoading,
        ),
      ),
    );
  }
}
