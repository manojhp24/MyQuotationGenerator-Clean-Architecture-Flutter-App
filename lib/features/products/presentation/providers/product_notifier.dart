import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/core/common/App_snack_bar/custom_snack_bar.dart';
import 'package:my_quotation_generator/core/enums/product_message.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/add_product_usecase.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_state.dart';

import '../../../../config/theme/app_colors.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final AddProductUseCase addProductUseCase;

  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final unitMeasureController = TextEditingController();
  final gstController = TextEditingController();
  final descriptionController = TextEditingController();
  final hsnController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final productNameFocus = FocusNode();

  ProductNotifier(this.addProductUseCase) : super(ProductState());

  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    unitMeasureController.dispose();
    gstController.dispose();
    descriptionController.dispose();
    productNameFocus.dispose();
    hsnController.dispose();
    super.dispose();
  }

  /// Save Products
  Future<bool> saveProduct(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      if (context.mounted) {
        showCustomSnackBar(
          context,
          message: "Fill required fields!",
          isSuccess: false,
          backgroundColor: AppColors.darkGrey2,
          durationSeconds: 3,
        );
      }
      return false;
    }

    state = state.copyWith(isLoading: true);

    final product = ProductEntity(
        productName: productNameController.text,
        price: priceController.text,
        unitMeasure: unitMeasureController.text,
        gst: gstController.text,
        description: descriptionController.text,
        hsn: hsnController.text);
    final result = await addProductUseCase(product);

    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      FocusScope.of(context).requestFocus(productNameFocus);
      showCustomSnackBar(
          context, message: ProductMessages.addSuccess.message,
          isSuccess: true,
          backgroundColor: AppColors.darkGrey2,
          durationSeconds: 3
      );

      state = state.copyWith(isLoading: false);

    if (result is DataSuccess<int>) {
      productNameController.clear();
      priceController.clear();
      unitMeasureController.clear();
      gstController.clear();
      descriptionController.clear();
      hsnController.clear();

      return true;
      } else if (result is DataFailed<int>) {
      if (context.mounted) {
        showCustomSnackBar(
          context,
          message: result.error?.toString() ?? "Failed to save products",
          isSuccess: false,
          backgroundColor: AppColors.darkGrey2,
          durationSeconds: 3,
        );
      }
        return false;
      }
    }
    return false;
  }

}
