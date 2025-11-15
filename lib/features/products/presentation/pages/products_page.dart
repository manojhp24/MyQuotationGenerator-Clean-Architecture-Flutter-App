import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/theme/app_text_styles.dart';
import 'package:my_quotation_generator/core/common/widgets/empty_state_widget.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';

import '../widgets/list/product_list_view.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key});

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(productNotifierProvider.notifier).fetchProduct();
    });
    super.initState();
  }

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

            if (state.product.isEmpty) {
              return EmptyStateWidget(
                  icon: Icons.inbox, message: "No Products Found");
            }

            return ProductListView(products: state.product);
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async{
          final result = await  context.push('/add-products');
          if(result == true ){
            ref.read(productNotifierProvider.notifier).fetchProduct();
          }
        },
        child: const Icon(Icons.inventory_2_rounded, color: Colors.white),
      ),
    );
  }
}
