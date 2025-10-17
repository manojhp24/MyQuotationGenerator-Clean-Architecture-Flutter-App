import 'package:flutter/material.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../config/utils/app_sizes.dart';
import '../../../../core/common/widgets/form_text_field.dart';
import '../../../../core/enums/business_category_enum.dart';
import '../../../../core/enums/state_enum.dart';
import '../provider/business_notifier.dart';
import '../../../../core/common/widgets/category_bottom_sheet.dart';
import 'section_title.dart';

class BusinessForm extends StatelessWidget {
  const BusinessForm({
    super.key,
    required this.notifier,
  });

  final BusinessNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Form(
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

        ],
      ),
    );
  }
}