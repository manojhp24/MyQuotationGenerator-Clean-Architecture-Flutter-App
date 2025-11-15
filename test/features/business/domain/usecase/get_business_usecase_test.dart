import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:my_quotation_generator/features/business/domain/repository/business_repository.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/get_business_usecase.dart';

class MockBusinessRepository extends Mock implements BusinessRepository {}

void main() {
  late GetBusinessUseCase getBusinessUseCase;
  late MockBusinessRepository mockBusinessRepository;

  setUp(() {
    mockBusinessRepository = MockBusinessRepository();
    getBusinessUseCase = GetBusinessUseCase(mockBusinessRepository);
  });

  const business = BusinessEntity(
    id: 1,
    businessName: 'GowriEvents',
    contactName: 'Manoj Hp',
    mobileNumber: '6361337631',
    email: 'manojhp584@gmail.com',
    address1: 'KRS',
    address2: 'Mysore',
    otherInfo: 'Sample Info',
    gstIn: '27AAACT2727Q1ZW',
    state: 'Karnataka',
    upiId: '6361337631@ibl',
    bankName: 'Canara',
    accountNumber: '6361336314',
    accountName: 'Manoj Hp',
    businessCategory: 'Events',
  );

  group("Get BusinessUseCase Test", () {
    test(
      "should return DataSuccess when repository returns business data ",
      () async {
        // Arrange
        when(
          () => mockBusinessRepository.getBusiness(),
        ).thenAnswer((_) async => DataSuccess([business]));

        // Act
        final data = await getBusinessUseCase();

        // Assert
        expect(data, isA<DataSuccess<List<BusinessEntity>>>());
        expect(data.data, equals([business]));
        verify(() => mockBusinessRepository.getBusiness()).called(1);
        verifyNoMoreInteractions(mockBusinessRepository);
      },
    );

    test("should return DataFailed when repository throws error", () async {
      // Arrange
      when(
        () => mockBusinessRepository.getBusiness(),
      ).thenAnswer((_) async => DataFailed(Exception("DB Error")));

      //Act
      final result = await getBusinessUseCase();

      // Assert
      expect(result, isA<DataFailed<List<BusinessEntity>>>());
      expect(result.error, isA<Exception>());
      verify(() => mockBusinessRepository.getBusiness()).called(1);
    });
  });
}
