import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/Products/domain/usecases/add_product_usecase.dart';
import 'package:my_quotation_generator/features/Products/presentation/providers/product_state.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final AddProductUseCase addProductUseCase;

  ProductNotifier(this.addProductUseCase) : super(ProductState());

  Future<void> saveProduct(BuildContext context) async {
    if (kDebugMode) {
      print("Saving Product");
    }
  }
}
