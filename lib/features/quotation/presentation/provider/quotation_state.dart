import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';

class QuotationState {
  final bool isLoading;
  final DateTime? date;
  final String? error;
  final List<ProductEntity> selectedProduct;
  final List<CustomerEntity> selectedCustomer;

  const QuotationState({
    this.isLoading = false,
    this.date,
    this.error,
    this.selectedProduct = const [],
    this.selectedCustomer = const [],
  });

  QuotationState copyWith({
    bool? isLoading,
    DateTime? date,
    String? quotationNo,
    String? referenceNote,
    String? error,
    List<ProductEntity>? selectedProduct,
    List<CustomerEntity>? selectedCustomer,
  }) {
    return QuotationState(
      isLoading: isLoading ?? this.isLoading,
      date: date ?? this.date,
      error: error,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
    );
  }
}
