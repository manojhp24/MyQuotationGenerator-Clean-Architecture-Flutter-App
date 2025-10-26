import 'package:flutter/material.dart';

import '../../../../config/theme/app_text_styles.dart';

class AddProductsPage extends StatelessWidget {
  const AddProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products List", style: AppTextStyle.h2(context)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
