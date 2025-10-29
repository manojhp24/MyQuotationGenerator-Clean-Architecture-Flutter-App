import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';

/// Customer Model — bridges the Data and Domain layers
class CustomerModel extends CustomerEntity {
  const CustomerModel({
    super.id,
    super.customerName,
    super.email,
    super.mobile,
    super.address1,
    super.address2,
    super.state,
    super.gstIn,
    super.otherInfo,
    super.shippingAddress,
  });

  /// Entity → Model
  factory CustomerModel.fromEntity(CustomerEntity entity) {
    return CustomerModel(
      id: entity.id,
      customerName: entity.customerName,
      email: entity.email,
      mobile: entity.mobile,
      address1: entity.address1,
      address2: entity.address2,
      state: entity.state,
      gstIn: entity.gstIn,
      otherInfo: entity.otherInfo,
      shippingAddress: entity.shippingAddress,
    );
  }

  /// Model → Entity (useful when returning data from DB to UI)
  CustomerEntity toEntity() {
    return CustomerEntity(
      id: id,
      customerName: customerName,
      email: email,
      mobile: mobile,
      address1: address1,
      address2: address2,
      state: state,
      gstIn: gstIn,
      otherInfo: otherInfo,
      shippingAddress: shippingAddress,
    );
  }

  ///  Model → Map (for SQLite insert/update)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'email': email,
      'mobile': mobile,
      'address1': address1,
      'address2': address2,
      'state': state,
      'gstIn': gstIn,
      'otherInfo': otherInfo,
      'shippingAddress': shippingAddress,
    };
  }

  /// ✅ Map → Model (for SQLite query results)
  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as int?,
      customerName: map['customerName'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
      address1: map['address1'] ?? '',
      address2: map['address2'] ?? '',
      state: map['state'] ?? '',
      gstIn: map['gstIn'] ?? '',
      otherInfo: map['otherInfo'] ?? '',
      shippingAddress: map['shippingAddress'] ?? '',
    );
  }
}
