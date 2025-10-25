import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_theme.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/pages/dashboard_nav.dart';




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      home: DashboardNav(),
    );
  }
}
