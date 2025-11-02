import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/theme/app_text_styles.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';

import '../widgets/list/product_list_view.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          title: Text(
            AppStrings.productListAppBarTitle,
            style: AppTextStyle.appBarText(context),
          ),
          centerTitle: true),
      body: Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(productNotifierProvider);

            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primary,),
              );
            }
            return ProductListView();
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => context.push('/add-products'),
        child: const Icon(Icons.inventory_2_rounded, color: Colors.white),
      ),
    );
  }
}
