import 'package:equatable/equatable.dart';

class QuotationEntity extends Equatable {
  final int? id;
  final String quoteNo;
  final int customerId;
  final DateTime quoteDate;
  final String? referenceNote;
  final double subTotal;
  final double taxTotal;
  final double grandTotal;
  final String pdfPath;

  const QuotationEntity({
    this.id,
    required this.quoteNo,
    required this.customerId,
    required this.quoteDate,
    this.referenceNote,
    required this.subTotal,
    required this.taxTotal,
    required this.grandTotal,
    required this.pdfPath,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    quoteNo,
    customerId,
    quoteDate,
    referenceNote,
    subTotal,
    taxTotal,
    grandTotal,
    pdfPath,
  ];
}
