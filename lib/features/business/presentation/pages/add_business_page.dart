import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/features/business/presentation/provider/business_provider.dart';

import '../widgets/business_form.dart';
import '../widgets/business_form_button.dart';

class AddBusinessPage extends ConsumerWidget {
  const AddBusinessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(businessNotifyProvider.notifier);
    final state = ref.watch(businessNotifyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addBusinessAppBarTitle),
        elevation: 0,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: AppSizes.pagePadding(context),
          child: Column(
            children: [
              if (state.isLoading) LinearProgressIndicator(),
              Expanded(
                child: SingleChildScrollView(
                  child: BusinessForm(notifier: notifier),
                ),
              ),
            ],
          )
      ),
      bottomNavigationBar: BusinessFormButton(
        onPressed: () => notifier.saveBusiness(context),
        label: AppStrings.addDetails,
      ),

    );
  }
}



