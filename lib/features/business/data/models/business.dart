import 'package:my_quotation_generator/features/business/domain/entities/business.dart';

// BusinessModel: bridges between Domain Entity and SQLite (Data layer)
class BusinessModel extends BusinessEntity {
  const BusinessModel({
    super.id,
    super.businessName,
    super.contactName,
    super.mobileNumber,
    super.email,
    super.address1,
    super.address2,
    super.otherInfo,
    super.gstIn,
    super.state,
    super.businessCategory,
    super.accountNumber,
    super.accountName,
    super.bankName,
    super.upiId,
  });

  /// Converts Entity → Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessName': businessName,
      'contactName': contactName,
      'mobileNumber': mobileNumber,
      'email': email,
      'address1': address1,
      'address2': address2,
      'otherInfo': otherInfo,
      'gstIn': gstIn,
      'state': state,
      'businessCategory': businessCategory,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'bankName': bankName,
      'upiId': upiId,
    };
  }

  /// Converts Map → Model (when reading from SQLite)
  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
      id: map['id'] as int?,
      businessName: map['businessName'] ?? '',
      contactName: map['contactName'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      email: map['email'] ?? '',
      address1: map['address1'] ?? '',
      address2: map['address2'] ?? '',
      otherInfo: map['otherInfo'] ?? '',
      gstIn: map['gstIn'] ?? '',
      state: map['state'] ?? '',
      businessCategory: map['businessCategory'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
      accountName: map['accountName'] ?? '',
      bankName: map['bankName'] ?? '',
      upiId: map['upiId'] ?? '',
    );
  }

  /// ✅ Converts Domain Entity → Data Model
  factory BusinessModel.fromEntity(BusinessEntity entity) {
    return BusinessModel(
      id: entity.id,
      businessName: entity.businessName,
      contactName: entity.contactName,
      mobileNumber: entity.mobileNumber,
      email: entity.email,
      address1: entity.address1,
      address2: entity.address2,
      otherInfo: entity.otherInfo,
      gstIn: entity.gstIn,
      state: entity.state,
      businessCategory: entity.businessCategory,
      accountNumber: entity.accountNumber,
      accountName: entity.accountName,
      bankName: entity.bankName,
      upiId: entity.upiId,
    );
  }
}
