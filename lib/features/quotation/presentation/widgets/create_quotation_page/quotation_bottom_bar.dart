import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';

class QuotationBottomBar extends StatelessWidget {
  final String amount;
  final VoidCallback onGenerate;

  const QuotationBottomBar({
    super.key,
    required this.amount,
    required this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(
            top: BorderSide(color: scheme.outlineVariant),
          ),
        ),
        child: Row(
          children: [
            // Amount section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.amountPrice,
                    style: textTheme.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    amount,
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Generate button
            FilledButton(
              onPressed: onGenerate,
              style: FilledButton.styleFrom(
                minimumSize: const Size(120, 48),
                shape: const StadiumBorder(),
              ),
              child: const Text(AppStrings.generate),
            ),
          ],
        ),
      ),
    );
  }
}
