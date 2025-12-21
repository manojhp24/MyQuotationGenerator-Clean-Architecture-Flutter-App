import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:my_quotation_generator/features/business/presentation/provider/business_provider.dart';

import '../provider/business_state.dart';
import '../widgets/business_form.dart';
import '../widgets/business_form_button.dart';

class UpdateBusinessPage extends ConsumerWidget {
  final BusinessEntity business;

  const UpdateBusinessPage({super.key, required this.business});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen<BusinessState>(businessNotifyProvider, (prev, next) {
      if (prev == null) {
        ref.read(businessNotifyProvider.notifier)
            .initializeForm(isUpdate: true, business: business);
      }
    });


    final state = ref.watch(businessNotifyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.updateBusinessAppBarTitle),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.screenPadding(context)),
        child: Column(
          children: [
            if (state.isLoading) const LinearProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                child: BusinessForm(
                  isUpdate: true,
                  business: business,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BusinessFormButton(
        label: AppStrings.update,
        onPressed: () {
          ref
              .read(businessNotifyProvider.notifier)
              .updateBusiness(business.id!);
          context.pop(true);
        },
      ),
    );
  }
}




