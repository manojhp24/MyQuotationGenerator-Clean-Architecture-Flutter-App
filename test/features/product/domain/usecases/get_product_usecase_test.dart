import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/products/domain/repository/product_repository.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/get_product_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProductUseCase getProductUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProductUseCase = GetProductUseCase(mockProductRepository);
  });

  const productList = [
    ProductEntity(
      id: 1,
      productName: 'Laptop',
      price: "50000.0",
      unitMeasure: 'pcs',
      gst: "18.0",
      description: 'High-end laptop',
      hsn: '8471',
    ),
    ProductEntity(
      id: 2,
      productName: 'Mouse',
      price: "500.0",
      unitMeasure: 'pcs',
      gst: "18.0",
      description: 'Wireless mouse',
      hsn: '8471',
    ),
  ];

  test("should return list of products from datasource", () async {
    // Arrange
    when(
      () => mockProductRepository.getProducts(),
    ).thenAnswer((_) async => DataSuccess(productList));

    // Act
    final result = await getProductUseCase();

    //assert
    expect(result, isA<DataState<List<ProductEntity>>>());
    expect(result.data, equals(productList));
    verify(() => mockProductRepository.getProducts()).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });
}
