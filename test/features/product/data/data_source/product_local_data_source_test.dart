import 'package:flutter_test/flutter_test.dart';
import 'package:my_quotation_generator/features/products/data/data_sources/product_local_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  late Database db;
  late ProductLocalDataSource productLocalDataSource;

  final Map<String, dynamic> productMap = {
    'id': 1,
    'productName': 'Laptop',
    'price': '50000.0',
    'unitMeasure': 'pcs',
    'gst': '18.0',
    'description': 'High-end laptop',
    'hsn': '8471',
  };

  setUp(() async {
    db = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
    CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productName TEXT,
        price TEXT,
        unitMeasure TEXT,
        gst TEXT,
        description TEXT,
        hsn TEXT
        )
    ''');
      },
    );

    productLocalDataSource = ProductLocalDataSource(testDb: db);
  });

  tearDown(() async {
    await db.close();
  });

  test(
    "should update existing product data and return 1 row affected",
    () async {
      final insertId = await productLocalDataSource.addProduct(productMap);
      expect(insertId, equals(1));

      final updateMap = Map<String, dynamic>.from(productMap)
        ..['productName'] = "Dell Laptop"
        ..['price'] = "20000.0";

      final rowAffected = await productLocalDataSource.updateProduct(
        updateMap,
        1,
      );

      expect(rowAffected, equals(1));

      final updatedRows = await db.query(
        'products',
        where: 'id=?',
        whereArgs: [1],
      );

      expect(updatedRows.length, equals(1));
      expect(updatedRows.first['productName'], equals("Dell Laptop"));
      expect(updatedRows.first['price'], equals("20000.0"));
    },
  );

  test("should return 0 when updating is non-existent record", () async {
    final result = await productLocalDataSource.updateProduct(productMap, 999);

    expect(result, equals(0));
  });
}
