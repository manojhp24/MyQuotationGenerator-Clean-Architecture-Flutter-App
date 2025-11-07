import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:my_quotation_generator/features/business/domain/repository/business_repository.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/update_business_usecase.dart';

class MockBusinessRepository extends Mock implements BusinessRepository {}

void main() {
  late UpdateBusinessUseCase updateBusinessUseCase;
  late MockBusinessRepository mockBusinessRepository;

  setUp(() {
    mockBusinessRepository = MockBusinessRepository();
    updateBusinessUseCase = UpdateBusinessUseCase(mockBusinessRepository);
  });

  const business = BusinessEntity(
    id: 1,
    businessName: "GowriEvents",
    mobileNumber: "6361337631",
    email: "manojhp584@gmail.com",
    address1: "krs",
    address2: "mysore",
    gstIn: "27AAACT2727Q1ZW",
    otherInfo: "Sample",
    state: "Karnataka",
    upiId: "6361337631@ibl",
    bankName: "Canara",
    accountNumber: "6361336314",
    accountName: "Manoj Hp",
    contactName: "MAnojhp",
    businessCategory: "Events",
  );

  group("UpdateBusinessUseCase Test -", () {
    test("should update business successful and return DataSuccess", () async {
      // Arrange
      when(
        () => mockBusinessRepository.updateBusiness(business),
      ).thenAnswer((_) async => DataSuccess(1));

      // Act
      final result = await updateBusinessUseCase(business);

      // Assert
      expect(result, isA<DataState<int>>());
      expect(result.data, equals(1));
      verify(() => mockBusinessRepository.updateBusiness(business)).called(1);
    });

    test("should return DataFailed when repository throws error", () async {
      // Arrange
      when(
        () => mockBusinessRepository.updateBusiness(business),
      ).thenThrow(Exception("Database error"));

      // Act
      final result = await updateBusinessUseCase(business);

      // Assert
      expect(result, isA<DataFailed<int>>());
      expect(result.error, isA<Exception>());
      verify(() => mockBusinessRepository.updateBusiness(business)).called(1);

    });
  });
}
