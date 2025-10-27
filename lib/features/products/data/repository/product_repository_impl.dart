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
}
