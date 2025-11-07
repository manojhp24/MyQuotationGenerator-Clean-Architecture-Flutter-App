import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:my_quotation_generator/features/business/domain/repository/business_repository.dart';

class UpdateBusinessUseCase extends UseCase<DataState<int>, BusinessEntity> {
  final BusinessRepository _repository;

  UpdateBusinessUseCase(this._repository);

  @override
  Future<DataState<int>> call(BusinessEntity business) async {
    try {
      return await _repository.updateBusiness(business);
    } catch (e) {
      return DataFailed<int>(Exception('Use case failed: $e'));
    }
  }
}
