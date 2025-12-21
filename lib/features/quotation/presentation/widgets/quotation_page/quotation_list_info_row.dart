import 'package:flutter/material.dart';

class QuotationInfoRow extends StatelessWidget {
  final String leftInfo;
  final String rightInfo;
  final TextStyle? leftInfoTextStyle, rightInfoTextStyle;
  final double verticalSpacing;
  final bool showDivider;

  const QuotationInfoRow({
    super.key,
    required this.leftInfo,
    required this.rightInfo,
    this.leftInfoTextStyle,
    this.rightInfoTextStyle,
    this.verticalSpacing = 12,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final defaultLeftStyle = textTheme.bodyMedium?.copyWith(
      color: scheme.onSurfaceVariant,
      fontWeight: FontWeight.w500,
    );

    final defaultRightStyle = textTheme.bodyMedium?.copyWith(
      color: scheme.onSurface,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  leftInfo,
                  style: leftInfoTextStyle ?? defaultLeftStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                rightInfo,
                style: rightInfoTextStyle ?? defaultRightStyle,
                textAlign: TextAlign.end,
              ),
            ],
          ),
          if (showDivider && verticalSpacing > 0) ...[
            const SizedBox(height: 8),
            Divider(
              height: 1,
              color: scheme.outlineVariant.withValues(alpha: 0.1),
            ),
          ],
        ],
      ),
    );
  }
}
