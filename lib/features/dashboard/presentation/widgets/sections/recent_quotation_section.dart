import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';

import '../quotation_card.dart';
import '../section_title.dart';

class RecentQuotationSection extends StatelessWidget {
  const RecentQuotationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DashboardSectionTitle(
                  title: AppStrings.recentQuotations,
                ),
                TextButton(
                  onPressed: () {
                    // TODO: navigate to full quotation list
                  },
                  child: const Text('View all'),
                ),
              ],
            ),



            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return QuotationCard(
                  quotationNumber: "Q-${1000 + index}",
                  customerName: "Customer ${index + 1}",
                  amount: "₹${1200 + index * 350}",
                  date: "Oct ${23 - index}",
                  isRecent: index == 0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
