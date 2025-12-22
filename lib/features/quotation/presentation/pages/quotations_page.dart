import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/common/widgets/custom_app_bar.dart';
import 'package:my_quotation_generator/core/common/widgets/empty_state_widget.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_provider.dart';

import '../provider/quotation_state.dart';
import '../widgets/quotation_page/quotation_list_card.dart';

class QuotationsPage extends ConsumerStatefulWidget {
  const QuotationsPage({super.key});

  @override
  ConsumerState<QuotationsPage> createState() => _QuotationsPageState();
}

class _QuotationsPageState extends ConsumerState<QuotationsPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(quotationNotifierProvider.notifier).getQuotations();
    });
  }

  @override
  Widget build(BuildContext context) {
    ;
    final state = ref.watch(quotationNotifierProvider);

    return Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.quotationListAppBarTitle,
          showBack: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.screenPadding(context)),
          child: _buildBody(context, state),
        ),

        floatingActionButton: state.quotations.isEmpty
            ? null
            : FloatingActionButton(
          onPressed: () => context.push('/create-quotation'),
          child: Icon(Icons.note_add_outlined),)
    );
  }
}

Widget _buildBody(BuildContext context, QuotationState state) {
  if (state.isLoading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (state.quotations.isEmpty) {
    return EmptyStateWidget(
      icon: Icons.description_outlined,
      message: 'No quotations yet',
      actionText: 'Create quotation',
      onAction: () => context.push('/create-quotation'),
    );
  }

  return ListView.separated(
    itemCount: state.quotations.length,
    separatorBuilder: (_, _) =>
        SizedBox(height: AppSizes.spaceS(context)),
    itemBuilder: (context, index) {
      final quotation = state.quotations[index];

      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),

        ),
        child: QuotationListCard(
          quotation: quotation,
        ),
      );
    },
  );
}



