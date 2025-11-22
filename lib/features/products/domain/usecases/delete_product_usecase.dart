import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/products/domain/repository/product_repository.dart';

class DeleteProductUseCase extends UseCase<DataState<int>, int> {
  final ProductRepository _repository;

  DeleteProductUseCase(this._repository);

  @override
  Future<DataState<int>> call(int productId) {
    return _repository.deleteProduct(productId);
  }
}
