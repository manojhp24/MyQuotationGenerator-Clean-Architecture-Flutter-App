import 'package:flutter_test/flutter_test.dart';
import 'package:my_quotation_generator/features/business/data/data_sources/business_local_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  late Database db;
  late BusinessLocalDataSource dataSource;

  final Map<String, dynamic> businessMap = {
    'id': 1,
    'businessName': 'GowriEvents',
    'contactName': 'Manoj Hp',
    'mobileNumber': '6361337631',
    'email': 'manojhp584@gmail.com',
    'address1': 'krs',
    'address2': 'mysore',
    'otherInfo': 'Sample',
    'gstIn': '27AAACT2727Q1ZW',
    'state': 'Karnataka',
    'upiId': '6361337631@ibl',
    'bankName': 'Canara',
    'accountNumber': '6361336314',
    'accountName': 'Manoj Hp',
    'businessCategory': 'Events',
  };

  setUp(() async {

    db = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE business (
            id INTEGER PRIMARY KEY,
            businessName TEXT,
            contactName TEXT,
            mobileNumber TEXT,
            email TEXT,
            address1 TEXT,
            address2 TEXT,
            otherInfo TEXT,
            gstIn TEXT,
            state TEXT,
            upiId TEXT,
            bankName TEXT,
            accountNumber TEXT,
            accountName TEXT,
            businessCategory TEXT
          )
        ''');
      },
    );

    dataSource = BusinessLocalDataSource(testDb: db);
  });

  tearDown(() async {
    await db.close();
  });

  test('should update existing business and return 1 row affected', () async {
    // 🅰️ Arrange

    final insertId = await dataSource.addBusiness(businessMap);
    expect(insertId, equals(1));


    final updatedMap = Map<String, dynamic>.from(businessMap)
      ..['businessName'] = 'GowriEvents Updated'
      ..['mobileNumber'] = '9876543210'
      ..['email'] = 'updated@gmail.com';

    // 🅰️ Act
    final affectedRows = await dataSource.updateBusiness(updatedMap, 1);

    // 🅰️ Assert
    // Should affect exactly 1 row
    expect(affectedRows, equals(1));

    // Fetch updated data and verify changes
    final updatedRows = await db.query(
      'business',
      where: 'id = ?',
      whereArgs: [1],
    );
    expect(updatedRows.length, equals(1));
    expect(updatedRows.first['businessName'], equals('GowriEvents Updated'));
    expect(updatedRows.first['mobileNumber'], equals('9876543210'));
    expect(updatedRows.first['email'], equals('updated@gmail.com'));
  });


  test('should return 0 when updating a non-existent record', () async {
    final result = await dataSource.updateBusiness(businessMap, 999);
    expect(result, equals(0));
  });

  test('should handle duplicate IDs gracefully', () async {
    await dataSource.addBusiness(businessMap);
    final result = await dataSource.addBusiness(businessMap); 
    expect(result, equals(1)); 
  });

  // FETCHING TEST

  test("should fetch all business data for local DB", () async {
    // Arrange
    await dataSource.addBusiness(businessMap);

    final secondBusiness = Map<String, dynamic>.from(businessMap)
      ..['id'] = 2
      ..['businessName'] = "Wood"
      ..['email'] = 'sampleemail@gmail.com';

    await dataSource.addBusiness(secondBusiness);

    // Act
    final result = await dataSource.getBusiness();

    //Assert
    expect(result, isA<List<Map<String, dynamic>>>());
    expect(result.length, equals(2));

    final first = result.first;
    final second = result.last;

    expect(first['businessName'], equals('GowriEvents'));
    expect(second['businessName'], equals('Wood'));
  });

  // ERROR TEST
  test("should throw exception when business table does not exist", () async {
    final brokenDb = await openDatabase(inMemoryDatabasePath, version: 1);
    final brokenDataSource = BusinessLocalDataSource(testDb: brokenDb);

    expect(
          () async => await brokenDataSource.getBusiness(),
      throwsA(isA<DatabaseException>()),
    );

    await brokenDb.close();
  });
  
}
