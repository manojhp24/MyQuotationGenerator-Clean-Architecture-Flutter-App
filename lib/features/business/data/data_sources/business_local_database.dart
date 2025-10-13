// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class BusinessLocalDb{
  static Database ? _database;

  static Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('business.db');
    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,filePath);

    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

  static Future _createDB(Database db,int version) async {
    await db.execute('''
      CREATE TABLE business(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        businessName TEXT,
        contactName TEXT,
        mobileNumber TEXT,
        email TEXT,
        address1 TEXT,
        address2 TEXT,
        otherInfo TEXT,
        gstIN TEXT,
        state TEXT,
        businessCategory TEXT,
        accountName TEXT,
        accountNumber TEXT,
        bankName TEXT,
        upiId TEXT,
        )
    ''');
  }


}
