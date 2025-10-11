import 'package:equatable/equatable.dart';

// BusinessEntity: pure data for domain layer
class BusinessEntity extends Equatable{
  final int? id;
  final String? businessName;
  final String? contactName;
  final String? mobileNumber;
  final String? email;
  final String? address1;
  final String? address2;
  final String? otherInfo;
  final String? gstIn;
  final String? state;
  final String? businessCategory;
  final String? accountName;
  final String? accountNumber;
  final String? bankName;
  final String? upiId;

  const BusinessEntity({
    this.id,
    this.businessName,
    this.contactName,
    this.mobileNumber,
    this.email,
    this.address1,
    this.address2,
    this.otherInfo,
    this.gstIn,
    this.state,
    this.businessCategory,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.upiId,
  });

  @override
  List<Object?> get props => [
    id,
    businessName,
    contactName,
    mobileNumber,
    email,
    address1,
    address2,
    otherInfo,
    gstIn,
    state,
    businessCategory,
    accountName,
    accountNumber,
    bankName,
    upiId,
  ];
}


