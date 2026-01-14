import 'package:flutter/material.dart';
import 'package:my_quotation_generator/features/quotation/presentation/widgets/quotation_page/quotation_list_card.dart';

import '../../../../../config/utils/app_sizes.dart';
import '../../provider/quotation_list_ui_model.dart';

class QuotationListView extends StatelessWidget {
  const QuotationListView({
    super.key,
    required this.quotations,

  });

  final List<QuotationListItem> quotations;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme
        .of(context)
        .colorScheme;

    return ListView.separated(
      itemCount: quotations.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppSizes.spaceS(context)),
      itemBuilder: (context, index) {
        final quotation = quotations[index];

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20),
            side: BorderSide(
              color: scheme.outlineVariant,
            ),
          ),
          child: QuotationListCard(
            quotation: quotation,
          ),
        );
      },
    );
  }
}