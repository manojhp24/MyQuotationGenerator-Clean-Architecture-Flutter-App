import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDataBase {
  Future<int> addProduct(Map<String, dynamic> productMap) async {
    final db = await AppDatabase.database;
    return await db.insert(
      'product',
      productMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
