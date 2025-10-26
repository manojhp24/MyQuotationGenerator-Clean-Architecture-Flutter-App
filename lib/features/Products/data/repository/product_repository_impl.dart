import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/Products/data/data_sources/product_local_database.dart';
import 'package:my_quotation_generator/features/Products/data/models/product.dart';
import 'package:my_quotation_generator/features/Products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/Products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataBase productLocalDataBase;

  ProductRepositoryImpl(this.productLocalDataBase);

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

      final id = await productLocalDataBase.addProduct(model.toMap());
      return DataSuccess(id);
    } catch (e) {
      return DataFailed(Exception('Failed to add product:$e'));
    }
  }
}
