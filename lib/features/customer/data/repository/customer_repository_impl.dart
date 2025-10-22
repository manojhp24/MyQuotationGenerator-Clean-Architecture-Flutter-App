import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/customer/data/data_sources/customer_local_database.dart';
import 'package:my_quotation_generator/features/customer/data/models/customer.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/customer/domain/repository/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository{
  final CustomerLocalDataSource localDataSource;

  CustomerRepositoryImpl(this.localDataSource);

  @override
  Future<DataState<int>> addCustomer(CustomerEntity customer) async {
    try {
      final model = CustomerModel(
        customerName: customer.customerName,
        mobile: customer.mobile,
        email: customer.email,
        address1: customer.address1,
        address2: customer.address2,
        state: customer.state,
        gstIn: customer.gstIn,
        otherInfo: customer.otherInfo,
        shippingAddress: customer.shippingAddress,
      );

      final id = await localDataSource.addCustomer(model.toMap());
      return DataSuccess<int>(id);
    } catch (e) {
      return DataFailed<int>(Exception("Forced failure test"));
    }
  }

}