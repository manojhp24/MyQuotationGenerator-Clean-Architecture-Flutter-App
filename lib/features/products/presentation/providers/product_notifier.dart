import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/add_product_usecase.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/get_product_usecase.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/update_product_usecase.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_state.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final AddProductUseCase addProductUseCase;
  final GetProductUseCase getProductUseCase;
  final UpdateProductUseCase updateProductUseCase;

  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final unitMeasureController = TextEditingController();
  final gstController = TextEditingController();
  final descriptionController = TextEditingController();
  final hsnController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final productNameFocus = FocusNode();

  int? selectedProductId;

  ProductNotifier(this.addProductUseCase, this.getProductUseCase,
      this.updateProductUseCase)
      : super(ProductState());

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
  Future<DataState<int>> saveProduct() async {
    if (!formKey.currentState!.validate()) {
      state = state.copyWith(error: "Validation failed");
      return DataFailed<int>(Exception("Validation failed"));
    }

    state = state.copyWith(isLoading: true);

    final product = ProductEntity(
        productName: productNameController.text,
        price: priceController.text,
        unitMeasure: unitMeasureController.text,
        gst: gstController.text,
        description: descriptionController.text,
        hsn: hsnController.text,
      );

      final result = await addProductUseCase(product);

      if (result is DataSuccess<int>) {
        clearForm();
        return result;
      } else if (result is DataFailed<int>) {
        state = state.copyWith(
            error: result.error?.toString() ?? "Something went wrong");
      }

    state = state.copyWith(isLoading: false);
    return result;
  }


  Future<DataState<int>> updateProduct() async {
    if (!formKey.currentState!.validate()) {
      state = state.copyWith(error: "Validation error");
      return DataFailed<int>(Exception("Validation error"));
    }

    state = state.copyWith(isLoading: true);

      if (selectedProductId == null) {
        return DataFailed<int>(Exception("Product id required for update"));
      }

      final product = ProductEntity(
        id: selectedProductId,
        productName: productNameController.text,
        price: priceController.text,
        unitMeasure: unitMeasureController.text,
        gst: gstController.text,
        description: descriptionController.text,
        hsn: hsnController.text,
      );

      final result = await updateProductUseCase(product);

      state = state.copyWith(isLoading: false);

      if (result is DataSuccess) {
        await fetchProduct();
        clearForm();
        return result;
      } else if (result is DataFailed<int>) {
        state = state.copyWith(
            error: result.error?.toString() ?? "Something went wrong");
      }

    state = state.copyWith(isLoading: false);
    return result;
  }

  Future<void> fetchProduct() async {
    state = state.copyWith(isLoading: true);

    final result = await getProductUseCase();

    if (result is DataSuccess<List<ProductEntity>>) {
      final productData = result.data ?? [];
      state = state.copyWith(product: productData, isLoading: false);
    } else if (result is DataFailed<List<ProductEntity>>) {
      state = state.copyWith(isLoading: false);
    }
  }

  void initializeForm({required bool isUpdate, ProductEntity? products}) {
    if (isUpdate && products != null) {
      productNameController.text = products.productName;
      priceController.text = products.price;
      unitMeasureController.text = products.unitMeasure;
      gstController.text = products.gst;
      descriptionController.text = products.description;
      hsnController.text = products.hsn;
    } else {
      clearForm();
    }
  }

  void clearForm() {
    productNameController.clear();
    priceController.clear();
    unitMeasureController.clear();
    gstController.clear();
    descriptionController.clear();
    hsnController.clear();
  }
}
