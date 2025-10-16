import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class CustomerLocalDataSource {
  Future<int> addCustomer(Map<String, dynamic> customerMap) async {
    final db = await AppDatabase.database;

    return await db.insert(
      'customer',
      customerMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
