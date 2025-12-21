import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/core/common/widgets/alert_dialog.dart';
import 'package:my_quotation_generator/core/common/widgets/custom_app_bar.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../core/common/App_snack_bar/custom_snack_bar.dart';
import '../../../../core/enums/product_message.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entities/product.dart';
import '../providers/product_provider.dart';
import '../widgets/form/product_form.dart';
import '../widgets/form/product_remove_button.dart';
import '../../../customer/presentation/widgets/card/customer_alert_dialog.dart';
import '../../../customer/presentation/widgets/forms/customer_form_button.dart';

class EditProductPage extends ConsumerWidget {
  final ProductEntity products;

  const EditProductPage({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(productNotifierProvider.notifier);
    final scheme = Theme
        .of(context)
        .colorScheme;

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.editProductAppBarTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ProductForm(
          isUpdate: true,
          products: products,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ProductRemoveButton(
                label: AppStrings.remove,
                onPressed: () {
                  customAlertDialog(context: context,
                      scheme: scheme,
                      title: "Delete Product",
                      content: AppStrings.deleteProductMessage,
                      onConfirm: () async {
                        notifier.selectedProductId = products.id;

                        final result = await notifier.deleteProduct();
                        if (!context.mounted) return;

                        final isDeleted = result is DataSuccess;

                        showCustomSnackBar(
                          context,
                          message: isDeleted
                              ? ProductMessages.deleteSuccess.message
                              : ProductMessages.deleteError.message,

                          durationSeconds: 2,
                        );

                        if (isDeleted) {
                          context.pop(); // close dialog
                          context.pop(true); // return to previous page
                        }
                      }
                  );

                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomerFormButton(
                label: AppStrings.update,
                onPressed: () async {
                  notifier.selectedProductId = products.id;

                  final result = await notifier.updateProduct();
                  if (!context.mounted) return;

                  final isUpdated = result is DataSuccess;

                  showCustomSnackBar(
                    context,
                    message: isUpdated
                        ? ProductMessages.updateSuccess.message
                        : ProductMessages.updateError.message,
                    durationSeconds: 2,
                  );

                  if (isUpdated) context.pop(true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

