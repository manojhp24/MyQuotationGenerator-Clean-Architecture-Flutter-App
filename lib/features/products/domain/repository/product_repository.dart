import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<DataState<int>> addProduct(ProductEntity product);
  Future<DataState<List<ProductEntity>>> getProducts();
  Future<DataState<int>> updateProduct(ProductEntity product);
  Future<DataState<int>> deleteProduct(int productId);
}
