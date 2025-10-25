import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/add_customer_usecases.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_state.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/common/App_snack_bar/custom_snack_bar.dart';
import '../../../../core/enums/messages_enums.dart';

class CustomerNotifier extends StateNotifier<CustomerState> {
  final AddCustomerUseCase addCustomerUseCase;

  CustomerNotifier(this.addCustomerUseCase) : super(CustomerState());

  final customerNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final otherInfoController = TextEditingController();
  final gstInController = TextEditingController();
  final stateController = TextEditingController();
  final shippingAddressController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    super.dispose();
    customerNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    otherInfoController.dispose();
    gstInController.dispose();
    stateController.dispose();
    shippingAddressController.dispose();
  }

  Future<void> saveCustomer(BuildContext context) async {

    if (!formKey.currentState!.validate()){
      if (context.mounted) {
        showCustomSnackBar(
          context,
          message: "Enter required Fields",
          isSuccess: false,
          backgroundColor: AppColors.darkGrey2,
          durationSeconds: 3,
        );
      }
      return;
    }

    state = state.copyWith(isLoading: true);

    final customer = CustomerEntity(
      customerName: customerNameController.text,
      email: emailController.text,
      mobile: mobileNumberController.text,
      address1: address1Controller.text,
      address2: address2Controller.text,
      otherInfo: otherInfoController.text,
      gstIn: gstInController.text,
      state: stateController.text,
      shippingAddress: shippingAddressController.text,
    );

    final result = await addCustomerUseCase(customer);

    state = state.copyWith(isLoading: false);

    if (result is DataSuccess<int>) {
      customerNameController.clear();
      emailController.clear();
      mobileNumberController.clear();
      address1Controller.clear();
      address2Controller.clear();
      otherInfoController.clear();
      gstInController.clear();
      stateController.clear();
      shippingAddressController.clear();

      if (context.mounted) {
        showCustomSnackBar(
          context,
          message: AppMessages.customerDataStoreSuccess.message,
          isSuccess: true,
          backgroundColor: AppColors.darkGrey2,
          durationSeconds: 3,
        );
      }
    } else if (result is DataFailed<int>) {
      if (context.mounted) {
        showCustomSnackBar(
          context,
          message: result.error?.toString() ?? "Failed to save customer",
          isSuccess: false,
          backgroundColor: AppColors.darkGrey2,
          durationSeconds: 3,
        );
      }
    }
  }


}
