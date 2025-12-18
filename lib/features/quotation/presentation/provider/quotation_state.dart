import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_item_entity.dart';

class QuotationState {
  final bool isLoading;
  final DateTime date;
  final String? error;
  final List<QuotationItemEntity> items;
  final CustomerEntity? selectedCustomer;

  const QuotationState({
    this.isLoading = false,
    required this.date,
    this.error,
    this.items = const [],
    this.selectedCustomer,
  });

  factory QuotationState.initial() {
    return QuotationState(
      date: DateTime.now(),
    );
  }

  QuotationState copyWith({
    bool? isLoading,
    DateTime? date,
    String? quotationNo,
    String? referenceNote,
    String? error,
    List<QuotationItemEntity>? items,
    CustomerEntity? selectedCustomer,
  }) {
    return QuotationState(
      isLoading: isLoading ?? this.isLoading,
      date: date ?? this.date,
      error: error,
      items: items ?? this.items,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer ,
    );
  }

  double get subTotal =>
      items.fold(0, (sum, e) => sum + (e.unitPrice * e.quantity));

  double get taxTotal =>
      items.fold(0, (sum, e) => sum + e.gstAmount);

  double get grandTotal => subTotal + taxTotal;
}
