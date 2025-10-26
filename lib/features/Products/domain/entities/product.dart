import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String productName;
  final String price;
  final String unitMeasure;
  final String gst;
  final String description;
  final String hsn;

  const ProductEntity({
    required this.id,
    required this.productName,
    required this.price,
    required this.unitMeasure,
    required this.gst,
    required this.description,
    required this.hsn,
  });

  @override
  List<Object?> get props => [
    id,
    productName,
    price,
    unitMeasure,
    gst,
    description,
    hsn,
  ];
}
