import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void initializeDatabaseForDesktop() {
  // Check if running on a desktop platform (Windows, Linux, or macOS)
  final isDesktopPlatform =
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS;

  // Skip for web, only initialize FFI for desktop
  if (!kIsWeb && isDesktopPlatform) {
    sqfliteFfiInit(); // Initialize SQLite FFI bindings
    databaseFactory = databaseFactoryFfi; // Set FFI as the global DB factory
  }
}
