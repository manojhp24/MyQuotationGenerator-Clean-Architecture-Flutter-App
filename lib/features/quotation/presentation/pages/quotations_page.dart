import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/theme/app_text_styles.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';

import '../widgets/quotation_page/quotation_list_info_row.dart';

class QuotationsPage extends StatelessWidget {
  const QuotationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotations List"),
      ),
      body: InkWell(
        onTap: () {},
        child: ListView.separated(
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSizes.cardPadding(context)),
                child: Column(
                  children: [
                    QuotationInfoRow(
                      leftInfo: "Manoj Hp",
                      rightInfo: "Quote-1",
                      leftInfoTextStyle: AppTextStyle.bodyMedium(context),
                      rightInfoTextStyle: AppTextStyle.bodySmall(context),
                      spacing: AppSizes.titleContentGap(context),
                    ),
                    QuotationInfoRow(leftInfo: "Sample",
                      rightInfo: "24/6/2025",
                      leftInfoTextStyle: AppTextStyle.bodySmall(context),
                      rightInfoTextStyle: AppTextStyle.bodySmall(context),
                      spacing: AppSizes.titleContentGap(context),
                    ),
                    QuotationInfoRow(leftInfo: "+916361337631",
                      rightInfo: "Rs.500",
                      leftInfoTextStyle: AppTextStyle.bodySmall(context),
                      rightInfoTextStyle: AppTextStyle.bodySmall(context),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemCount: 2,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/create-quotation'),
        child: Icon(Icons.note_add_rounded),
      ),
    );
  }
}
