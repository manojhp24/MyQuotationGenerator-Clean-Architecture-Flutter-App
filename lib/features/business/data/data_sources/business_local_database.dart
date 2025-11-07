import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class BusinessLocalDataSource {
  final Database? testDb;

  BusinessLocalDataSource({this.testDb});

  Future<int> addBusiness(Map<String, dynamic> businessMap) async {
    final db = testDb ?? await AppDatabase.database;
    return await db.insert(
      'business',
      businessMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateBusiness(Map<String, dynamic> businessMap, int id) async {
    final db = testDb ?? await AppDatabase.database;
    return await db.update(
      "business",
      businessMap,
      where: 'id= ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
