import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<DataState<int>> addProduct(ProductEntity product);
}
