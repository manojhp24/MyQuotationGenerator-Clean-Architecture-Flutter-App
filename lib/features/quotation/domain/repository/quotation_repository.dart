import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_entity.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_item_entity.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_list_ui_model.dart';

abstract class QuotationRepository {
  Future<DataState<int>> createQuotation(
    QuotationEntity quotation,
    List<QuotationItemEntity> items,
  );

  Future<DataState<String>> generateQuotationPdf(int quotationId);

  Future<DataState<List<QuotationListItem>>> getQuotationList();
}
