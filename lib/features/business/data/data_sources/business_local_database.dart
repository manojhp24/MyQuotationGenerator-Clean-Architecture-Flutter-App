import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:sqflite/sqflite.dart';

class BusinessLocalDataSource {
  Future<int> addBusiness(BusinessEntity business) async {
    final db = await AppDatabase.database;

    return await db.insert(
      'business',
      {
        'businessName': business.businessName,
        'contactName': business.contactName,
        'mobileNumber': business.mobileNumber,
        'email': business.email,
        'address1': business.address1,
        'address2': business.address2,
        'otherInfo': business.otherInfo,
        'gstIN': business.gstIn,
        'state': business.state,
        'businessCategory': business.businessCategory,
        'accountName': business.accountName,
        'accountNumber': business.accountNumber,
        'bankName': business.bankName,
        'upiId': business.upiId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
