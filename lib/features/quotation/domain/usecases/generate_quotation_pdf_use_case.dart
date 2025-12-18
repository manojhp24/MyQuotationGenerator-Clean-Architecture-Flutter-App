import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/quotation/domain/repository/quotation_repository.dart';

class GenerateQuotationPdfUseCase extends UseCase<DataState<String>, int> {

   final QuotationRepository _quotationRepository;

   GenerateQuotationPdfUseCase(this._quotationRepository);

  @override
  Future<DataState<String>> call(int id) {
    return _quotationRepository.generateQuotationPdf(id);
  }

}