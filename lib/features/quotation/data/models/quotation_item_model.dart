import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_item_entity.dart';

class QuotationItemModel extends QuotationItemEntity {
  const QuotationItemModel({
    super.id,
    required super.quotationId,
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.unitPrice,
    required super.gstPercent,
    required super.gstAmount,
    required super.totalPrice,
  });

  /// DB → Model
  factory QuotationItemModel.fromMap(Map<String, dynamic> map) {
    return QuotationItemModel(
      id: map['id'] as int?,
      quotationId: map['quotationId'] as int,
      productId: map['productId'] as int,
      productName: map['productName'] as String,
      quantity: map['quantity'] as int,
      unitPrice: (map['unitPrice'] as num).toDouble(),
      gstPercent: (map['gstPercent'] as num).toDouble(),
      gstAmount: (map['gstAmount'] as num).toDouble(),
      totalPrice: (map['totalPrice'] as num).toDouble(),
    );
  }

  /// Entity → Model
  factory QuotationItemModel.fromEntity(QuotationItemEntity entity) {
    return QuotationItemModel(
      id: entity.id,
      quotationId: entity.quotationId,
      productId: entity.productId,
      productName: entity.productName,
      quantity: entity.quantity,
      unitPrice: entity.unitPrice,
      gstPercent: entity.gstPercent,
      gstAmount: entity.gstAmount,
      totalPrice: entity.totalPrice,
    );
  }

  /// Model → DB
  Map<String, dynamic> toMap() => {
    'quotationId': quotationId,
    'productId': productId,
    'productName': productName,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'gstPercent': gstPercent,
    'gstAmount': gstAmount,
    'totalPrice': totalPrice,
  };
}

