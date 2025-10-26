import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';

import '../../../../config/theme/app_text_styles.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer List", style: AppTextStyle.h2(context)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(child: Text("Customer Page")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-customer'),
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
