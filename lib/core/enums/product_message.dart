enum ProductMessages {
  addSuccess,
  updateSuccess,
  updateError,
  deleteSuccess,
  fetchError,
  saveError,
  invalidInput,
  requiredFields,
}

extension ProductMessagesExtension on ProductMessages {
  String get message {
    switch (this) {
      case ProductMessages.addSuccess:
        return "Product added successfully.";
      case ProductMessages.updateSuccess:
        return "Product updated successfully.";
      case ProductMessages.deleteSuccess:
        return "Product deleted successfully.";
      case ProductMessages.fetchError:
        return "Failed to load products. Please try again.";
      case ProductMessages.saveError:
        return "Failed to save product.";
      case ProductMessages.invalidInput:
        return "Please check your input and try again.";
      case ProductMessages.requiredFields:
        return "Please fill in all required fields.";
      case ProductMessages.updateError:
        return "Failed to update product. Please try again";
    }
  }
}
