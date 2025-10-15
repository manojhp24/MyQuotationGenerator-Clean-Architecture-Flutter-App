import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/enums/messages_enums.dart';
import 'package:my_quotation_generator/features/business/presentation/provider/business_provider.dart';

import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/enums/business_category_enum.dart';
import '../../../../core/enums/state_enum.dart';
import '../../../../core/resource/App_snack_bar/custom_snack_bar.dart';
import '../widgets/add_business_widgets/category_bottom_sheet.dart';
import '../widgets/add_business_widgets/form_text_field.dart';
import '../widgets/add_business_widgets/section_title.dart';

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
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                /// Business Details Section
                SectionTitle(title: AppStrings.businessDetails),
                SizedBox(height: AppSizes.sectionVertical(context)),
                Column(
                  children: [
                    AppFormField(
                      label: AppStrings.businessName,
                      controller: notifier.businessNameController,
                    ),

                    AppFormField(
                      controller: notifier.selectCategoryController,
                      label: AppStrings.selectCategory,
                      readOnly: true,
                      onTap: () async {
                        final selected =
                            await showEnumSelectionSheet<BusinessCategory>(
                              context,
                              values: BusinessCategory.values,
                              labelBuilder: (e) => e.displayName,
                            );

                        if (selected != null) {
                          notifier.selectCategoryController.text =
                              selected.displayName;
                        }
                      },
                    ),

                    AppFormField(
                      controller: notifier.gstInController,
                      label: AppStrings.gstIn,
                    ),

                    AppFormField(
                      controller: notifier.stateController,
                      label: AppStrings.state,
                      onTap: () async {
                        final selectedState = await showEnumSelectionSheet(
                          context,
                          values: States.values,
                          labelBuilder: (e) => e.displayName,
                        );

                        if (selectedState != null) {
                          notifier.stateController.text =
                              selectedState.displayName;
                        }
                      },
                      readOnly: true,
                    ),

                    AppFormField(
                      label: AppStrings.otherInfo,
                      controller: notifier.otherInfoController,
                    ),
                  ],
                ),

                /// Contact Details Section
                SectionTitle(title: AppStrings.contactDetails),
                SizedBox(height: AppSizes.sectionVertical(context)),

                Column(
                  children: [
                    AppFormField(
                      label: AppStrings.contactName,
                      controller: notifier.contactNameController,
                    ),
                    AppFormField(
                      controller: notifier.mobileNumberController,
                      label: AppStrings.mobileNumber,
                      keyboardType: TextInputType.numberWithOptions(),
                      maxLength: 10,
                    ),
                    AppFormField(
                      label: AppStrings.email,
                      controller: notifier.emailController,
                    ),
                    AppFormField(
                      label: AppStrings.address1,
                      controller: notifier.address1Controller,
                    ),
                    AppFormField(
                      label: AppStrings.address2,
                      controller: notifier.address2Controller,
                    ),
                  ],
                ),

                /// Bank Details Section
                SectionTitle(title: AppStrings.bankDetails),
                SizedBox(height: AppSizes.sectionVertical(context)),
                Column(
                  children: [
                    AppFormField(
                      label: AppStrings.accountName,
                      controller: notifier.accountNameController,
                    ),
                    AppFormField(
                      label: AppStrings.accountNumber,
                      controller: notifier.accountNumberController,
                    ),
                    AppFormField(
                      label: AppStrings.bankName,
                      controller: notifier.bankNameController,
                    ),
                    AppFormField(
                      label: AppStrings.upiId,
                      controller: notifier.upiIdController,
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {
                    // notifier.saveBusiness();
                    showCustomSnackBar(
                      context,
                      message: AppMessages.dataStoreSuccess.message,
                      isSuccess: true,
                      backgroundColor: AppColors.darkGrey2,
                      durationSeconds: 3
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      double.infinity,
                      AppSizes.buttonHeight(context),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.lg(context),
                      vertical: AppSizes.sm(context),
                    ),
                  ),
                  child: Text(
                    AppStrings.addDetails,
                    style: AppTextStyle.buttonText(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
