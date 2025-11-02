// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:my_quotation_generator/core/resource/data_state.dart';
// import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
// import 'package:my_quotation_generator/features/customer/domain/repository/customer_repository.dart';
// import 'package:my_quotation_generator/features/customer/domain/usecases/add_customer_usecases.dart';
//
// class MockCustomerRepository extends Mock implements CustomerRepository {}
//
// void main() {
//
//   late AddCustomerUseCase useCase;
//   late MockCustomerRepository mockRepository;
//
//   setUp(() {
//     mockRepository = MockCustomerRepository();
//     useCase = AddCustomerUseCase(mockRepository);
//   });
//
//   test('should call addCustomer on repository', () async {
//     // arrange
//     final customer = CustomerEntity(customerName: 'John');
//     when(() => mockRepository.addCustomer(customer))
//         .thenAnswer((_) async => DataSuccess(1));
//
//     // act
//     final result = await useCase(customer);
//
//     // assert
//     expect(result, isA<DataSuccess<int>>());
//     verify(() => mockRepository.addCustomer(customer)).called(1);
//   });
//
//
//   final testCustomer = CustomerEntity(
//     customerName: "Darshan",
//     mobile: "9945651884",
//     shippingAddress: "KRS",
//     state: "Karnataka",
//     gstIn: "",
//     otherInfo: "",
//     address2: "KRS",
//     address1: "Mysore",
//     email: "darshan@gmail.com",
//   );
//
//   test("should return DataSuccess<int> when addCustomer succeed ", () async {
//     when(
//       () => mockRepository.addCustomer(testCustomer),
//     ).thenAnswer((_) async => DataSuccess(1));
//
//     final result = await useCase.call(testCustomer);
//
//     expect(result, isA<DataSuccess<int>>());
//     expect((result as DataSuccess<int>).data, 1);
//   });
//
// }
