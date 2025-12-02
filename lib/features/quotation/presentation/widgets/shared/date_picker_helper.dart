import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_provider.dart';

class DatePickerHelper {
  static Future<void> selectDate(BuildContext context, WidgetRef ref) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      ref.read(quotationNotifierProvider.notifier).setDate(pickedDate);
    }
  }
}
