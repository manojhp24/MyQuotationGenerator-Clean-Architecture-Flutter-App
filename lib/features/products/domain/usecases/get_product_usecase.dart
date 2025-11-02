import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/products/domain/repository/product_repository.dart';

class GetProductUseCase extends UseCase<DataState<List<ProductEntity>>, void> {
  final ProductRepository _repository;

  GetProductUseCase(this._repository);

  @override
  Future<DataState<List<ProductEntity>>> call([void _]) {
    return _repository.getProducts();
  }
}
