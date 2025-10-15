import 'package:flutter/material.dart';


import 'app.dart';
import 'core/di/injection_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

