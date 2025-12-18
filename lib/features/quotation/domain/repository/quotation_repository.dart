import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_entity.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_item_entity.dart';

abstract class QuotationRepository {
  Future<DataState<int>> createQuotation(
    QuotationEntity quotation,
    List<QuotationItemEntity> items,
  );

  Future<DataState<String>> generateQuotationPdf(int quotationId);
}
