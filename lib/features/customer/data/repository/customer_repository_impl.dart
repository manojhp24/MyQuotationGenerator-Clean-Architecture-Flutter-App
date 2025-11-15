import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/customer/data/data_sources/customer_local_database.dart';
import 'package:my_quotation_generator/features/customer/data/models/customer.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/customer/domain/repository/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository{
  final CustomerLocalDataSource localDataSource;

  CustomerRepositoryImpl(this.localDataSource);

  /// Adding Customer
  @override
  Future<DataState<int>> addCustomer(CustomerEntity customer) async {
    try {
      final model = CustomerModel.fromEntity(customer);

      final id = await localDataSource.addCustomer(model.toMap());
      return DataSuccess<int>(id);
    } catch (e) {
      print(e.toString());
      return DataFailed<int>(e is Exception ? e : Exception(e.toString()));

    }
  }

  /// Fetching Customer
  @override
  Future<DataState<List<CustomerEntity>>> getCustomers() async {
    try {
      final List<Map<String, dynamic>> data = await localDataSource
          .getCustomers();

      final customers = data
          .map((e) => CustomerModel.fromMap(e).toEntity())
          .toList();
      return DataSuccess(customers);
    } catch (e) {
      return DataFailed(Exception("Failed to fetch customers: $e"));
    }
  }

  /// Updating Customer
  @override
  Future<DataState<int>> updateCustomer(CustomerEntity customer) async {
    try {
      if (customer.id == null) {
        return DataFailed<int>(Exception("Customer id required for update"));
      }

      final model = CustomerModel.fromEntity(customer);

      final rowsAffected = await localDataSource.updateCustomer(
          model.toMap(), customer.id!);
      if (rowsAffected > 0) {
        return DataSuccess<int>(rowsAffected);
      } else {
        return DataFailed<int>(Exception("No customer found to update"));
      }
    } catch (e) {
      return DataFailed<int>(Exception("Failed to update customer: $e"));
    }
  }

  /// Delete Customer
  @override
  Future<DataState<int>> deleteCustomer(int id) async {
    try {
      if (id <= 0) {
        return DataFailed<int>(Exception("Invalid customer id for deletion"));
      }

      final rowsDeleted = await localDataSource.deleteCustomer(id);

      if (rowsDeleted > 0) {
        return DataSuccess<int>(rowsDeleted);
      } else {
        return DataFailed(Exception('No Customer found to delete'));
      }
    } catch (e) {
      return DataFailed(Exception("Failed to delete customer"));
    }
  }
}