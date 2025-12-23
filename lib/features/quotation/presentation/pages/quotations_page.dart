import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/common/widgets/custom_app_bar.dart';
import 'package:my_quotation_generator/core/common/widgets/empty_state_widget.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_list_ui_model.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_provider.dart';

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
    final state = ref.watch(quotationNotifierProvider);
    final quotations = ref
        .watch(quotationNotifierProvider.notifier)
        .filteredQuotation;

    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.quotationListAppBarTitle,
        showBack: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.screenPadding(context)),
        child: Column(
          children: [
            SearchBar(
              elevation: WidgetStateProperty.all(0),
              leading: const Icon(Icons.search),
              hintText: "Search quotations...",
              onChanged: (value) {
                ref
                    .read(quotationNotifierProvider.notifier)
                    .updateSearch(value);
              },
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radius(context))
              )),
            ),
            SizedBox(height: AppSizes.spaceM(context)),
            Expanded(
              child: _buildBody(
                context,
                state.isLoading,
                quotations,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: state.quotations.isEmpty
          ? null
          : FloatingActionButton(
        onPressed: () => context.push('/create-quotation'),
        child: const Icon(Icons.note_add_outlined),
      ),
    );
  }
}


Widget _buildBody(BuildContext context,
    bool isLoading,
    List<QuotationListItem> quotations,) {
  if (isLoading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (quotations.isEmpty) {
    return EmptyStateWidget(
      icon: Icons.description_outlined,
      message: 'No quotations found',
      actionText: 'Create quotation',
      onAction: () => context.push('/create-quotation'),
    );
  }

  return ListView.separated(
    itemCount: quotations.length,
    separatorBuilder: (_, _) =>
        SizedBox(height: AppSizes.spaceS(context)),
    itemBuilder: (context, index) {
      final quotation = quotations[index];

      return Card(
        elevation: 0,
        color: Theme
            .of(context)
            .colorScheme
            .surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Theme
                .of(context)
                .colorScheme
                .outlineVariant,
          ),
        ),
        child: QuotationListCard(
          quotation: quotation,
        ),
      );
    },
  );
}
