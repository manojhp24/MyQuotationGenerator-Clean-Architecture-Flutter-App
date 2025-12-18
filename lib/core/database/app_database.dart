import 'package:my_quotation_generator/core/database/db_tables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database == null || !_database!.isOpen) {
      _database = await _initDB('app_database.db');
    }
    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  static Future<void> resetDatabase() async {
    if (_database != null) {
      try {
        await _database!.close();
      } catch (_) {}
    }
    _database = null;
  }

  static Future _createDB(Database db, int version) async {
    await db.execute(createBusinessTable);
    await db.execute(createCustomerTable);
    await db.execute(createProductTable);
    await db.execute(createQuotationTable);
    await db.execute(createQuotationItemsTable);
  }
}
