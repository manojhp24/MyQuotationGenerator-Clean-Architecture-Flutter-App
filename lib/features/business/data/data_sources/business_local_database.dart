import 'package:flutter/foundation.dart';
import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class BusinessLocalDataSource {
  final Database? testDb;

  BusinessLocalDataSource({this.testDb});

  /// Add a new business record
  Future<int> addBusiness(Map<String, dynamic> businessMap) async {
    try {
      final db = testDb ?? await AppDatabase.database;

      final result = await db.insert(
        'business',
        businessMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return result;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('❌ Error adding business: $e');
      }
      if (kDebugMode) {
        print(stackTrace);
      }
      rethrow;
    }
  }

  /// Update an existing business record
  Future<int> updateBusiness(Map<String, dynamic> businessMap, int id) async {
    try {
      final db = testDb ?? await AppDatabase.database;

      final result = await db.update(
        'business',
        businessMap,
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// Get all businesses from the local database
  Future<List<Map<String, dynamic>>> getBusiness() async {
    try {
      final db = testDb ?? await AppDatabase.database;

      final result = await db.query(
        'business',
        orderBy: 'id',
      );

      if (kDebugMode) print(result);

      return result;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(stackTrace);
      }
      rethrow;
    }
  }
}
