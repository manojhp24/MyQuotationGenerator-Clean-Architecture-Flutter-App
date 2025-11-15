import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BackupAndRestoreHelper {
  final String dbName;

  BackupAndRestoreHelper({required this.dbName});

  Future<String?> backupDataBase() async {
    try {
      final folder = await FilePicker.platform.getDirectoryPath();
      if (folder == null) return null;

      final dbPath = await _databasePath();
      final dbFile = File(dbPath);

      if (!await dbFile.exists()) return null;

      final now = DateTime.now();
      final formatted =
          "${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}";

      final backupPath = join(folder, "Quotation_Backup_$formatted.db");

      await dbFile.copy(backupPath);
      return backupPath;
    } catch (_) {
      return null;
    }
  }

  Future<bool> restoreDataBase() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
      );
      if (result == null) return false;

      final pickedFile = File(result.files.single.path!);
      final dbPath = await _databasePath();

      await _safeCloseDb();

      final currentDb = File(dbPath);
      if (await currentDb.exists()) {
        await currentDb.delete();
      }

      await pickedFile.copy(dbPath);
      await File(dbPath).setWritable();

      // Re-open DB to avoid stale instance usage
      try {
        await openDatabase(dbPath);
      } catch (_) {}

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteDataBaseFile() async {
    try {
      final dbPath = await _databasePath();
      final dbFile = File(dbPath);

      if (await dbFile.exists()) {
        await _safeCloseDb();
        await dbFile.delete();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> _safeCloseDb() async {
    try {
      final dbPath = await _databasePath();
      final db = await openDatabase(dbPath);
      await db.close();
    } catch (_) {}
  }

  Future<String> _databasePath() async {
    final dbDir = await getDatabasesPath();
    return join(dbDir, dbName);
  }
}

extension FilePermission on File {
  Future<void> setWritable() async {
    try {
      if (Platform.isAndroid || Platform.isLinux) {
        await Process.run('chmod', ['666', path]);
      }
    } catch (_) {}
  }
}
