import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/products/data/data_sources/product_local_database.dart';
import 'package:my_quotation_generator/features/products/data/repository/product_repository_impl.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';

class MockProductLocalDataSource extends Mock
    implements ProductLocalDataSource {}

void main() {
  late ProductRepositoryImpl repository;
  late MockProductLocalDataSource mockProductLocalDataSource;

  setUp(() {
    mockProductLocalDataSource = MockProductLocalDataSource();
    repository = ProductRepositoryImpl(mockProductLocalDataSource);
  });

  final productMapList = [
    {
      'id': 1,
      'productName': 'Laptop',
      'price': '50000.0',
      'unitMeasure': 'pcs',
      'gst': '18.0',
      'description': 'High-end laptop',
      'hsn': '8471',
    },
  ];

  final productEntityList = [
    ProductEntity(
      id: 1,
      productName: 'Laptop',
      price: '50000.0',
      unitMeasure: 'pcs',
      gst: '18.0',
      description: 'High-end laptop',
      hsn: '8471',
    ),
  ];

  group("Product Repository-", () {
    test(
      "should return DataSuccess when local datasource return list",
      () async {
        // arrange
        when(
          () => mockProductLocalDataSource.getProducts(),
        ).thenAnswer((_) async => productMapList);

        // act
        final result = await repository.getProducts();

        //Assert
        expect(result, isA<DataSuccess<List<ProductEntity>>>());
        expect(result.data!.length, 1);
        expect(result.data, equals(productEntityList));
        verify(() => mockProductLocalDataSource.getProducts()).called(1);
      },
    );

    test("should return DataFailed when local dataSource throws exception", () async {
      // arrange
      when(
        () => mockProductLocalDataSource.getProducts(),
      ).thenThrow(Exception("Data base error"));

      // act 
      final result = await repository.getProducts();

      // Assert
      expect(result, isA<DataFailed>());
      expect(result.error, isA<Exception>());
      expect(result.error.toString(), contains("Data base error"));
      verify(() => mockProductLocalDataSource.getProducts()).called(1);
    });
  });
}
