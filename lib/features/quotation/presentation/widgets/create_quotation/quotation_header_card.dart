import 'package:flutter/material.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_styles.dart';
import '../../../../../config/utils/app_sizes.dart';

class QuotationHeaderCard extends StatelessWidget {
  final String dateText;
  final String quotationNo;
  final VoidCallback? onTap;

  const QuotationHeaderCard({
    super.key,
    required this.dateText,
    required this.quotationNo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTextStyle.label(context).copyWith(
      fontSize: 11,
      color: AppColors.textSecondary,
    );

    final valueStyle = AppTextStyle.bodyMedium(context).copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            /// Date box
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  border: Border.all(color: AppColors.border),
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.cardPadding(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("DATE", style: labelStyle),
                      SizedBox(height: AppSizes.xs(context)),
                      GestureDetector(
                        onTap: onTap,
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: AppSizes.iconTextGap(context)),
                            Text(dateText, style: valueStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(width: AppSizes.sm(context)),

            /// Quotation number box
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  border: Border.all(color: AppColors.border),
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.cardPadding(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("QUOTE NO", style: labelStyle),
                      SizedBox(height: AppSizes.xs(context)),
                      Text(quotationNo, style: valueStyle),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: AppSizes.sm(context)),

        /// Reference TextField
        TextField(
          style: AppTextStyle.bodyRegular(context).copyWith(
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Reference note (optional)",
            hintStyle: AppTextStyle.hint(context).copyWith(
              fontSize: 13,
            ),
            filled: true,
            fillColor: AppColors.white,
          ),
        ),
      ],
    );
  }
}
