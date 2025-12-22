import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String toReadableDate(String dateTime) {
    final date = DateTime.parse(dateTime);
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
