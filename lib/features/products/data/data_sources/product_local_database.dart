import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDataSource {
  Future<int> addProduct(Map<String, dynamic> productMap) async {
    final db = await AppDatabase.database;
    return await db.insert(
      'products',
      productMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await AppDatabase.database;
    return await db.query('products', orderBy: "id");
  }
}
