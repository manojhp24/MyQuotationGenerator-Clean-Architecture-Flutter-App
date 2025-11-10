enum CustomerMessages {
  addSuccess,
  updateSuccess,
  deleteSuccess,
  fetchError,
  saveError,
  deleteError,
  invalidInput,
  requiredFields,
  updateError,
}

extension CustomerMessagesExtension on CustomerMessages {
  String get message {
    switch (this) {
      case CustomerMessages.addSuccess:
        return "Customer added successfully.";
      case CustomerMessages.updateSuccess:
        return "Customer updated successfully.";
      case CustomerMessages.deleteSuccess:
        return "Customer deleted successfully.";
      case CustomerMessages.fetchError:
        return "Failed to load customers. Please try again.";
      case CustomerMessages.saveError:
        return "Failed to save customer. Try again.";
      case CustomerMessages.invalidInput:
        return "Please check your input and try again.";
      case CustomerMessages.requiredFields:
        return "Please fill in all required fields.";
      case CustomerMessages.deleteError:
        return "Failed to delete customer. Please try again.";
      case CustomerMessages.updateError:
        return "Failed to update customer. Please try again";
    }
  }
}
