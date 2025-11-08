import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/business/data/data_sources/business_local_database.dart';
import 'package:my_quotation_generator/features/business/data/repository/business_repository_impl.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';

class MockBusinessLocalDataSource extends Mock
    implements BusinessLocalDataSource {}

void main() {
  late BusinessRepositoryImpl mockBusinessRepository;
  late MockBusinessLocalDataSource mockBusinessLocalDataSource;

  setUp(() {
    mockBusinessLocalDataSource = MockBusinessLocalDataSource();
    mockBusinessRepository = BusinessRepositoryImpl(
      mockBusinessLocalDataSource,
    );
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

  group(("BusinessRepositoryImpl Test-"), () {
    // ---- UPDATE TEST ----
    test(
      "should return DataSuccess when local data source updated successfully",
      () async {
        // Arrange
        when(
          () => mockBusinessLocalDataSource.updateBusiness(any(), any()),
        ).thenAnswer((_) async => 1);

        // Act
        final result = await mockBusinessRepository.updateBusiness(business);

        //Assert
        expect(result, isA<DataSuccess<int>>());
        expect(result.data, equals(1));
        verify(
          () => mockBusinessLocalDataSource.updateBusiness(any(), any()),
        ).called(1);
      },
    );

    test(
      "should return DataFailed when local data source throw exception",
      () async {
        // Arrange
        when(
          () => mockBusinessLocalDataSource.updateBusiness(any(), any()),
        ).thenThrow(Exception("Database error"));

        // Act
        final result = await mockBusinessRepository.updateBusiness(business);

        // Assert
        expect(result, isA<DataFailed<int>>());
        expect(result.error, isA<Exception>());
        verify(
          () => mockBusinessLocalDataSource.updateBusiness(any(), any()),
        ).called(1);
      },
    );

    // ---- GET TEST ----

    test(
        "should return DataSuccess when local data source returns business data", () async {
      // Arrange
      final businessMap = {
        'id': 1,
        'businessName': 'GowriEvents',
        'contactName': 'Manoj HP',
        'mobileNumber': '6361337631',
        'email': 'manojhp584@gmail.com',
        'address1': 'KRS',
        'address2': 'Mysore',
        'otherInfo': 'Sample Info',
        'gstIn': '27AAACT2727Q1ZW',
        'state': 'Karnataka',
        'upiId': '6361337631@ibl',
        'bankName': 'Canara',
        'accountNumber': '6361336314',
        'accountName': 'Manoj HP',
        'businessCategory': 'Events',
      };

      when(() => mockBusinessLocalDataSource.getBusiness()).thenAnswer((
          _) async => [businessMap]);

      // Act
      final result = await mockBusinessRepository.getBusiness();

      // Assert
      expect(result, isA<DataSuccess<List<BusinessEntity>>>());
      expect(result.data?.first.businessName, equals('GowriEvents'));
      verify(() => mockBusinessLocalDataSource.getBusiness()).called(1);
    });

    test(
        "should return DataFailed when local data source throws error", () async {
      // Arrange
      when(() => mockBusinessLocalDataSource.getBusiness()).thenThrow(
          Exception("Db error"));
      // Act

      final result = await mockBusinessRepository.getBusiness();

      // Assert
      expect(result, isA<DataFailed<List<BusinessEntity>>>());
      expect(result.error, isA<Exception>());
      verify(() => mockBusinessLocalDataSource.getBusiness()).called(1);
    });
    
  });
}
