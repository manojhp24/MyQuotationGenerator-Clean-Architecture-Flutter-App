class Validators {
  static String? requiredField(String label, String? value,
      {String? customMessage}) {
    if (value == null || value.trim().isEmpty) {
      return customMessage ?? '$label is required';
    }
    return null;
  }

  static String? validateMobileNumber(String label, String? value) {
    if (value == null || value.trim().isEmpty) {
      return "$label is Required";
    }

    final mobileNumberPattern = RegExp(r'^(\+91|91)?[6-9]\d{9}$');
    if (!mobileNumberPattern.hasMatch(value)) {
      return "Invalid Mobile Number";
    }

    return null;
  }

  static String? gstValidator(String? value) {
    final gstRegex = RegExp(
      r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$',
    );
    if (!gstRegex.hasMatch(value!)) return "Invalid GST Number";

    return null;
  }
}
