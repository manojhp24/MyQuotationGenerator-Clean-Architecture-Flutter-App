import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/core/common/widgets/custom_app_bar.dart';

import '../../../../core/common/widgets/empty_state_widget.dart';
import '../providers/product_provider.dart';
import '../widgets/list/product_list_view.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key});

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(productNotifierProvider.notifier).fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productNotifierProvider);

    return Scaffold(
      appBar:CustomAppBar(title: AppStrings.productListAppBarTitle,showBack: false,),
      body: Builder(
        builder: (_) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.product.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.inbox_outlined,
              message: AppStrings.noProductsFound,
            );
          }

          return ProductListView(products: state.product);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push('/add-products');
          if (result == true) {
            ref.read(productNotifierProvider.notifier).fetchProduct();
          }
        },
        child: const Icon(Icons.inventory_2_rounded),
      ),
    );
  }
}
