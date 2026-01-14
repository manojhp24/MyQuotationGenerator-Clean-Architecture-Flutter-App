import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_provider.dart';

import '../../../../../core/helpers/date_formatter.dart';
import '../quotation_card.dart';
import '../section_title.dart';

class RecentQuotationSection extends ConsumerWidget {
  const RecentQuotationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotationState = ref.watch(quotationNotifierProvider);

    final quotations = quotationState.quotations.take(3).toList();

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          const DashboardSectionTitle(
            title: AppStrings.recentQuotations,
          ),

          // Quotations listf (quotations.isEmpty)
          if (quotations.isEmpty)
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.3,
              child: const Center(
                child: Text("No quotations yet"),
              ),
            )


          else
            Column(
              children: quotations.map((q) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: QuotationCard(
                    quotationNumber: q.quoteNo,
                    customerName: q.customerName,
                    amount: q.grandTotal.toString(),
                    date: DateFormatter.toReadableDate(q.quoteDate.toString()),
                    onTap: () =>
                        context.push('/quotation-pdf-view', extra: q.pdfPath),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}