  import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/products/data/data_sources/product_local_database.dart';
import 'package:my_quotation_generator/features/products/domain/repository/product_repository.dart';

import '../../domain/entities/product.dart';
import '../models/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource productLocalDataSource;

  ProductRepositoryImpl(this.productLocalDataSource);

  @override
  Future<DataState<int>> addProduct(ProductEntity product) async {
    try {
      final model = ProductModel(
        id: product.id,
        productName: product.productName,
        price: product.price,
        unitMeasure: product.unitMeasure,
        gst: product.gst,
        description: product.description,
        hsn: product.hsn,
      );

      final id = await productLocalDataSource.addProduct(model.toMap());
      return DataSuccess(id);
    } catch (e) {
      return DataFailed(Exception('Failed to add products:$e'));
    }
  }

  @override
  Future<DataState<List<ProductEntity>>> getProducts() async {
    try {
      final List<Map<String, dynamic>> data = await productLocalDataSource
          .getProducts();
      final products = data
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList();
      return DataSuccess(products);
    } catch (e) {
      return DataFailed(Exception("Failed to fetch products $e"));
    }
  }

  @override
  Future<DataState<int>> updateProduct(ProductEntity product) async {
    try {
      if (product.id == null) {
        return DataFailed<int>(Exception("Product id required for update"));
      }

      final model = ProductModel.fromEntity(product);

      final rowUpdated = await productLocalDataSource.updateProduct(
          model.toMap(), product.id!);

      if (rowUpdated > 0) {
        return DataSuccess<int>(rowUpdated);
      } else {
        return DataFailed<int>(Exception("No product found to update"));
      }
    } catch (e) {
      return DataFailed<int>(Exception("Failed to update product."));
    }
  }

  @override
  Future<DataState<int>> deleteProduct(int productId) async {
    try {
      final rowDeleted = await productLocalDataSource.deleteProduct(productId);

      if (rowDeleted > 0) {
        return DataSuccess<int>(rowDeleted);
      } else {
        return DataFailed<int>(Exception("No Product found to delete"));
      }
    } catch (e) {
      return DataFailed<int>(Exception("Failed to delete product:$e"));
    }
  }
}
