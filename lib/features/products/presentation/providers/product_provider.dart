import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/add_product_usecase.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/get_product_usecase.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/update_product_usecase.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_notifier.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_state.dart';

import '../../../../core/di/injection_container.dart';
import '../../domain/usecases/delete_product_usecase.dart';

final productNotifierProvider =
StateNotifierProvider<ProductNotifier, ProductState>((ref) {
      return ProductNotifier(
        sl<AddProductUseCase>(),
        sl<GetProductUseCase>(),
        sl<UpdateProductUseCase>(),
        sl<DeleteProductUseCase>(),
      );
    });