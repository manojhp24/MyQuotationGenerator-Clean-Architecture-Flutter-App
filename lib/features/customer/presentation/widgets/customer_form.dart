import 'package:flutter/material.dart';
import '../../../../config/constants/app_strings.dart';
import '../../../../config/utils/app_sizes.dart';
import '../../../../core/common/widgets/form_text_field.dart';
import '../../../../core/enums/state_enum.dart';
import '../../../../core/common/widgets/category_bottom_sheet.dart';

class CustomerForm extends StatelessWidget {
  const CustomerForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: AppSizes.sectionVertical(context)),
          AppFormField(label: AppStrings.customerName),
          AppFormField(
            label: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
          ),
          AppFormField(
            label: AppStrings.mobileNumber,
            keyboardType: TextInputType.numberWithOptions(),
          ),
          AppFormField(label: AppStrings.address1),
          AppFormField(label: AppStrings.address2),
          AppFormField(label: AppStrings.otherInfo),
          AppFormField(label: AppStrings.gstIn),
          AppFormField(
            label: AppStrings.state,
            readOnly: true,
            onTap: () async {
              final selectedState = await showEnumSelectionSheet(
                context,
                values: States.values,
                labelBuilder: (e) => e.displayName,
              );
            },
          ),
          AppFormField(
            label: AppStrings.shippingAddress,
            maxLines: 5,
            alignLabelWithHint: true,
          ),
        ],
      ),
    );
  }
}