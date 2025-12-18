import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_entity.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_item_entity.dart';

class QuotationData {
  final QuotationEntity quotation;
  final List<QuotationItemEntity> items;

  QuotationData({
    required this.quotation,
    required this.items,
  });
}
