import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:my_quotation_generator/core/database/db_tables.dart';
import 'package:sqflite/sqflite.dart';

class QuotationLocalDataSource {
  final Database? testDb;

  QuotationLocalDataSource({this.testDb});

  Future<int> insertQuotation(Map<String, dynamic> quotationMap) async {
    final db = testDb ?? await AppDatabase.database;
    return db.insert('quotations', quotationMap);
  }

  Future<void> insertQuotationItem(
      Map<String, dynamic> quotationItemsMap) async {
    final db = testDb ?? await AppDatabase.database;
    await db.insert('quotation_items', quotationItemsMap);
  }

  Future<Map<String, dynamic>> getQuotationById(int id) async {
    final db = testDb ?? await AppDatabase.database;
    final res =
    await db.query('quotations', where: 'id=?', whereArgs: [id]);
    return res.first;
  }

  Future<List<Map<String, dynamic>>> getQuotationItems(int id) async {
    final db = testDb ?? await AppDatabase.database;
    return db.query(
      'quotation_items',
      where: 'quotationId=?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getQuotationList() async {
    final db = await AppDatabase.database;
    return db.rawQuery(getQuotationListQuery);
  }

}
