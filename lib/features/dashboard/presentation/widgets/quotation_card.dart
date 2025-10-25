import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../config/utils/app_sizes.dart';

class QuotationCard extends StatelessWidget {
  final String quotationNumber;
  final String customerName;
  final String amount;
  final String date;
  final bool isRecent;
  final VoidCallback? onTap; // optional tap handler

  const QuotationCard({
    super.key,
    required this.quotationNumber,
    required this.customerName,
    required this.amount,
    required this.date,
    this.isRecent = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppSizes.cardRadius);

    return Card(
      color: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(
          color: isRecent ? AppColors.black : AppColors.border,
          width: isRecent ? 1.5 : 1,
        ),
      ),
      shadowColor: AppColors.black.withValues(alpha: 0.05),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppSizes.md(context)),
          child: Row(
            children: [
              // Leading icon box
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isRecent ? AppColors.black : AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.description_outlined,
                  color: isRecent ? AppColors.white : AppColors.black,
                ),
              ),

              SizedBox(width: AppSizes.md(context)),

              // Quotation info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          quotationNumber,
                          style: AppTextStyle.bodyMedium(context).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isRecent) ...[
                          SizedBox(width: AppSizes.xs(context)),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.xs(context),
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "NEW",
                              style: AppTextStyle.bodySmall(context).copyWith(
                                color: AppColors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: AppSizes.xs(context) / 2),
                    Row(
                      children: [
                        Text(
                          customerName,
                          style: AppTextStyle.bodySmall(context).copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(width: AppSizes.sm(context)),
                        Text(
                          "• $date",
                          style: AppTextStyle.bodySmall(context).copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Amount (trailing)
              Text(
                amount,
                style: AppTextStyle.bodyMedium(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
