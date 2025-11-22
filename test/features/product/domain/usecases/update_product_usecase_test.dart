import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/products/domain/repository/product_repository.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/update_product_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late UpdateProductUseCase updateProductUseCase;
  late MockProductRepository productRepository;

  setUp(() {
    productRepository = MockProductRepository();
    updateProductUseCase = UpdateProductUseCase(productRepository);
  });

  final product = ProductEntity(
    id: 1,
    productName: 'Laptop',
    price: "50000.0",
    unitMeasure: 'pcs',
    gst: "18.0",
    description: 'High-end laptop',
    hsn: '8471',
  );

  group("UpdateProductUseCase Test", () {
    test("should update product data and return DataSuccess", () async {
      // Arrange
      when(
        () => productRepository.updateProduct(product),
      ).thenAnswer((_) async => DataSuccess(1));

      // Act
      final result = await updateProductUseCase(product);

      // Assert
      expect(result, isA<DataSuccess<int>>());
      expect(result.data, equals(1));
      verify(() => productRepository.updateProduct(product)).called(1);
      verifyNoMoreInteractions(productRepository);
    });

    test("should return DataFailed when repository throw exception", () async {
      // Arrange
      when(
        () => productRepository.updateProduct(product),
      ).thenAnswer((_) async => DataFailed(Exception("DB Error")));

      // Act
      final result = await updateProductUseCase(product);

      //Assert
      expect(result, isA<DataFailed<int>>());
      expect(result.error, isA<Exception>());
      expect((result as DataFailed).error.toString(), contains("DB Error"));
      verify(() => productRepository.updateProduct(product)).called(1);
      verifyNoMoreInteractions(productRepository);
    });
  });
}
