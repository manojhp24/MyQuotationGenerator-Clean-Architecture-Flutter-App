import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/core/usecases/usecase.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/customer/domain/repository/customer_repository.dart';

class GetCustomerUseCase
    extends UseCase<DataState<List<CustomerEntity>>, void> {
  final CustomerRepository _repository;

  GetCustomerUseCase(this._repository);

  @override
  Future<DataState<List<CustomerEntity>>> call([void _]) async {
    return _repository.getCustomers();
  }
}
