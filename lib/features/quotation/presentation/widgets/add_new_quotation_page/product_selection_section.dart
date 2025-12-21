import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';

import '../../../../products/presentation/providers/product_state.dart';
import '../../provider/quotation_provider.dart';
import '../../provider/quotation_state.dart';
import '../create_quotation_page/action_tiles.dart';
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
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(
                  AppStrings.products,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onPressed,
                  icon: const Icon(Icons.add),
                  label: const Text(AppStrings.addNewProduct),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Add / Select product (primary action)
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () async {
                final selectedProduct =
                await showSelectBottomSheet(
                  context: context,
                  title: AppStrings.selectProduct,
                  items: productState.product,
                  tileBuilder: (product) => SelectableTile(
                    title: product.productName,
                    subtitle: '₹${product.price}',
                    icon: Icons.shopping_cart,
                  ),
                );

                if (selectedProduct != null) {
                  ref
                      .read(quotationNotifierProvider.notifier)
                      .addProduct(selectedProduct, 1);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ActionTile(
                  title: hasItems
                      ? AppStrings.addMoreProducts
                      : AppStrings.selectProduct,
                  subtitle: hasItems
                      ? AppStrings.tapToAddMore
                      : AppStrings.tapToSelectProducts,
                  icon: Icons.shopping_cart,
                ),
              ),
            ),

            // Selected products
            if (hasItems) ...[
              const SizedBox(height: 16),

              Text(
                "Selected products",
                style: textTheme.labelLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

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

