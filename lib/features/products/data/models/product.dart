import '../../domain/entities/product.dart';

/// Product Model — bridges the Data and Domain layers
class ProductModel extends ProductEntity {
  const ProductModel({
    super.id,
    required super.productName,
    required super.price,
    required super.unitMeasure,
    required super.gst,
    required super.description,
    required super.hsn,
  });

  /// ✅ Entity → Model
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      productName: entity.productName,
      price: entity.price,
      unitMeasure: entity.unitMeasure,
      gst: entity.gst,
      description: entity.description,
      hsn: entity.hsn,
    );
  }

  /// ✅ Model → Entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      productName: productName,
      price: price,
      unitMeasure: unitMeasure,
      gst: gst,
      description: description,
      hsn: hsn,
    );
  }

  /// ✅ Model → Map (for SQLite insert/update)
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

  /// ✅ Map → Model (for SQLite query results)
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int?,
      productName: map['productName'] ?? '',
      price: map['price'] ?? 0,
      unitMeasure: map['unitMeasure'] ?? '',
      gst: map['gst'] ?? 0,
      description: map['description'] ?? '',
      hsn: map['hsn'] ?? '',
    );
  }
}
