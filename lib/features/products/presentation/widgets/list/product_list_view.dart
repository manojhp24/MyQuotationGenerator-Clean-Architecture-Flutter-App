import 'package:flutter/material.dart';

import '../card/product_card.dart';



class ProductListView extends StatelessWidget {
  const ProductListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        return ProductCard();
      },
    );
  }
}


