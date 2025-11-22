import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/products/domain/repository/product_repository.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/delete_product_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late DeleteProductUseCase deleteProductUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProductUseCase = DeleteProductUseCase(mockProductRepository);
  });

  group("Delete UseCase Test -", () {
    test("should return DataSuccess<int> when the product deleted", () async {
      // Arrange
      when(
        () => mockProductRepository.deleteProduct(1),
      ).thenAnswer((_) async => DataSuccess(1));

      // Act

      final result = await deleteProductUseCase(1);

      // Assert
      expect(result, isA<DataState<int>>());
      expect((result as DataSuccess<int>).data, 1);
      verify(() => mockProductRepository.deleteProduct(1)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });

    test(
      "should return DataFailed when the repository throw exception",
      () async {
        //Arrange
        when(
          () => mockProductRepository.deleteProduct(1),
        ).thenAnswer((_) async => DataFailed(Exception("DB Error")));

        // Act

        final result = await deleteProductUseCase(1);

        //Assert
        expect(result, isA<DataFailed<int>>());
        expect(result.error, isA<Exception>());
        expect(
          (result as DataFailed<int>).error.toString(),
          contains("DB Error"),
        );
        verify(() => mockProductRepository.deleteProduct(any())).called(1);
        verifyNoMoreInteractions(mockProductRepository);
      },
    );
  });
}
