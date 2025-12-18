import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_item_entity.dart';

class SelectedProductTile extends StatelessWidget {
  final QuotationItemEntity item;
  final VoidCallback onDelete;

  const SelectedProductTile({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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

            _detailRow(
              context,
              label: "Price",
              value:
              "${item.quantity} × ${formatter.format(item.unitPrice)}",
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
