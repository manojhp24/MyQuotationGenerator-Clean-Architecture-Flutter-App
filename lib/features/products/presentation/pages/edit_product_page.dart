import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';
import 'package:my_quotation_generator/features/products/presentation/widgets/form/product_remove_button.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../customer/presentation/widgets/card/customer_alert_dialog.dart';
import '../../../customer/presentation/widgets/forms/customer_form_button.dart';
import '../widgets/form/product_form.dart';

class EditProductPage extends ConsumerWidget {
  final ProductEntity products;

  const EditProductPage({super.key, required this.products});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(productNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Padding(
        padding: AppSizes.pagePadding(context),
        child: SingleChildScrollView(
          child: ProductForm(isUpdate: true, products: products),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.lg(context)), child: Row(
        children: [
          Expanded(
            child: ProductRemoveButton(
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
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(width: AppSizes.sm(context)),
          // Expanded(
          //   child: CustomerFormButton(
          //     label: AppStrings.update,
          //     isLoading: state.isLoading,
          //     onPressed: () async {
          //
          //     },
          //   ),
          // ),
        ],
      ),
      ),
    );
  }
}
