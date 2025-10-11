import 'package:my_quotation_generator/features/bussiness/domain/entities/business.dart';


// BusinessModel: handles SQLite conversions
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

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'businessName':businessName,
      'contactName' : contactName,
      'mobileNumber':mobileNumber,
      'email':email,
      'address1':address1,
      'address2':address2,
      'otherInfo':otherInfo,
      'gstIn':gstIn,
      'state':state,
      'businessCategory':businessCategory,
      'accountNumber':accountNumber,
      'accountName':accountName,
      'bankName':bankName,
      'upiId':upiId
    };
  }

  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
      id: map['id'] as int?,
      businessName: map['businessName'] ?? '',
      contactName: map['contactName'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      email: map['email'],
      address1: map['address1'],
      address2: map['address2'],
      otherInfo: map['otherInfo'],
      gstIn: map['gstIn'],
      state: map['state'],
      businessCategory: map['businessCategory'],
      accountNumber: map['accountNumber'],
      accountName: map['accountName'],
      bankName: map['bankName'],
      upiId: map['upiId'],
    );
  }

}
