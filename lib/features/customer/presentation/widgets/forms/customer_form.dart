import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/core/common/validators/input_validators.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';

import '../../../../../config/constants/app_strings.dart';
import '../../../../../config/utils/app_sizes.dart';
import '../../../../../core/common/widgets/category_bottom_sheet.dart';
import '../../../../../core/common/widgets/form_text_field.dart';
import '../../../../../core/enums/state_enum.dart';
import '../../provider/customer_notifier.dart';

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

  @override
  void initState() {
    super.initState();
    notifier = ref.read(customerNotifierProvider.notifier);

    if (widget.isUpdate && widget.customer != null) {
      final c = widget.customer!;
      notifier.customerNameController.text = c.customerName ?? '';
      notifier.emailController.text = c.email ?? '';
      notifier.mobileNumberController.text = c.mobile ?? '';
      notifier.address1Controller.text = c.address1 ?? '';
      notifier.address2Controller.text = c.address2 ?? '';
      notifier.otherInfoController.text = c.otherInfo ?? '';
      notifier.gstInController.text = c.gstIn ?? '';
      notifier.stateController.text = c.state ?? '';
      notifier.shippingAddressController.text = c.shippingAddress ?? '';
    } else {
      notifier.customerNameController.clear();
      notifier.emailController.clear();
      notifier.mobileNumberController.clear();
      notifier.address1Controller.clear();
      notifier.address2Controller.clear();
      notifier.otherInfoController.clear();
      notifier.gstInController.clear();
      notifier.stateController.clear();
      notifier.shippingAddressController.clear();
    }
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
          ),
          AppFormField(
            label: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
            controller: notifier.emailController,
            prefixIcon: Icons.email,
          ),
          AppFormField(
            label: AppStrings.mobileNumber,
            keyboardType: const TextInputType.numberWithOptions(),
            controller: notifier.mobileNumberController,
            validator: (value) =>
                Validators.validateMobileNumber('Mobile Number', value),
            prefixIcon: Icons.phone,
            suffixIcon: Icons.contact_page,
          ),
          AppFormField(
            label: AppStrings.address1,
            controller: notifier.address1Controller,
            prefixIcon: Icons.location_on,
          ),
          AppFormField(
            label: AppStrings.address2,
            controller: notifier.address2Controller,
            prefixIcon: Icons.location_on,
          ),
          AppFormField(
            label: AppStrings.otherInfo,
            controller: notifier.otherInfoController,
            prefixIcon: Icons.info,
          ),
          AppFormField(
            label: AppStrings.gstIn,
            controller: notifier.gstInController,
            prefixIcon: Icons.confirmation_number,
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
