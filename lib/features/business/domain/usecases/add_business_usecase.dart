import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:my_quotation_generator/features/business/domain/repository/business_repository.dart';

import '../../../../core/usecases/usecase.dart';

class AddBusinessUseCase extends UseCase<DataState<int>, BusinessEntity> {
  final BusinessRepository _repository;
  AddBusinessUseCase(this._repository);

  @override
  Future<DataState<int>> call(BusinessEntity business) {
    return _repository.addBusiness(business);
  }
}
