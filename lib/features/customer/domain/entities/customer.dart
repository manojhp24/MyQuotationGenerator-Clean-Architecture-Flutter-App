import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final int? id;
  final String? customerName;
  final String? email;
  final String? mobile;
  final String? address1;
  final String? address2;
  final String? otherInfo;
  final String? gstIn;
  final String? state;
  final String? shippingAddress;

  const CustomerEntity({
    this.id,
    this.customerName,
    this.email,
    this.mobile,
    this.address1,
    this.address2,
    this.otherInfo,
    this.gstIn,
    this.state,
    this.shippingAddress,
  });

  @override
  List<Object?> get props => [
    id,
    customerName,
    email,
    mobile,
    address1,
    address2,
    otherInfo,
    gstIn,
    state,
    shippingAddress,
  ];
}
