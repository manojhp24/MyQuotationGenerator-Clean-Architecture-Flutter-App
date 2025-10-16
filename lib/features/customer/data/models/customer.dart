import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';

/// Customer Model: handles SQLite conversions like Entity -> Map / Map -> Model
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

  /// Converts Entity -> Map
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

  /// Converts Map -> Model
  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as int,
      customerName: map['customerName'] ?? '',
      email: map['email'] ?? '',
      address1: map['address1'] ?? '',
      address2: map['address2'] ?? '',
      state: map['state'] ?? '',
      gstIn: map['gstIn'] ?? '',
      otherInfo: map['otherInfo'] ?? '',
      shippingAddress: map['shippingAddress'] ?? '',
    );
  }
}
