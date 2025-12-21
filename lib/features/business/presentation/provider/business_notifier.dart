import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/add_business_usecase.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/get_business_usecase.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/update_business_usecase.dart';

import 'business_state.dart';

class BusinessNotifier extends StateNotifier<BusinessState> {
  final AddBusinessUseCase addBusinessUseCase;
  final GetBusinessUseCase getBusinessUseCase;
  final UpdateBusinessUseCase updateBusinessUseCase;

  final businessNameController = TextEditingController();
  final selectCategoryController = TextEditingController();
  final gstInController = TextEditingController();
  final stateController = TextEditingController();
  final otherInfoController = TextEditingController();
  final contactNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final upiIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  BusinessNotifier(this.addBusinessUseCase, this.getBusinessUseCase,
      this.updateBusinessUseCase)
    : super(BusinessState());

  @override
  void dispose() {
    businessNameController.dispose();
    selectCategoryController.dispose();
    gstInController.dispose();
    stateController.dispose();
    otherInfoController.dispose();
    contactNameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    accountNameController.dispose();
    accountNumberController.dispose();
    bankNameController.dispose();
    upiIdController.dispose();
    super.dispose();
  }

  Future<DataState<int>> saveBusiness(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return DataFailed<int>(Exception("Validation Failed"));
    }

    state = state.copyWith(isLoading: true);

    final business = BusinessEntity(
        businessName: businessNameController.text,
        businessCategory: selectCategoryController.text,
        gstIn: gstInController.text,
        state: stateController.text,
        otherInfo: otherInfoController.text,
        contactName: contactNameController.text,
        mobileNumber: mobileNumberController.text,
        email: emailController.text,
        address1: address1Controller.text,
        address2: address2Controller.text,
        accountName: accountNameController.text,
        accountNumber: accountNumberController.text,
        bankName: bankNameController.text,
        upiId: upiIdController.text,
      );

      final result = await addBusinessUseCase(business);

      if (result is DataSuccess<int>) {
        clearForm();
      } else if (result is DataFailed<int>) {
        state = state.copyWith(
            error: result.error?.toString() ?? "Something went wrong");
      }

    state = state.copyWith(isLoading: false);
    return result;

  }

  Future<DataState<int>> updateBusiness(int customerId) async {

    if (!formKey.currentState!.validate()) {
      return DataFailed<int>(Exception("Validation Error"));
    }


    state = state.copyWith(isLoading: true);

    final newBusinessData = BusinessEntity(
      id: customerId,
      businessName: businessNameController.text,
      businessCategory: selectCategoryController.text,
      gstIn: gstInController.text,
      state: stateController.text,
      otherInfo: otherInfoController.text,
      contactName: contactNameController.text,
      mobileNumber: mobileNumberController.text,
      email: emailController.text,
      address1: address1Controller.text,
      address2: address2Controller.text,
      accountName: accountNameController.text,
      accountNumber: accountNumberController.text,
      bankName: bankNameController.text,
      upiId: upiIdController.text,
    );

    final result = await updateBusinessUseCase(newBusinessData);

    if (result is DataSuccess) {
      state = state.copyWith(isLoading: false);
      await fetchBusiness();
    } else {
      state = state.copyWith(isLoading: false, error: result.error?.toString());
    }
    return result;
  }

  Future<void> fetchBusiness() async {
    state = state.copyWith(isLoading: true);

    final result = await getBusinessUseCase();

    if (result is DataSuccess<List<BusinessEntity>>) {
        final business = result.data ?? [];
        state = state.copyWith(
          businesses: business,
          isLoading: false,
          error: null,
        );
      } else if (result is DataFailed) {
        state = state.copyWith(
          isLoading: false,
          error: result.error?.toString() ?? 'Something went wrong',
        );
      }
  }

  void initializeForm({required bool isUpdate, BusinessEntity? business}) {
    if (!isUpdate) {
      clearForm();
      return;
    }

    if (business == null) return;

    businessNameController.text = business.businessName ?? '';
    contactNameController.text = business.contactName ?? '';
    mobileNumberController.text = business.mobileNumber ?? '';
    emailController.text = business.email ?? '';
    address1Controller.text = business.address1 ?? '';
    address2Controller.text = business.address2 ?? '';
    otherInfoController.text = business.otherInfo ?? '';
    gstInController.text = business.gstIn ?? '';
    stateController.text = business.state ?? '';
    selectCategoryController.text = business.businessCategory ?? '';
    accountNameController.text = business.accountName ?? '';
    accountNumberController.text = business.accountNumber ?? '';
    bankNameController.text = business.bankName ?? '';
    upiIdController.text = business.upiId ?? '';
  }


  void clearForm() {
    businessNameController.clear();
    contactNameController.clear();
    mobileNumberController.clear();
    emailController.clear();
    address1Controller.clear();
    address2Controller.clear();
    otherInfoController.clear();
    gstInController.clear();
    stateController.clear();
    selectCategoryController.clear();
    accountNameController.clear();
    accountNumberController.clear();
    upiIdController.clear();
  }
}

