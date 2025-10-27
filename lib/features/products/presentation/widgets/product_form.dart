import 'package:flutter/material.dart';
import 'package:my_quotation_generator/core/common/validators/input_validators.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_notifier.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../config/utils/app_sizes.dart';
import '../../../../core/common/widgets/form_text_field.dart';

class ProductForm extends StatelessWidget {
  final ProductNotifier notifier;

  const ProductForm({super.key, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSizes.pagePadding(context),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: notifier.formKey,
                child: Column(
                  children: [
                    AppFormField(
                      focusNode: notifier.productNameFocus,
                      label: AppStrings.productName,
                      controller: notifier.productNameController,
                      validator: (value) =>
                          Validators.requiredField("Product name", value),
                    ),
                    AppFormField(
                      label: AppStrings.productPrice,
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: notifier.priceController,
                      validator: (value) =>
                          Validators.requiredField("Price", value),
                    ),
                    AppFormField(
                      label: AppStrings.unitMeasure,
                      controller: notifier.unitMeasureController,
                      validator: (value) =>
                          Validators.requiredField("Unit Measure", value),
                    ),
                    AppFormField(
                      label: AppStrings.productGST,
                      suffixIcon: Icons.percent,
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: notifier.gstController,
                    ),
                    AppFormField(
                      label: "Description",
                      alignLabelWithHint: true,
                      maxLines: 5,
                      controller: notifier.descriptionController,
                    ),
                    AppFormField(
                      label: AppStrings.productHsn,
                      controller: notifier.hsnController,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
