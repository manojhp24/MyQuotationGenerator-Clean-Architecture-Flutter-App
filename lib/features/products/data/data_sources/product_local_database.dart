import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDataSource {

  final Database? testDb;

  ProductLocalDataSource({this.testDb});

  Future<int> addProduct(Map<String, dynamic> productMap) async {
    final db = testDb ?? await AppDatabase.database;
    return await db.insert(
      'products',
      productMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = testDb ?? await AppDatabase.database;
    return await db.query('products', orderBy: "id");
  }

  Future<int> updateProduct(Map<String, dynamic> productMap, int id) async {
    final db = testDb ?? await AppDatabase.database;

    return await db.update(
        'products', productMap, where: 'id=?', whereArgs: [id]);
  }
}
