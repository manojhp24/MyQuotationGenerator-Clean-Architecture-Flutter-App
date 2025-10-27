

import '../../domain/entities/product.dart';

class ProductState {
  final bool isLoading;
  final List<ProductEntity> product;
  final String? error;

  ProductState({this.isLoading = false, this.product = const [], this.error});

  ProductState copyWith({
    bool? isLoading,
    List<ProductEntity>? product,
    String? error,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      error: error ?? this.error,
    );
  }
}
