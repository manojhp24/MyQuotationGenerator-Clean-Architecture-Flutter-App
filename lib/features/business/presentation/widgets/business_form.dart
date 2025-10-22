import 'package:flutter/material.dart';
import 'package:my_quotation_generator/core/common/validators/input_validators.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../config/utils/app_sizes.dart';
import '../../../../core/common/widgets/category_bottom_sheet.dart';
import '../../../../core/common/widgets/form_text_field.dart';
import '../../../../core/enums/business_category_enum.dart';
import '../../../../core/enums/state_enum.dart';
import '../provider/business_notifier.dart';
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
      key: notifier.formKey,
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
                prefixIcon: Icons.business,
                validator: (value) =>
                    Validators.requiredField("Business name", value),
              ),

              AppFormField(
                controller: notifier.selectCategoryController,
                prefixIcon: Icons.category,
                label: AppStrings.selectCategory,
                validator: (value) =>
                    Validators.requiredField("Category", value),
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
                prefixIcon: Icons.receipt_long,
                validator: (value) => Validators.gstValidator(value),
              ),

              AppFormField(
                controller: notifier.stateController,
                label: AppStrings.state,
                prefixIcon: Icons.location_city,
                onTap: () async {
                  final selectedState = await showEnumSelectionSheet<States>(
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
                prefixIcon: Icons.info,
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
                prefixIcon: Icons.person,
              ),
              AppFormField(
                controller: notifier.mobileNumberController,
                label: AppStrings.mobileNumber,
                keyboardType: TextInputType.numberWithOptions(),
                maxLength: 10,
                prefixIcon: Icons.phone,
              ),
              AppFormField(
                label: AppStrings.email,
                controller: notifier.emailController,
                prefixIcon: Icons.email,
              ),
              AppFormField(
                label: AppStrings.address1,
                controller: notifier.address1Controller,
                prefixIcon: Icons.home,
              ),
              AppFormField(
                label: AppStrings.address2,
                controller: notifier.address2Controller,
                prefixIcon: Icons.location_on,
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
                prefixIcon: Icons.account_box,
              ),
              AppFormField(
                label: AppStrings.accountNumber,
                controller: notifier.accountNumberController,
                prefixIcon: Icons.numbers,
              ),
              AppFormField(
                label: AppStrings.bankName,
                controller: notifier.bankNameController,
                prefixIcon: Icons.account_balance,
              ),
              AppFormField(
                label: AppStrings.upiId,
                controller: notifier.upiIdController,
                prefixIcon: Icons.payment,
              ),
            ],
          ),

        ],
      ),
    );
  }
}