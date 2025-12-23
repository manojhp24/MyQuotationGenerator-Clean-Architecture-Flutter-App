import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
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
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(productNotifierProvider);
    final product = ref.watch(productNotifierProvider.notifier).filteredProducts;

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.productListAppBarTitle,
        showBack: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.screenPadding(context)),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                // Search bar
                SearchBar(
                  hintText: 'Search products',
                  leading: const Icon(Icons.search),
                  elevation: WidgetStateProperty.all(0),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppSizes.radius(context)),
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(productNotifierProvider.notifier).updateSearch(
                        value);
                  },
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: () {
                    if (state.isLoading) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: scheme.primary,
                              strokeWidth: 2,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Loading products...',
                              style: textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state.product.isEmpty) {
                      return EmptyStateWidget(
                        icon: Icons.inbox_outlined,
                        message: AppStrings.noProductsFound,
                        actionText: 'Add First Product',
                        onAction: () => context.push('/add-products'),
                      );
                    }

                    return RefreshIndicator(
                      color: scheme.primary,
                      backgroundColor: scheme.surface,
                      onRefresh: () async {
                        ref
                            .read(productNotifierProvider.notifier)
                            .fetchProduct();
                      },
                      child: ProductListView(products: product),
                    );
                  }(),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: state.product.isEmpty
          ? null
          : FloatingActionButton.extended(
        onPressed: () async {
          final result = await context.push('/add-products');
          if (result == true) {
            ref.read(productNotifierProvider.notifier).fetchProduct();
          }
        },
        icon: const Icon(Icons.inventory_2_rounded),
        label: const Text('Add Product'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        highlightElevation: 8,
      ),
    );
  }
}
