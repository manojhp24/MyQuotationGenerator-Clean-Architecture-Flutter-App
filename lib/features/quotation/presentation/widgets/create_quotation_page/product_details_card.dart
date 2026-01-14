import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_item_entity.dart';

import '../../provider/quotation_provider.dart';

class SelectedProductTile extends ConsumerWidget {
  final QuotationItemEntity item;
  final VoidCallback onDelete;
  final VoidCallback onIncreaseQty;
  final VoidCallback onDecreaseQty;


  const SelectedProductTile({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onIncreaseQty,
    required this.onDecreaseQty,
  });


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formatter = NumberFormat("#,##0");

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.productName,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price",
                  style: textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    // Decrease
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: (){
                        ref
                            .read(quotationNotifierProvider.notifier)
                            .decreaseQuantity(item.productId);
                      },
                      visualDensity: VisualDensity.compact,
                    ),

                    Text(
                      "${item.quantity}",
                      style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),

                    // Increase
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: (){
                        ref
                            .read(quotationNotifierProvider.notifier)
                            .increaseQuantity(item.productId);
                      },
                      visualDensity: VisualDensity.compact,
                    ),

                    const SizedBox(width: 6),
                    Text("× ${formatter.format(item.unitPrice)}"),
                  ],
                ),
              ],
            ),

            _detailRow(
              context,
              label: "GST",
              value: "${item.gstPercent}%",
            ),
            _detailRow(
              context,
              label: "Total",
              value: "₹${formatter.format(item.totalPrice)}",
              isEmphasis: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(
      BuildContext context, {
        required String label,
        required String value,
        bool isEmphasis = false,
      }) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: isEmphasis
                  ? textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              )
                  : textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
