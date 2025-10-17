import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';

import '../widgets/customer_form.dart';
import '../widgets/customer_form_button.dart';

class AddCustomerPage extends ConsumerWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addCustomerAppBarTitle),
        elevation: 0,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),

      body: Padding(
        padding: AppSizes.pagePadding(context),
        child: SingleChildScrollView(child: CustomerForm()),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.lg(context)),
        child: CustomerFormButton(
          onPressed: () {},
          label: AppStrings.addCustomerDetails,
        ),
      ),
    );
  }
}
