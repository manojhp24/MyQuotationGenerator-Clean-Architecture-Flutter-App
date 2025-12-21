import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/add_customer_usecases.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/delete_customer_usecase.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/update_customer_usecase.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_state.dart';

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

  CustomerNotifier(
    this.addCustomerUseCase,
    this.getCustomerUseCase,
    this.updateCustomerUseCase,
    this.deleteCustomerUseCase,
  ) : super(CustomerState()) {
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
  Future<DataState<int>> saveCustomer(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      state = state.copyWith(error: "Validation Failed");
      return DataFailed<int>(Exception("Validation Failed"));
    }

    final newCustomer = CustomerEntity(
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


    final previousCustomers =
    List<CustomerEntity>.from(state.customer);

    state = state.copyWith(
      customer: [...state.customer, newCustomer],
    );


    final result = await addCustomerUseCase(newCustomer);


    if (result is DataSuccess<int>) {
      clearForm();
      return result;
    } else {
      state = state.copyWith(customer: previousCustomers);
      state = state.copyWith(
        error: result.error?.toString() ?? "Something went wrong",
      );
      return result;
    }
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
  Future<DataState<int>> updateCustomer(
      int customerId) async {
    if (!formKey.currentState!.validate()) {
      state = state.copyWith(error: "Validation Error");
      return DataFailed<int>(Exception("Validation Error"));
    }

    state = state.copyWith(isLoading: true);

    final updatedCustomer = CustomerEntity(
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

    final previousCustomers = List<CustomerEntity>.from(state.customer);

    final updatedList = state.customer.map((c) {
      if (c.id == customerId) {
        return updatedCustomer;
      }
      return c;
    }).toList();

    state = state.copyWith(customer: updatedList);

    final result = await updateCustomerUseCase(updatedCustomer);

      if (result is DataSuccess<int>) {
        state = state.copyWith(isLoading: false);
        return result;
      } else if (result is DataFailed<int>) {
        state = state.copyWith(
          customer: previousCustomers,
          error: result.error?.toString() ?? "Something went wrong",
        );
      }
    state = state.copyWith(isLoading: false);
    return result;
  }

  /// Delete Customer
  Future<DataState<int>> deleteCustomer(BuildContext context,
      int customerId) async {
    state = state.copyWith(isLoading: true);

    final previousCustomers = List<CustomerEntity>.from(state.customer);

    final updatedList = state.customer
        .where((c) => c.id != customerId)
        .toList();

    state = state.copyWith(customer: updatedList);
    final result = await deleteCustomerUseCase(customerId);

      if (result is DataSuccess<int>) {
        state = state.copyWith(isLoading: false);
        return result;
      } else if (result is DataFailed<int>) {
        state = state.copyWith(
            customer: previousCustomers,
            error: result.error?.toString() ?? 'Something went wrong');
      }
    state = state.copyWith(isLoading: false);
    return result;
  }

  void initializeForm({required bool isUpdate, CustomerEntity? customer}) {
    if (isUpdate && customer != null) {
      customerNameController.text = customer.customerName ?? '';
      emailController.text = customer.email ?? '';
      mobileNumberController.text = customer.mobile ?? '';
      address1Controller.text = customer.address1 ?? '';
      address2Controller.text = customer.address2 ?? '';
      otherInfoController.text = customer.otherInfo ?? '';
      gstInController.text = customer.gstIn ?? '';
      stateController.text = customer.state ?? '';
      shippingAddressController.text = customer.shippingAddress ?? '';
    } else {
      clearForm();
    }
  }

  void clearForm() {
    customerNameController.clear();
    emailController.clear();
    mobileNumberController.clear();
    address1Controller.clear();
    address2Controller.clear();
    otherInfoController.clear();
    gstInController.clear();
    stateController.clear();
    shippingAddressController.clear();
  }

  void clearCustomers() {
    state = state.copyWith(customer: []);
  }

}
