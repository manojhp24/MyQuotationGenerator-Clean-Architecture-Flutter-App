import 'package:flutter/material.dart';

import '../../../../../config/utils/app_sizes.dart';
import '../quotation_card.dart';
import '../section_title.dart';

class RecentQuotationSection extends StatelessWidget {
  const RecentQuotationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(AppSizes.md(context)),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardSectionTitle(title: "Recent Quotations"),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSizes.sm(context)),
              itemBuilder: (context, index) => QuotationCard(
                quotationNumber: "Q-${1000 + index}",
                customerName: "Customer ${index + 1}",
                amount: "₹${(1200 + index * 350)}",
                date: "Oct ${23 - index}",
                isRecent: index == 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
