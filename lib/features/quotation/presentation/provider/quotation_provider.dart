import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_notifier.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_state.dart';

final quotationNotifierProvider =
    StateNotifierProvider<QuotationNotifier, QuotationState>((ref) {
      return QuotationNotifier();
    });
