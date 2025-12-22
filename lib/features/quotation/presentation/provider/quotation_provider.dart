import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/quotation/domain/usecases/get_quotations_use_case.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_notifier.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_state.dart';

import '../../../../core/di/injection_container.dart';

final quotationNotifierProvider =
    StateNotifierProvider<QuotationNotifier, QuotationState>((ref) {
      return QuotationNotifier(sl<GetQuotationsUseCase>());
    });
