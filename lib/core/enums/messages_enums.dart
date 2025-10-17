enum AppMessages{
  businessDataStoreSuccess,
  dataStoreError,
  invalidInput,
  customerDataStoreSuccess,
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
    }
  }
}