import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_entity.dart';
import 'package:my_quotation_generator/features/quotation/domain/repository/quotation_repository.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_list_ui_model.dart';

class GetQuotationsUseCase
    extends UseCase<DataState<List<QuotationListItem>>, void> {
  final QuotationRepository _quotationRepository;

  GetQuotationsUseCase(this._quotationRepository);

  @override
  Future<DataState<List<QuotationListItem>>> call([void _]) {
    return _quotationRepository.getQuotationList();
  }
}
