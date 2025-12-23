

import '../../domain/entities/product.dart';

class ProductState {
  final bool isLoading;
  final List<ProductEntity> product;
  final String? error;
  final String searchQuery;

  ProductState({this.isLoading = false, this.product = const [
  ], this.error, this.searchQuery = ''});

  ProductState copyWith({
    bool? isLoading,
    List<ProductEntity>? product,
    String? error,
    String? searchQuery
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      error: error ?? this.error,
        searchQuery: searchQuery ?? this.searchQuery
    );
  }
}
