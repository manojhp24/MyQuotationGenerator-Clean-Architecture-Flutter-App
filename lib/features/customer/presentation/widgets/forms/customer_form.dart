import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/core/common/validators/input_validators.dart';
import 'package:my_quotation_generator/core/helpers/contact_picker_helper.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../../../../core/common/widgets/category_bottom_sheet.dart';
import '../../../../../core/common/widgets/form_text_field.dart';
import '../../../../../core/enums/state_enum.dart';

class CustomerForm extends ConsumerStatefulWidget {
  final bool isUpdate;
  final CustomerEntity? customer;

  const CustomerForm({
    super.key,
    this.isUpdate = false,
    this.customer,
  });

  @override
  ConsumerState<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends ConsumerState<CustomerForm> {
  late final customerNotifier = ref.read(customerNotifierProvider.notifier);

  @override
  void initState() {
    super.initState();
    customerNotifier.initializeForm(
      isUpdate: widget.isUpdate,
      customer: widget.customer,
    );
  }

  @override
  Widget build(BuildContext context) {


    return Form(
      key: customerNotifier.formKey,
      child: Column(
        children: [
          AppFormField(
            label: AppStrings.customerName,
            controller: customerNotifier.customerNameController,
            validator: (value) =>
                Validators.requiredField(AppStrings.customerName, value),
            prefixIcon: Icons.person,
          ),
          AppFormField(
            label: AppStrings.email,
            controller: customerNotifier.emailController,
            prefixIcon: Icons.email,
          ),
          AppFormField(
            label: AppStrings.mobileNumber,
            controller: customerNotifier.mobileNumberController,
            validator: (value) =>
                Validators.validateMobileNumber(AppStrings.mobileNumber, value),
            prefixIcon: Icons.phone,
            suffixIcon: Icons.contact_page,
            keyboardType: TextInputType.numberWithOptions(),
            onSuffixPressed: () async {
              final phone = await ContactPickerHelper.pickPhoneNumber();
              if (phone != null) {
                customerNotifier.mobileNumberController.text = phone;
              }
            },
          ),
          AppFormField(
            label: AppStrings.address1,
            controller: customerNotifier.address1Controller,
            prefixIcon: Icons.location_on,
          ),
          AppFormField(
            label: AppStrings.address2,
            controller: customerNotifier.address2Controller,
            prefixIcon: Icons.location_on,
          ),
          AppFormField(
            label: AppStrings.otherInfo,
            controller: customerNotifier.otherInfoController,
            prefixIcon: Icons.info,
          ),
          AppFormField(
            label: AppStrings.gstIn,
            controller: customerNotifier.gstInController,
            prefixIcon: Icons.receipt,
          ),
          AppFormField(
            label: AppStrings.state,
            controller: customerNotifier.stateController,
            prefixIcon: Icons.map,
            readOnly: true,
            onTap: () async {
              final selectedState = await showEnumSelectionSheet<States>(
                context,
                values: States.values,
                labelBuilder: (e) => e.displayName,
              );
              if (selectedState != null) {
                customerNotifier.stateController.text =
                    selectedState.displayName;
              }
            },
          ),
          AppFormField(
            label: AppStrings.shippingAddress,
            controller: customerNotifier.shippingAddressController,
            prefixIcon: Icons.local_shipping,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}