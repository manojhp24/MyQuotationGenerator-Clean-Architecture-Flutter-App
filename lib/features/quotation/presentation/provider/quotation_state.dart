import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_item_entity.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_list_ui_model.dart';

class QuotationState {
  final bool isLoading;
  final DateTime date;
  final String? error;
  final List<QuotationItemEntity> items;
  final List<QuotationListItem> quotations;
  final CustomerEntity? selectedCustomer;

  const QuotationState({
    this.isLoading = false,
    required this.date,
    this.error,
    this.items = const [],
    this.quotations = const [],
    this.selectedCustomer,
  });

  factory QuotationState.initial() {
    return QuotationState(
      date: DateTime.now(),
    );
  }

  static const Object _noChange = Object();

  QuotationState copyWith({
    bool? isLoading,
    DateTime? date,
    String? error,
    List<QuotationItemEntity>? items,
    List<QuotationListItem>? quotations,
    Object? selectedCustomer = _noChange,
  }) {
    return QuotationState(
      isLoading: isLoading ?? this.isLoading,
      date: date ?? this.date,
      error: error ?? this.error,
      items: items ?? this.items,
      quotations: quotations ?? this.quotations,
      selectedCustomer: selectedCustomer == _noChange
          ? this.selectedCustomer
          : selectedCustomer as CustomerEntity?,
    );
  }


  double get subTotal =>
      items.fold(0, (sum, e) => sum + (e.unitPrice * e.quantity));

  double get taxTotal =>
      items.fold(0, (sum, e) => sum + e.gstAmount);

  double get grandTotal => subTotal + taxTotal;
}

extension QuotationNumberExt on QuotationState {
  String get nextQuotationNo {
    final nextId = quotations.isEmpty
        ? 1
        : quotations.last.quotationId + 1;

    return 'QUOT-${nextId.toString().padLeft(3, '0')}';
  }
}
