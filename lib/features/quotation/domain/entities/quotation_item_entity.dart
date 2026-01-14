import 'package:equatable/equatable.dart';

class QuotationItemEntity extends Equatable {
  final int? id;
  final int? quotationId;
  final int productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double gstPercent;
  final double gstAmount;
  final double totalPrice;

  const QuotationItemEntity({
    this.id,
    this.quotationId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.gstPercent,
    required this.gstAmount,
    required this.totalPrice,
  });

  // ✅ ADD THIS METHOD
  QuotationItemEntity copyWith({
    int? id,
    int? quotationId,
    int? productId,
    String? productName,
    int? quantity,
    double? unitPrice,
    double? gstPercent,
    double? gstAmount,
    double? totalPrice,
  }) {
    return QuotationItemEntity(
      id: id ?? this.id,
      quotationId: quotationId ?? this.quotationId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      gstPercent: gstPercent ?? this.gstPercent,
      gstAmount: gstAmount ?? this.gstAmount,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [
    id,
    quotationId,
    productId,
    productName,
    quantity,
    unitPrice,
    gstPercent,
    gstAmount,
    totalPrice,
  ];
}
