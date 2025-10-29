import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';

import '../widgets/product_form.dart';

class AddProductPage extends ConsumerWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(productNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.productAppBarTitle,
        ),
      ),
      body: ProductForm(notifier: notifier),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.lg(context)),
        child: ElevatedButton(
          onPressed: () => notifier.saveProduct(context),
          child: Text("Add Product"),
        ),
      ),
    );
  }
}
