enum BusinessMessages {
  addSuccess,
  updateSuccess,
  deleteSuccess,
  fetchError,
  saveError,
  invalidInput,
  requiredFields,
}

extension BusinessMessagesExtension on BusinessMessages {
  String get message {
    switch (this) {
      case BusinessMessages.addSuccess:
        return "Business added successfully.";
      case BusinessMessages.updateSuccess:
        return "Business updated successfully.";
      case BusinessMessages.deleteSuccess:
        return "Business deleted successfully.";
      case BusinessMessages.fetchError:
        return "Failed to load business data. Please try again.";
      case BusinessMessages.saveError:
        return "Failed to save business data.";
      case BusinessMessages.invalidInput:
        return "Please check your input and try again.";
      case BusinessMessages.requiredFields:
        return "Please fill in all required fields.";
    }
  }
}
