import 'package:flutter/material.dart';
import 'package:my_quotation_generator/core/common/validators/input_validators.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_notifier.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../../../../config/utils/app_sizes.dart';
import '../../../../../core/common/widgets/category_bottom_sheet.dart';
import '../../../../../core/common/widgets/form_text_field.dart';
import '../../../../../core/enums/state_enum.dart';

class CustomerForm extends StatelessWidget {

  final CustomerNotifier notifier;

  const CustomerForm({
    super.key,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: notifier.formKey,
      child: Column(
        children: [
          SizedBox(height: AppSizes.sectionVertical(context)),
          AppFormField(label: AppStrings.customerName,
            controller: notifier.customerNameController,
            validator: (value) =>
                Validators.requiredField("Customer Name", value),
            prefixIcon: Icons.person,),
          AppFormField(
            label: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
            controller: notifier.emailController,
            prefixIcon: Icons.email,
          ),
          AppFormField(
            label: AppStrings.mobileNumber,
            keyboardType: TextInputType.numberWithOptions(),
            controller: notifier.mobileNumberController,
            validator: (value) =>
                Validators.validateMobileNumber('Mobile Number', value),
            prefixIcon: Icons.phone,
            suffixIcon: Icons.contact_page,
          ),
          AppFormField(
            label: AppStrings.address1,
            controller: notifier.address1Controller,
            prefixIcon: Icons.location_on,),
          AppFormField(
            label: AppStrings.address2,
            controller: notifier.address2Controller,
            prefixIcon: Icons.location_on,),
          AppFormField(
            label: AppStrings.otherInfo,
            controller: notifier.otherInfoController,
            prefixIcon: Icons.info,),
          AppFormField(
            label: AppStrings.gstIn,
            controller: notifier.gstInController,
            prefixIcon: Icons.confirmation_number,),
          AppFormField(
            controller: notifier.stateController,
            label: AppStrings.state,
            prefixIcon: Icons.public,
            readOnly: true,
            onTap: () async {
              final selectedState = await showEnumSelectionSheet<States>(
                context,
                values: States.values,
                labelBuilder: (e) => e.displayName,
              );
              if (selectedState != null) {
                notifier.stateController.text = selectedState.displayName;
              }

            },
          ),
          AppFormField(
            label: AppStrings.shippingAddress,
            maxLines: 5,
            alignLabelWithHint: true,
            controller: notifier.shippingAddressController,
          ),
        ],
      ),
    );
  }
}