
import '../../domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.productName,
    required super.price,
    required super.unitMeasure,
    required super.gst,
    required super.description,
    required super.hsn,
  });

  /// Converts Entity to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'unitMeasure': unitMeasure,
      'gst': gst,
      'description': description,
      'hsn': hsn,
    };
  }

  /// Converts Map To Model
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      productName: map['productName'] ?? '',
      price: map['price'] ?? '',
      unitMeasure: map['unitMeasure'] ?? '',
      gst: map['gst'] ?? '',
      description: map['description'] ?? '',
      hsn: map['hsn'],
    );
  }
}


