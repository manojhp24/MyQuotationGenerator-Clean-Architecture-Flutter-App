import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class BusinessLocalDataSource {
  Future<int> addBusiness(Map<String, dynamic> businessMap) async {
    final db = await AppDatabase.database;
    return await db.insert(
      'business',
      businessMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
