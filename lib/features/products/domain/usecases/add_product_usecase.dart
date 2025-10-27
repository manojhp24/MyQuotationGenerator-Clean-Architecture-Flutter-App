import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';

import 'package:my_quotation_generator/features/products/domain/repository/product_repository.dart';

import '../entities/product.dart';

class AddProductUseCase extends UseCase<DataState<int>, ProductEntity> {
  final ProductRepository _repository;

  AddProductUseCase(this._repository);

  @override
  Future<DataState<int>> call(ProductEntity product) {
    return _repository.addProduct(product);
  }
}
