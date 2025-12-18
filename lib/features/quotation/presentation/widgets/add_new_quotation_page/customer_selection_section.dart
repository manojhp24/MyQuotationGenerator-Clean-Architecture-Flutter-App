import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';

import '../../../../customer/domain/entities/customer.dart';
import '../../../../customer/presentation/provider/customer_state.dart';
import '../../provider/quotation_provider.dart';
import '../../provider/quotation_state.dart';
import '../create_quotation_page/action_tiles.dart';
import '../create_quotation_page/customer_details_card.dart';
import '../shared/selectable_tile.dart';
import '../shared/selection_bottom_sheet.dart';

class CustomerSelectSection extends StatelessWidget {
  const CustomerSelectSection({
    super.key,
    required this.customerState,
    required this.ref,
    required this.quotationState,
    required this.onPressed,
  });

  final CustomerState customerState;
  final WidgetRef ref;
  final QuotationState quotationState;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final hasCustomer = quotationState.selectedCustomer != null;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(textTheme),
            const SizedBox(height: 16),
            _selectCustomerTile(context, hasCustomer),
            if (hasCustomer) ...[
              const SizedBox(height: 12),
              CustomerDetailsCard(
                customer: quotationState.selectedCustomer!,
                onRemove: () {
                  ref
                      .read(quotationNotifierProvider.notifier)
                      .removeCustomer();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Header section
  Widget _header(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.customer,
          style: textTheme.titleMedium,
        ),
        OutlinedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.add),
          label: const Text(AppStrings.addNewCustomer),
        ),
      ],
    );
  }

  Widget _selectCustomerTile(BuildContext context, bool hasCustomer) {
    return InkWell(
      onTap: () => _openCustomerSelector(context),
      child: ActionTile(
        title: hasCustomer
            ? AppStrings.changeCustomer
            : AppStrings.addCustomerQuotation,
        subtitle: hasCustomer
            ? AppStrings.tapToUpdateCustomer
            : AppStrings.tapToSelectCustomer,
        icon: Icons.person_add_alt_1,
      ),
    );
  }

  Future<void> _openCustomerSelector(BuildContext context) async {
    final selectedCustomer = await showSelectBottomSheet<CustomerEntity>(
      context: context,
      title: AppStrings.selectCustomer,
      items: customerState.customer,
      tileBuilder: (customer) => SelectableTile(
        title: customer.customerName ?? '-',
        subtitle: customer.email ?? '-',
        icon: Icons.person,
      ),
    );

    if (selectedCustomer != null) {
      ref
          .read(quotationNotifierProvider.notifier)
          .selectCustomer(selectedCustomer);
    }
  }
}
