import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/common/App_snack_bar/custom_snack_bar.dart';
import 'package:my_quotation_generator/core/enums/business_message.dart';
import 'package:my_quotation_generator/core/helpers/business_message_mapper.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
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
        leading: IconButton(onPressed: () =>context.pop(), icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.screenPadding(context)),
          child: Column(
            children: [
              if (state.isLoading) LinearProgressIndicator(),
              Expanded(
                child: SingleChildScrollView(
                  child: BusinessForm(),
                ),
              ),
            ],
          )
      ),
      bottomNavigationBar: BusinessFormButton(
        onPressed: () async {
          final result = await notifier.saveBusiness(context);
          if (!context.mounted) return;
          final isSuccess = result is DataSuccess;

          context.pop(true);

          showCustomSnackBar(
            context,
            message: isSuccess
                ? BusinessMessages.addSuccess.message
                : mapErrorToBusinessMessage(result.error),
          );
        },
        label: AppStrings.addDetails,
      ),

    );
  }
}



