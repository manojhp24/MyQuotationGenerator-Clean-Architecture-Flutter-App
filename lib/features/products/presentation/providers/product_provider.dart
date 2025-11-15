import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/products/domain/repository/product_repository.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/add_product_usecase.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/get_product_usecase.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_notifier.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_state.dart';

import '../../../../core/di/injection_container.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return sl<ProductRepository>();
});

final addProductUseCaseProvider = Provider<AddProductUseCase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return AddProductUseCase(repository);
});

final getProductUseCaseProvider = Provider<GetProductUseCase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return GetProductUseCase(repository);
});

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
      final addProductUseCase = ref.read(addProductUseCaseProvider);
      final getProductUseCase = ref.read(getProductUseCaseProvider);
      return ProductNotifier(addProductUseCase, getProductUseCase);
    });
