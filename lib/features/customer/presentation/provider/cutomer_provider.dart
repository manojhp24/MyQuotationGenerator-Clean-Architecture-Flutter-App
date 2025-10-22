import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/customer/data/repository/customer_repository_impl.dart';
import 'package:my_quotation_generator/features/customer/domain/repository/customer_repository.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/add_customer_usecases.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_notifier.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_state.dart';

import '../../../../core/di/injection_container.dart';

///Customer Repository Provider
final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return sl<CustomerRepositoryImpl>();
});

/// AddCustomerUseCase Provider
final addCustomerUseCase = Provider<AddCustomerUseCase>((ref) {
  final repository = ref.read(customerRepositoryProvider);
  return AddCustomerUseCase(repository);
});

final customerNotifierProvider =
    StateNotifierProvider<CustomerNotifier, CustomerState>((ref) {
      return CustomerNotifier(sl<AddCustomerUseCase>());
    });
