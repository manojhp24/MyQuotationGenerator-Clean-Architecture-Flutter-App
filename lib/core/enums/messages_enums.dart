enum AppMessages{
  businessDataStoreSuccess,
  dataStoreError,
  invalidInput,
  customerDataStoreSuccess,
  fillRequiredFiled
}

extension AppMessageExtension on AppMessages{
  String get message{
    switch(this){
      case AppMessages.businessDataStoreSuccess:
        return "Business data saved successfully!";
      case AppMessages.dataStoreError:
        return "Failed to save data.";
      case AppMessages.invalidInput:
        return "Invalid input provided";

      case AppMessages.customerDataStoreSuccess:
        return "Customer data saved successfully!";
      case AppMessages.fillRequiredFiled:
        return "Fill the required fields correctly";
    }
  }
}