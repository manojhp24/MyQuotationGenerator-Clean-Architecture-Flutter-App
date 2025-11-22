import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/products/domain/repository/product_repository.dart';

class UpdateProductUseCase extends UseCase<DataState<int>, ProductEntity> {
  final ProductRepository _repository;

  UpdateProductUseCase(this._repository);

  @override
  Future<DataState<int>> call(ProductEntity product) {
    return _repository.updateProduct(product);
  }
}
