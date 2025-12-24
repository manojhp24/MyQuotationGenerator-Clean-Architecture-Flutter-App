import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/helpers/date_formatter.dart';

import '../../provider/quotation_list_ui_model.dart';

class QuotationListCard extends StatelessWidget {
  const QuotationListCard({super.key, required this.quotation});

  final QuotationListItem quotation;

  String get initials =>
      quotation.customerName
          .split(' ')
          .map((e) => e[0])
          .take(2)
          .join()
          .toUpperCase();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(AppSizes.screenPadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _AvatarCircle(text: initials),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quotation.customerName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    _MetaText(text: quotation.email ?? ''),
                  ],
                ),
              ),

              _InfoChip(
                text: 'QUOT-${quotation.quotationId}',
                textColor: scheme.primary,
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// DATE + AMOUNT (clean single meta row)
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: scheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              _MetaText(
                text: DateFormatter.toReadableDate(
                  quotation.quoteDate.toString(),
                ),
              ),

              const Spacer(),

              _AmountBadge(amount: quotation.grandTotal),
            ],
          ),


          const SizedBox(height: 10),

          Divider(
            height: 1,
            thickness: 0.8,
            color: scheme.outlineVariant.withValues(alpha: 0.15),
          ),

          const SizedBox(height: 8),

          /// ACTIONS
          Row(
            children: [
              const Spacer(),
              _ActionButton(
                icon: Icons.remove_red_eye,
                text: 'View',
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _ActionButton(
                icon: Icons.edit_outlined,
                text: 'Edit',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}


/* -------------------------------------------------------------------------- */
/*                               SMALL WIDGETS                                */
/* -------------------------------------------------------------------------- */

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: textTheme.titleSmall?.copyWith(
          color: scheme.onPrimaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.text,
    this.icon,
    this.textColor,
  });

  final String text;
  final IconData? icon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: scheme.onSurfaceVariant),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: textTheme.labelSmall?.copyWith(
              color: textColor ?? scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountBadge extends StatelessWidget {
  const _AmountBadge({required this.amount});

  final num amount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$amount',
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          color: scheme.primary,
        ),
      ),
    );
  }
}

class _MetaText extends StatelessWidget {
  const _MetaText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textTheme.bodySmall?.copyWith(
        color: scheme.onSurfaceVariant,
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: scheme.onSurfaceVariant),
            const SizedBox(width: 6),
            Text(
              text,
              style: textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
