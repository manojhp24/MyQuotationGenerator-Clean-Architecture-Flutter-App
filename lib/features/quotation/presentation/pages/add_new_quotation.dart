import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/theme/app_text_styles.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';
import 'package:my_quotation_generator/features/products/presentation/providers/product_provider.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_provider.dart';
import 'package:my_quotation_generator/features/quotation/presentation/widgets/shared/date_picker_helper.dart';

import '../../../customer/domain/entities/customer.dart';
import '../widgets/create_quotation/action_tiles.dart';
import '../widgets/create_quotation/customer_details_card.dart';
import '../widgets/create_quotation/product_details_card.dart';
import '../widgets/create_quotation/quotation_bottom_bar.dart';
import '../widgets/create_quotation/quotation_header_card.dart';
import '../widgets/shared/selectable_tile.dart';
import '../widgets/shared/selection_bottom_sheet.dart';

class AddNewQuotation extends ConsumerStatefulWidget {
  const AddNewQuotation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewQuotationState();
}

class _AddNewQuotationState extends ConsumerState<AddNewQuotation> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(customerNotifierProvider.notifier).fetchCustomer();
      ref.read(productNotifierProvider.notifier).fetchProduct();
      ref.read(quotationNotifierProvider.notifier).dateReset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerState = ref.watch(customerNotifierProvider);
    final productState = ref.watch(productNotifierProvider);
    final quotationState = ref.watch(quotationNotifierProvider);

    final selectedDate = quotationState.date ?? DateTime.now();

    final formatedDate =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Create Quotation"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: AppSizes.pagePadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  QuotationHeaderCard(
                    dateText: formatedDate,
                    quotationNo: "QUOT-001",
                    onTap: () => DatePickerHelper.selectDate(context, ref),
                  ),

                  SizedBox(height: AppSizes.sectionVertical(context)),

                  /// CUSTOMER SECTION UI CARD
                  Container(
                    padding: EdgeInsets.all(AppSizes.md(context)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Customer",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            OutlinedButton.icon(
                              onPressed: () {},
                              label: Text(
                                "Add New Customer",
                                style: AppTextStyle.label(context)
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: AppColors.borderFocused,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.sm(context),
                                  vertical: AppSizes.xs(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.sectionVertical(context)),

                        InkWell(
                          onTap: () async {
                            final selectedCustomer =
                                await showSelectBottomSheet<CustomerEntity>(
                                  context: context,
                                  title: "Select Customer",
                                  items: customerState.customer,
                                  tileBuilder: (customer) => SelectableTile(
                                    title: customer.customerName!,
                                    icon: Icons.person,
                                    subtitle: customer.email!,
                                  ),
                                );

                            if (selectedCustomer != null) {
                              ref
                                  .read(quotationNotifierProvider.notifier)
                                  .selectedCustomer(selectedCustomer);
                            }
                          },
                          child: ActionTile(
                            title: quotationState.selectedCustomer.isNotEmpty
                                ? "Change Customer"
                                : "Add Customer",
                            subtitle: quotationState.selectedCustomer.isNotEmpty
                                ? "Tap to update"
                                : "Tap to select from list",
                            icon: Icons.person_add_alt_1,
                          ),
                        ),

                        if (quotationState.selectedCustomer.isNotEmpty) ...[
                          SizedBox(height: 10),

                          Builder(
                            builder: (_) {
                              final customer =
                                  quotationState.selectedCustomer.first;

                              return CustomerDetailsCard(
                                customer: customer,
                                onRemove: () {
                                  ref
                                      .read(quotationNotifierProvider.notifier)
                                      .removeCustomer(customer.id!);
                                },
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: AppSizes.sectionVertical(context)),

                  /// PRODUCT SECTION
                  Container(
                    padding: EdgeInsets.all(AppSizes.md(context)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Products",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            OutlinedButton.icon(
                              onPressed: () {},
                              label: Text(
                                "Add New Product",
                                style: AppTextStyle.label(context)
                                    .copyWith(
                                      color: AppColors.primary,
                                      fontSize: AppSizes.textSmall(context),
                                    ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: AppColors.borderFocused,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.sm(context),
                                  vertical: AppSizes.xs(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.sectionVertical(context)),

                        InkWell(
                          onTap: () async {
                            final selectedProduct = await showSelectBottomSheet(
                              context: context,
                              title: "Select Products",
                              items: productState.product,
                              tileBuilder: (product) => SelectableTile(
                                title: product.productName,
                                subtitle: "₹${product.price}",
                                icon: Icons.shopping_cart,
                              ),
                            );

                            if (selectedProduct != null) {
                              ref
                                  .read(quotationNotifierProvider.notifier)
                                  .selectedProducts(selectedProduct);
                            }
                          },
                          child: ActionTile(
                            title: quotationState.selectedProduct.isNotEmpty
                                ? "Add more products"
                                : "Select products",
                            subtitle: quotationState.selectedProduct.isNotEmpty
                                ? "Tap to add more"
                                : "Tap to choose from list",
                            icon: Icons.shopping_cart,
                          ),
                        ),

                        if (quotationState.selectedProduct.isNotEmpty) ...[
                          SizedBox(height: 12),

                          ...quotationState.selectedProduct.map((product) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: SelectedProductTile(
                                product: product,
                                onDelete: () {
                                  ref
                                      .read(quotationNotifierProvider.notifier)
                                      .removeProduct(product.id!);
                                },
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: AppSizes.lg(context)),
                ],
              ),
            ),
          ),

          /// Bottom Bar
          QuotationBottomBar(amount: "0", onGenerate: () {}),
        ],
      ),
    );
  }
}
