import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_styles.dart';
import '../../../../../config/utils/app_sizes.dart';

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
    return Container(
      color: AppColors.black,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.md(context),
        vertical: AppSizes.sm(context),
      ),
      child: SafeArea(
        minimum: EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Amount price",
                    style: AppTextStyle.bodySmall(context)
                        .copyWith(color: AppColors.white.withOpacity(0.6)),
                  ),
                  Text(
                    amount,
                    style: AppTextStyle.bodyBold(context)
                        .copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),

            SizedBox(width: AppSizes.sm(context)),

            SizedBox(
              width: AppSizes.buttonWidth(context),
              height: 45,
              child: ElevatedButton(
                onPressed: onGenerate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Generate",
                  style: AppTextStyle.bodyRegular(context).copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
