import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/add_business_usecase.dart';

import 'business_state.dart';

class BusinessNotifier extends StateNotifier<BusinessState> {
  final AddBusinessUseCase addBusinessUseCase;

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

  BusinessNotifier(this.addBusinessUseCase) : super(BusinessState());

  Future<void> saveBusiness() async {
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
      state = state.copyWith(isLoading: false, error: null);
      businessNameController.clear();
      selectCategoryController.clear();
      if(kDebugMode){
        print("Added Successfully");
      }

    } else if (result is DataFailed<int>) {
      state = state.copyWith(
        isLoading: false,
        error: result.error?.message ?? "Unknown Message",
      );
    }
  }


  void printBusinessData() {
    if (kDebugMode) {
      print("Business Name: ${businessNameController.text}");
      print("Category: ${selectCategoryController.text}");
      print("GST IN: ${gstInController.text}");
      print("State: ${stateController.text}");
      print("Other Info: ${otherInfoController.text}");
      print("Contact Name: ${contactNameController.text}");
      print("Mobile: ${mobileNumberController.text}");
      print("Email: ${emailController.text}");
      print("Address1: ${address1Controller.text}");
      print("Address2: ${address2Controller.text}");
      print("Account Name: ${accountNameController.text}");
      print("Account Number: ${accountNumberController.text}");
      print("Bank Name: ${bankNameController.text}");
      print("UPI ID: ${upiIdController.text}");
    }

  }
}

