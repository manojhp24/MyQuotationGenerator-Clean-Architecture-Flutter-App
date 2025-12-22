import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';

import '../../../../products/presentation/providers/product_state.dart';
import '../../provider/quotation_provider.dart';
import '../../provider/quotation_state.dart';
import '../create_quotation_page/product_details_card.dart';
import '../shared/selectable_tile.dart';
import '../shared/selection_bottom_sheet.dart';

class ProductSelectSection extends StatelessWidget {
  const ProductSelectSection({
    super.key,
    required this.productState,
    required this.ref,
    required this.quotationState,
    required this.onPressed,
  });

  final ProductState productState;
  final WidgetRef ref;
  final QuotationState quotationState;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasItems = quotationState.items.isNotEmpty;

    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: scheme.outlineVariant.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 20,
                  color: scheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  AppStrings.products,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: onPressed,
                  child: const Text(AppStrings.addNewProduct),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Select product card (same as customer)
            Card(
              elevation: 0,
              color: scheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () async {
                  final selectedProduct = await showSelectBottomSheet(
                    context: context,
                    title: AppStrings.selectProduct,
                    items: productState.product,
                    tileBuilder: (product) => SelectableTile(
                      title: product.productName,
                      subtitle: '₹${product.price}',
                      icon: Icons.shopping_cart_outlined,
                    ),
                  );

                  if (selectedProduct != null) {
                    ref
                        .read(quotationNotifierProvider.notifier)
                        .addProduct(selectedProduct, 1);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          size: 20,
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasItems
                                  ? AppStrings.addMoreProducts
                                  : AppStrings.selectProduct,
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              hasItems
                                  ? AppStrings.tapToAddMore
                                  : AppStrings.tapToSelectProducts,
                              style: textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: scheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Selected products (unchanged)
            if (hasItems) ...[
              const SizedBox(height: 16),
              ...quotationState.items.map(
                    (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    elevation: 0,
                    color: scheme.surfaceContainerHighest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: SelectedProductTile(
                      item: item,
                      onDelete: () {
                        ref
                            .read(quotationNotifierProvider.notifier)
                            .removeItem(item.productId);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
