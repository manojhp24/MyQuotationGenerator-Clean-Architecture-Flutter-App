import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/core/common/validators/input_validators.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_notifier.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../../../../config/utils/app_sizes.dart';
import '../../../../../core/common/widgets/form_text_field.dart';

class ProductForm extends ConsumerStatefulWidget {
  final bool isUpdate;
  final ProductEntity? products;

  const ProductForm({super.key, this.isUpdate = false, this.products});

  @override
  ConsumerState<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends ConsumerState<ProductForm> {
  late final ProductNotifier notifier;

  @override
  void initState() {
    notifier = ref.read(productNotifierProvider.notifier);
    notifier.initializeForm(
        isUpdate: widget.isUpdate, products: widget.products);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSizes.pagePadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Form(
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
        ],
      ),
    );
  }
}
