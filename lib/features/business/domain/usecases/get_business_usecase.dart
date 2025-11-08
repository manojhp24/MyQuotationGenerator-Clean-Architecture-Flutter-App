import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:my_quotation_generator/features/business/domain/repository/business_repository.dart';

class GetBusinessUseCase
    extends UseCase<DataState<List<BusinessEntity>>, void> {
  final BusinessRepository _repository;

  GetBusinessUseCase(this._repository);

  @override
  Future<DataState<List<BusinessEntity>>> call([void params]) async {
    try {
      return await _repository.getBusiness();
    } catch (e) {
      return DataFailed<List<BusinessEntity>>(Exception('Use case failed: $e'));
    }
  }
}
