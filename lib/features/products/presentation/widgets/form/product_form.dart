import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/core/common/validators/input_validators.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../../../../core/common/widgets/form_text_field.dart';

class ProductForm extends ConsumerStatefulWidget {
  final bool isUpdate;
  final ProductEntity? products;

  const ProductForm({super.key, this.isUpdate = false, this.products});

  @override
  ConsumerState<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends ConsumerState<ProductForm> {
  late final productNotifier = ref.read(productNotifierProvider.notifier);

  @override
  void initState() {
    super.initState();
    productNotifier.initializeForm(
      isUpdate: widget.isUpdate,
      products: widget.products,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: productNotifier.formKey,
      child: Column(
        children: [
          AppFormField(
            label: AppStrings.productName,
            controller: productNotifier.productNameController,
            validator: (value) =>
                Validators.requiredField(AppStrings.productName, value),
          ),

          AppFormField(
            label: AppStrings.productPrice,
            controller: productNotifier.priceController,
            validator: (value) =>
                Validators.requiredField(AppStrings.productPrice, value),
            keyboardType: TextInputType.numberWithOptions(),
          ),

          AppFormField(
            label: AppStrings.unitMeasure,
            controller: productNotifier.unitMeasureController,
            validator: (value) =>
                Validators.requiredField(AppStrings.unitMeasure, value),
          ),

          AppFormField(
            label: AppStrings.productGST,
            controller: productNotifier.gstController,
            keyboardType: TextInputType.numberWithOptions(),
          ),

          AppFormField(
            label: AppStrings.productHsn,
            controller: productNotifier.hsnController,
          ),

          AppFormField(
            label: AppStrings.description,
            controller: productNotifier.descriptionController,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}