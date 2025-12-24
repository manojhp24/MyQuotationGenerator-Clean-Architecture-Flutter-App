import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/common/widgets/custom_app_bar.dart';
import 'package:my_quotation_generator/core/common/widgets/empty_state_widget.dart';
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
    final scheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;

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

            /// Search
            SearchBar(
              leading: const Icon(Icons.search),
              hintText: "Search quotations...",
              elevation: WidgetStateProperty.all(0),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.radius(context),
                  ),
                ),
              ),
              onChanged: (value) {
                ref
                    .read(quotationNotifierProvider.notifier)
                    .updateSearch(value);
              },
            ),

            SizedBox(height: AppSizes.spaceM(context)),

            /// Content
            Expanded(
              child: () {
                if (state.isLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: scheme.primary,
                          strokeWidth: 2,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Loading quotations...',
                          style: textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state.quotations.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.description_outlined,
                    message: 'No quotations found',
                    actionText: 'Create quotation',
                    onAction: () async {
                      final result =
                      await context.push('/create-quotation');
                      if (result == true) {
                        ref
                            .read(quotationNotifierProvider.notifier)
                            .getQuotations();
                      }
                    },
                  );
                }

                if (quotations.isEmpty) {
                  return EmptyStateWidget(icon: Icons.search_off_outlined,
                      message: "Oops! Quotation not found",
                    actionText: "",
                  );
                }
                return RefreshIndicator(
                  color: scheme.primary,
                  backgroundColor: scheme.surface,
                  onRefresh: () async {
                    ref
                        .read(quotationNotifierProvider.notifier)
                        .getQuotations();
                  },
                  child: ListView.separated(
                    itemCount: quotations.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: AppSizes.spaceS(context)),
                    itemBuilder: (context, index) {
                      final quotation = quotations[index];

                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: scheme.outlineVariant,
                          ),
                        ),
                        child: QuotationListCard(
                          quotation: quotation,
                        ),
                      );
                    },
                  ),
                );
              }(),
            ),
          ],
        ),
      ),

      /// FAB
      floatingActionButton: state.quotations.isEmpty
          ? null
          : FloatingActionButton.extended(
        onPressed: () async {
          final result =
          await context.push('/create-quotation');
          if (result == true) {
            ref
                .read(quotationNotifierProvider.notifier)
                .getQuotations();
          }
        },
        icon: const Icon(Icons.note_add_outlined),
        label: const Text('Create Quotation'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        highlightElevation: 8,
      ),
    );
  }
}
