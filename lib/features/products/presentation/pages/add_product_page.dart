import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';

import '../widgets/form/product_form.dart';
import '../widgets/form/product_form_button.dart';

class AddProductPage extends ConsumerWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(productNotifierProvider.notifier);
    final state = ref.watch(productNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.productAppBarTitle,
        ),
      ),
      body: ProductForm(isUpdate: false,),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppSizes.lg(context)),
        child: ProductFormButton(
          onPressed: () async {
            final isSaved = await notifier.saveProduct(context);
            if (isSaved) {
              if (context.mounted) context.pop(true);
            }
          },
          label: AppStrings.productAppBarTitle,
          isLoading: state.isLoading,),
      ),
    );
  }
}


