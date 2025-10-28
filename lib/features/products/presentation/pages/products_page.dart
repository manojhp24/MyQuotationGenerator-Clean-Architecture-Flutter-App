import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';

import '../../../../config/theme/app_text_styles.dart';

class AddProductsPage extends StatelessWidget {
  const AddProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.productListAppBarTitle, style: AppTextStyle.h2(context)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>context.push('/add-products'),
        child: Icon(Icons.inventory_2_rounded),
      ),
    );
  }
}
