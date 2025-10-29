import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/core/di/injection_container.dart';
import 'package:my_quotation_generator/features/customer/domain/repository/customer_repository.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/add_customer_usecases.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/get_customers_usecase.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/update_customer_usecase.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_notifier.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_state.dart';

/// Repository Provider
final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return sl<CustomerRepository>();
});

/// Add Customer UseCase Provider
final addCustomerUseCaseProvider = Provider<AddCustomerUseCase>((ref) {
  final repo = ref.read(customerRepositoryProvider);
  return AddCustomerUseCase(repo);
});

/// Get Customer UseCase Provider
final getCustomerUseCaseProvider = Provider<GetCustomerUseCase>((ref) {
  final repo = ref.read(customerRepositoryProvider);
  return GetCustomerUseCase(repo);
});

/// Update customer UseCase Provider
final updateCustomerUseCaseProvider = Provider<UpdateCustomerUseCase>((ref) {
  final repo = ref.read(customerRepositoryProvider);
  return UpdateCustomerUseCase(repo);
});

/// Customer Notifier Provider
final customerNotifierProvider =
StateNotifierProvider<CustomerNotifier, CustomerState>((ref) {
      final addUseCase = ref.read(addCustomerUseCaseProvider);
      final getUseCase = ref.read(getCustomerUseCaseProvider);
      final updateUSeCase = ref.read(updateCustomerUseCaseProvider);
      return CustomerNotifier(addUseCase, getUseCase, updateUSeCase);
    });
