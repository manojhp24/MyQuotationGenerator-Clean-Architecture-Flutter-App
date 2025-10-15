enum AppMessages{
  dataStoreSuccess,
  dataStoreError,
  invalidInput,
}

extension AppMessageExtension on AppMessages{
  String get message{
    switch(this){
      case AppMessages.dataStoreSuccess:
        return "Data saved successfully!";
      case AppMessages.dataStoreError:
        return "Failed to save data.";
      case AppMessages.invalidInput:
        return "Invalid input provided";
    }
  }
}