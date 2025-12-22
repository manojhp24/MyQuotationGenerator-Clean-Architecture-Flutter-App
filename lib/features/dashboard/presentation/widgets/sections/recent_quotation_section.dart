import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';

import '../quotation_card.dart';
import '../section_title.dart';

class RecentQuotationSection extends StatelessWidget {
  const RecentQuotationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          const DashboardSectionTitle(
            title: AppStrings.recentQuotations,
          ),

          // Quotations list
          Column(
            children: [
              QuotationCard(
                quotationNumber: 'Q-1003',
                customerName: 'Manoj Enterprises',
                amount: '₹12,500',
                date: 'Today, 2:30 PM',
                status: 'sent',
                isRecent: true,
              ),
              const SizedBox(height: 12),
              QuotationCard(
                quotationNumber: 'Q-1002',
                customerName: 'Sunil Traders',
                amount: '₹8,750',
                date: 'Yesterday',
                status: 'draft',
                isRecent: false,
              ),
              const SizedBox(height: 12),
              QuotationCard(
                quotationNumber: 'Q-1001',
                customerName: 'Rajesh Hardware',
                amount: '₹15,200',
                date: '2 days ago',
                status: 'paid',
                isRecent: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}