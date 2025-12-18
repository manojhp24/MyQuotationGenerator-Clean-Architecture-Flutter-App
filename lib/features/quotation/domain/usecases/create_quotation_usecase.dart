import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_data.dart';
import 'package:my_quotation_generator/features/quotation/domain/repository/quotation_repository.dart';

class CreateQuotationUsecase extends UseCase<DataState<int>, QuotationData> {
  final QuotationRepository _quotationRepository;

  CreateQuotationUsecase(this._quotationRepository);

  @override
  Future<DataState<int>> call(QuotationData data) {
    return _quotationRepository.createQuotation(data.quotation, data.items);
  }
}
