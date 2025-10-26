import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Business Details",
            style: AppTextStyle.h2(context)
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text("Business Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>context.push("/add-business"),
        child: Icon(Icons.add, color: AppColors.white),
      ),
    ));
  }
}
