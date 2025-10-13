import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_theme.dart';

import 'features/business/presentation/pages/add_business_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      home: AddBusinessPage(),
    );
  }
}
