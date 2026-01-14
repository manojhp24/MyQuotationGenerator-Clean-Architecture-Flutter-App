import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_entity.dart';

class QuotationModel extends QuotationEntity {
  const QuotationModel({
    super.id,
    required super.quoteNo,
    required super.customerId,
    required super.quoteDate,
    required super.subTotal,
    required super.taxTotal,
    required super.grandTotal,
    required super.pdfPath,
  });

  factory QuotationModel.fromEntity(QuotationEntity entity) {
    return QuotationModel(
      quoteNo: entity.quoteNo,
      customerId: entity.customerId,
      quoteDate: entity.quoteDate,
      subTotal: entity.subTotal,
      taxTotal: entity.taxTotal,
      grandTotal: entity.grandTotal,
      pdfPath: entity.pdfPath,
    );
  }

  QuotationEntity toEntity() {
    return QuotationEntity(
      id: id,
      quoteNo: quoteNo,
      customerId: customerId,
      quoteDate: quoteDate,
      subTotal: subTotal,
      taxTotal: taxTotal,
      grandTotal: grandTotal,
      pdfPath: pdfPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quoteNo': quoteNo,
      'customerId': customerId,
      'quoteDate': quoteDate.toIso8601String(),
      'subTotal': subTotal,
      'taxTotal': taxTotal,
      'grandTotal': grandTotal,
      'pdfPath': pdfPath,
    };
  }

  factory QuotationModel.fromMap(Map<String, dynamic> map) {
    return QuotationModel(
      id: map['id'] as int,
      quoteNo: map['quoteNo'] ?? '',
      customerId: map['customerId'] ?? '',
      quoteDate: DateTime.parse(map['quoteDate'] as String),
      subTotal: map['subTotal'] ?? '',
      taxTotal: map['taxTotal'] ?? '',
      grandTotal: map['grandTotal'] ?? '',
      pdfPath: map['pdfPath'] ?? '',
    );
  }
}
