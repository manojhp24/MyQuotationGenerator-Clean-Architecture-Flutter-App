import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class CustomerLocalDataSource {
  /// CREATE
  Future<int> addCustomer(Map<String, dynamic> customerMap) async {
    try {
      final db = await AppDatabase.database;
      return await db.insert(
        'customer',
        customerMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// READ
  Future<List<Map<String, dynamic>>> getCustomers() async {
    try {
      final db = await AppDatabase.database;
      final result = await db.query('customer', orderBy: 'customerName ASC');
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getCustomerById(int id) async {
    final db = await AppDatabase.database;
    final result = await db.query("customer", where: 'id=?', whereArgs: [id],);
    return result.first;
  }

  /// UPDATE
  Future<int> updateCustomer(Map<String, dynamic> customerMap, int id) async {
    try {
      final db = await AppDatabase.database;
      customerMap.remove('id');

      return await db.update(
        'customer',
        customerMap,
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE
  Future<int> deleteCustomer(int id) async {
    try {
      final db = await AppDatabase.database;
      return await db.delete(
        'customer',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      rethrow;
    }
  }


}
