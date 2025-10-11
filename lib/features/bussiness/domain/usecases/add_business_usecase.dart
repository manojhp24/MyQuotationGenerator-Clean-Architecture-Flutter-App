import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/bussiness/domain/entities/business.dart';
import 'package:my_quotation_generator/features/bussiness/domain/repository/business_repository.dart';

import '../../../../core/usecases/usecase.dart';

class AddBusinessUseCase extends UseCase<DataState<int>, BusinessEntity> {
  final BusinessRepository repository;
  AddBusinessUseCase(this.repository);

  @override
  Future<DataState<int>> call(BusinessEntity business) {
    return repository.addBusiness(business);
  }
}
