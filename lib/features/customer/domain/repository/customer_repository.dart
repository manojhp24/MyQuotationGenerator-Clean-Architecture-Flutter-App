import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';

abstract class CustomerRepository{
  Future<DataState<int>> addCustomer(CustomerEntity customer);
  Future<DataState<List<CustomerEntity>>> getCustomers();
  Future<DataState<int>> updateCustomer(CustomerEntity customer);
}