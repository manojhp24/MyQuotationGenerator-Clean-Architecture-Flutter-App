import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';

import '../../../../customer/presentation/provider/customer_state.dart';
import '../../provider/quotation_provider.dart';
import '../../provider/quotation_state.dart';
import '../create_quotation_page/customer_details_card.dart';
import '../shared/selectable_tile.dart';

class CustomerSelectSection extends StatelessWidget {
  const CustomerSelectSection({
    super.key,
    required this.customerState,
    required this.ref,
    required this.quotationState,
    required this.onAddPressed,
  });

  final CustomerState customerState;
  final WidgetRef ref;
  final QuotationState quotationState;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasCustomer = quotationState.selectedCustomer != null;

    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: scheme.outlineVariant.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.person_outline, size: 20, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  AppStrings.customer,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                const Spacer(),
                if (!hasCustomer)
                  TextButton(
                    onPressed: onAddPressed,
                    child: const Text(AppStrings.addCustomer),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Select customer card
            Card(
              elevation: 0,
              color: scheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () async {
                  final selectedCustomer = await _showCustomerSelection(context);
                  if (selectedCustomer != null) {
                    ref
                        .read(quotationNotifierProvider.notifier)
                        .selectCustomer(selectedCustomer);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          hasCustomer ? Icons.person : Icons.person_add_alt_1,
                          size: 20,
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasCustomer
                                  ? quotationState.selectedCustomer!.customerName ?? 'Customer'
                                  : 'Select Customer',
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              hasCustomer
                                  ? 'Tap to change customer'
                                  : 'Tap to select customer',
                              style: textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: scheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Selected customer details
            if (hasCustomer) ...[
              const SizedBox(height: 16),
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

  Future<CustomerEntity?> _showCustomerSelection(BuildContext context) async {
    return await showModalBottomSheet<CustomerEntity>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Customer',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Customer list
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: customerState.customer.length,
                itemBuilder: (context, index) {
                  final customer = customerState.customer[index];
                  return SelectableTile(
                    title: customer.customerName ?? 'Unknown',
                    subtitle: customer.mobile ?? customer.email ?? '',
                    icon: Icons.person_outline,
                    isSelected: quotationState.selectedCustomer?.id == customer.id,
                    onTap: () => Navigator.pop(context, customer),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}