import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/core/enums/customer_message.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/add_customer_usecases.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/delete_customer_usecase.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/update_customer_usecase.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_state.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/common/App_snack_bar/custom_snack_bar.dart';
import '../../domain/usecases/get_customers_usecase.dart';

/// ---------------------------------------------------------------------------
/// CustomerNotifier
/// ---------------------------------------------------------------------------
/// This class is a Riverpod `StateNotifier` that manages all the business logic
/// for handling customers: adding, fetching, updating, and deleting.
///
/// It interacts with the domain layer (use cases) and updates the UI layer
/// through a reactive `CustomerState`.
///

class CustomerNotifier extends StateNotifier<CustomerState> {
  final AddCustomerUseCase addCustomerUseCase;
  final GetCustomerUseCase getCustomerUseCase;
  final UpdateCustomerUseCase updateCustomerUseCase;
  final DeleteCustomerUseCase deleteCustomerUseCase;

  CustomerNotifier(this.addCustomerUseCase, this.getCustomerUseCase,
      this.updateCustomerUseCase, this.deleteCustomerUseCase)
    : super(CustomerState()) {
    fetchCustomer();
  }

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

  /// Adding Customer
  Future<bool> saveCustomer(BuildContext context) async {
    if (!formKey.currentState!.validate()){
      if (context.mounted) {
        showCustomSnackBar(
          context,
          message: CustomerMessages.requiredFields.message,
          isSuccess: false,
          backgroundColor: AppColors.darkGrey2,
          durationSeconds: 3,
        );
      }
      return false;
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

    await Future.delayed(const Duration(seconds: 1));

    if (context.mounted) {
      showCustomSnackBar(
        context,
        message: CustomerMessages.addSuccess.message,
        isSuccess: true,
        backgroundColor: AppColors.darkGrey2,
        durationSeconds: 3,
      );
    }

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

      return true;
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
      return false;
    }
    return false;
  }

  /// Fetching Customer
  Future<void> fetchCustomer() async {
    state = state.copyWith(isLoading: true);
    final result = await getCustomerUseCase();

    if (result is DataSuccess<List<CustomerEntity>>) {
      final customers = result.data ?? [];
      state = state.copyWith(customer: customers, isLoading: false);
    } else if (result is DataFailed<List<CustomerEntity>>) {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Update Customer
  Future<bool> updateCustomer(BuildContext context,int customerId) async {
    if (!formKey.currentState!.validate()) {
      if (context.mounted) {
        showCustomSnackBar(context, message: "Fill required fields correctly",
          isSuccess: false,
          backgroundColor: AppColors.darkGrey2,
          durationSeconds: 3,);
      }
      return false;
    }

    state = state.copyWith(isLoading: true);
    final customer = CustomerEntity(
      id: customerId,
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

    final result = await updateCustomerUseCase(customer);

    await Future.delayed(const Duration(seconds: 1));


    if (context.mounted) {
      showCustomSnackBar(
        context,
        message: CustomerMessages.updateSuccess.message,
        isSuccess: true,
        backgroundColor: AppColors.darkGrey2,
        durationSeconds: 3,
      );
    }

    state = state.copyWith(isLoading: false);

    if (result is DataSuccess<int>) {
      fetchCustomer();
      return true;
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
      return false;
    }
    return false;
  }

  /// Delete Customer
  Future<bool> deleteCustomer(BuildContext context, int customerId) async {
    state = state.copyWith(isLoading: true);

    final result = await deleteCustomerUseCase(customerId);

    if (context.mounted) {
      showCustomSnackBar(
        context,
        message: CustomerMessages.deleteSuccess.message,
        isSuccess: true,
        backgroundColor: AppColors.darkGrey2,
        durationSeconds: 3,
      );
    }

    state = state.copyWith(isLoading: false);

    if (result is DataSuccess<int>) {
      fetchCustomer();
      return true;
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
      return false;
    }


    return false;
  }


}
