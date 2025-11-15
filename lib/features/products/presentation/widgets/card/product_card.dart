import 'package:flutter/material.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_styles.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Product Icon
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.inventory_2_rounded,
                color: AppColors.primary,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: AppTextStyle.h3(context)
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.currency_rupee,
                        size: 15,
                        color: AppColors.textSecondary,
                      ),
                      Text(
                        product.price,
                        style: AppTextStyle.bodyMedium(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.receipt_long,
                        size: 15,
                        color: AppColors.textSecondary,
                      ),
                      Text(
                        "10%",
                        style: AppTextStyle.bodyMedium(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Edit Button
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
