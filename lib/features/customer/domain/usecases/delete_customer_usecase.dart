import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/customer/domain/repository/customer_repository.dart';

class DeleteCustomerUseCase extends UseCase<DataState<int>, int> {
  final CustomerRepository _repository;

  DeleteCustomerUseCase(this._repository);

  @override
  Future<DataState<int>> call(int? customerId) {
    if (customerId == null) {
      return Future.value(DataFailed('Customer Id is required'));
    }
    return _repository.deleteCustomer(customerId);
  }
}
