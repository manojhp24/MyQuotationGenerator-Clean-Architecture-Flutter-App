import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_styles.dart';
import '../../../../../config/utils/app_sizes.dart';

class SelectedProductTile extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onDelete;

  const SelectedProductTile({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,##0");
    final price = double.tryParse(product.price.toString()) ?? 0;
    final total = 1 * price;

    return Container(
      padding: EdgeInsets.all(AppSizes.sm(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              Expanded(
                child: Text(
                  product.productName,
                  style: AppTextStyle.bodySmall(context).copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13, // smaller font
                  ),
                ),
              ),

              SizedBox(width: 8),
              InkWell(
                onTap: onDelete,
                child: Icon(
                  Icons.delete,
                  size: AppSizes.iconSmall(context),
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          SizedBox(height: 6),

          _detail(context, "Price", "${1} × $price = ₹$total"),
          _detail(
            context,
            "GST",
            product.gst.toString().isEmpty ? "-" : "${product.gst}%",
          ),
          _detail(context, "Total", "$total"),
        ],
      ),
    );
  }

  Widget _detail(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            label,
            style: AppTextStyle.bodySmall(context).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Text(
              value.isNotEmpty ? value : "-",
              style: AppTextStyle.bodySmall(
                context,
              ).copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
