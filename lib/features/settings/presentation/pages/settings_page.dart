import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.settingsAppBarTitle)),
      body: SingleChildScrollView(),
    );
  }
}
