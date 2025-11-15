import 'package:flutter/material.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';

import '../card/product_card.dart';



class ProductListView extends StatelessWidget {

  final List<ProductEntity> products;

  const ProductListView({
    super.key, required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product,);
      },
    );
  }
}


