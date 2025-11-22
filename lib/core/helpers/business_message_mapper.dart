import 'package:my_quotation_generator/core/enums/business_message.dart';

String mapErrorToBusinessMessage(Object? error) {
  final message = error.toString();

  if (message.contains("Validation Failed")) {
    return BusinessMessages.requiredFields.message;
  }

  return BusinessMessages.unknownError.message;
}
