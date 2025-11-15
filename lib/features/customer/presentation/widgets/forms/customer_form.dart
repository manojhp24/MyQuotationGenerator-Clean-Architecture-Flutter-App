// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/core/common/validators/input_validators.dart';
import 'package:my_quotation_generator/core/helpers/contact_picker_helper.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../../../../config/utils/app_sizes.dart';
import '../../../../../core/common/widgets/category_bottom_sheet.dart';
import '../../../../../core/common/widgets/form_text_field.dart';
import '../../../../../core/enums/state_enum.dart';
import '../../provider/customer_notifier.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

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
  late final CustomerNotifier notifier;

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final address1Focus = FocusNode();
  final address2Focus = FocusNode();
  final otherInfoFocus = FocusNode();
  final gstFocus = FocusNode();
  final shippingFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    notifier = ref.read(customerNotifierProvider.notifier);

    notifier.initializeForm(isUpdate: widget.isUpdate,customer: widget.customer);
  }

  @override
  void dispose() {
    nameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    address1Focus.dispose();
    address2Focus.dispose();
    otherInfoFocus.dispose();
    gstFocus.dispose();
    shippingFocus.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Form(
      key: notifier.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSizes.sectionVertical(context)),
          AppFormField(
            label: AppStrings.customerName,
            controller: notifier.customerNameController,
            validator: (value) =>
                Validators.requiredField("Customer Name", value),
            prefixIcon: Icons.person,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            nextFocusNode: emailFocus,
          ),
          AppFormField(
            label: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
            controller: notifier.emailController,
            prefixIcon: Icons.email,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            nextFocusNode: phoneFocus,
          ),
          AppFormField(
            label: AppStrings.mobileNumber,
            keyboardType: const TextInputType.numberWithOptions(),
            controller: notifier.mobileNumberController,
            validator: (value) =>
                Validators.validateMobileNumber('Mobile Number', value),
            prefixIcon: Icons.phone,
            suffixIcon: Icons.contact_page,
            onSuffixPressed: () async {
              bool granted = await FlutterContacts.requestPermission();
              print("Permission granted: $granted");

              final phone = await ContactPickerHelper.pickPhoneNumber();
              if (phone != null) notifier.mobileNumberController.text = phone;
            },

            textInputAction: TextInputAction.next,
            nextFocusNode: address1Focus,
          ),
          AppFormField(
            label: AppStrings.address1,
            controller: notifier.address1Controller,
            prefixIcon: Icons.location_on,
            textInputAction: TextInputAction.next,
            nextFocusNode: address2Focus,
          ),
          AppFormField(
            label: AppStrings.address2,
            controller: notifier.address2Controller,
            prefixIcon: Icons.location_on,
            textInputAction: TextInputAction.next,
            nextFocusNode: otherInfoFocus,
          ),
          AppFormField(
            label: AppStrings.otherInfo,
            controller: notifier.otherInfoController,
            prefixIcon: Icons.info,
            textInputAction: TextInputAction.next,
            nextFocusNode: gstFocus,
          ),
          AppFormField(
            label: AppStrings.gstIn,
            controller: notifier.gstInController,
            prefixIcon: Icons.confirmation_number,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            nextFocusNode: shippingFocus,
          ),
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
