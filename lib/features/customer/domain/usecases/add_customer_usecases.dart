import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/customer/domain/repository/customer_repository.dart';

class AddCustomerUseCase extends UseCase<DataState<int>, CustomerEntity> {
  final CustomerRepository _repository;

  AddCustomerUseCase(this._repository);

  @override
  Future<DataState<int>> call(CustomerEntity customer) {
    return _repository.addCustomer(customer);
  }
}
