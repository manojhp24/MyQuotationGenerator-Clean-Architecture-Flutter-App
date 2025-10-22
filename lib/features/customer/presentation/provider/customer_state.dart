import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';

class CustomerState {
  final bool isLoading;
  final List<CustomerEntity> customer;
  final String? error;

  CustomerState({this.isLoading = false, this.customer = const [], this.error});

  CustomerState copyWith({
    bool? isLoading,
    List<CustomerEntity>? customer,
    String? error,
  }) {
    return CustomerState(
      isLoading: isLoading ?? this.isLoading,
      customer: customer ?? this.customer,
      error: error ?? this.error,
    );
  }
}