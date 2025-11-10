// main.dart — app entry point
// Handles app initialization, DB setup, and launches the root widget.



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/di/injection_container.dart';
import 'core/platform/platform_initializer.dart';

void main() async {
  // Flutter needs to set up some internal bindings before we do anything async.
  // Without this, things like database or plugin initialization can fail.
  WidgetsFlutterBinding.ensureInitialized();

  initializeDatabaseForDesktop();

  // This sets up all the app’s dependencies (like services, repositories, etc.).
  // Think of it as wiring up everything before the app actually starts.
  await setupDependencies();

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}
