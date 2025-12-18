import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';

class CustomerDetailsCard extends StatelessWidget {
  final CustomerEntity customer;
  final VoidCallback? onRemove;

  const CustomerDetailsCard({
    super.key,
    required this.customer,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 24,
          color: scheme.outlineVariant,
        ),

        /// Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.person_outline,
                color: scheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                customer.customerName ?? "Unknown",
                style: textTheme.titleMedium,
              ),
            ),
            if (onRemove != null)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onRemove,
              ),
          ],
        ),

        const SizedBox(height: 16),

        /// Details
        _detailRow(
          context,
          icon: Icons.email_outlined,
          label: AppStrings.email,
          value: customer.email ?? "-",
        ),

        if (_has(customer.mobile)) ...[
          const SizedBox(height: 12),
          _detailRow(
            context,
            icon: Icons.phone_outlined,
            label: AppStrings.mobileNumber,
            value: customer.mobile!,
          ),
        ],

        if (_has(customer.address1)) ...[
          const SizedBox(height: 12),
          _detailRow(
            context,
            icon: Icons.location_on_outlined,
            label: AppStrings.address1,
            value: customer.address1!,
          ),
        ],

        if (_has(customer.gstIn)) ...[
          const SizedBox(height: 12),
          _detailRow(
            context,
            icon: Icons.receipt_long_outlined,
            label: AppStrings.gstIn,
            value: customer.gstIn!,
          ),
        ],

        if (_has(customer.state)) ...[
          const SizedBox(height: 12),
          _detailRow(
            context,
            icon: Icons.map_outlined,
            label: AppStrings.state,
            value: customer.state!,
          ),
        ],
      ],
    );
  }

  bool _has(String? data) => data != null && data.trim().isNotEmpty;

  Widget _detailRow(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
      }) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: scheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
