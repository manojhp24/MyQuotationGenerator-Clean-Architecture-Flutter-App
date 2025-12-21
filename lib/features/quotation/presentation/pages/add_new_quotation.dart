import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/common/widgets/custom_app_bar.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_provider.dart';
import 'package:my_quotation_generator/features/quotation/presentation/widgets/shared/date_picker_helper.dart';

import '../../../../core/common/App_snack_bar/custom_snack_bar.dart';
import '../../../../core/resource/data_state.dart';
import '../widgets/add_new_quotation_page/customer_selection_section.dart';
import '../widgets/add_new_quotation_page/product_selection_section.dart';
import '../widgets/create_quotation_page/quotation_bottom_bar.dart';
import '../widgets/create_quotation_page/quotation_header_card.dart';

class AddNewQuotation extends ConsumerStatefulWidget {
  const AddNewQuotation({super.key});

  @override
  ConsumerState<AddNewQuotation> createState() => _AddNewQuotationState();
}

class _AddNewQuotationState extends ConsumerState<AddNewQuotation> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(customerNotifierProvider.notifier).fetchCustomer();
      ref.read(productNotifierProvider.notifier).fetchProduct();
      ref.read(quotationNotifierProvider.notifier).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerState = ref.watch(customerNotifierProvider);
    final productState = ref.watch(productNotifierProvider);
    final quotationState = ref.watch(quotationNotifierProvider);

    final selectedDate = quotationState.date;
    final formattedDate =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.createQuotationAppBarTitle),

      // ✅ Scrollable content only
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.screenPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuotationHeaderCard(
              quotationNo: "QUOT-001",
              dateText: formattedDate,
              onDateTap: () => DatePickerHelper.selectDate(context, ref),
            ),

            const SizedBox(height: 24),

            CustomerSelectSection(
              customerState: customerState,
              quotationState: quotationState,
              ref: ref,
              onAddPressed: () async {
                final result = await context.push('/add-customer');
                if (result == true) {
                  ref
                      .read(customerNotifierProvider.notifier)
                      .fetchCustomer();
                }
              },
            ),

            const SizedBox(height: 24),

            ProductSelectSection(
              productState: productState,
              quotationState: quotationState,
              ref: ref,
              onPressed: () async {
                final result = await context.push('/add-products');
                if (result == true) {
                  ref
                      .read(productNotifierProvider.notifier)
                      .fetchProduct();
                }
              },
            ),

            const SizedBox(height: 96),
          ],
        ),
      ),


      bottomNavigationBar: QuotationBottomBar(
        amount: quotationState.grandTotal.toStringAsFixed(2),
        onGenerate: () async {
          final result = await ref
              .read(quotationNotifierProvider.notifier)
              .generateQuotationAndPdf();

          if (!context.mounted) return;

          final isSuccess = result is DataSuccess<String>;

          showCustomSnackBar(
            context,
            isSuccess: isSuccess,
            message: isSuccess
                ? "Quotation generated successfully"
                : result.error
                .toString()
                .replaceFirst('Exception: ', ''),
            durationSeconds: 2,
          );

          if (isSuccess) {
            context.push(
              '/quotation-pdf-view',
              extra: result.data,
            );
          }
        },
      ),
    );
  }
}
