import 'package:get_it/get_it.dart';
import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/add_business_usecase.dart';
import 'package:my_quotation_generator/features/customer/data/data_sources/customer_local_database.dart';
import 'package:my_quotation_generator/features/customer/data/repository/customer_repository_impl.dart';
import 'package:my_quotation_generator/features/customer/domain/repository/customer_repository.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/add_customer_usecases.dart';

import '../../features/business/data/data_sources/business_local_database.dart';
import '../../features/business/data/repository/business_repository_impl.dart';
import '../../features/business/domain/repository/business_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Ensure database initialized
  await AppDatabase.database;

  ///Business
  // ✅ Register Data Source
  sl.registerLazySingleton<BusinessLocalDataSource>(
        () => BusinessLocalDataSource(),
  );

  // ✅ Register Repository
  sl.registerLazySingleton<BusinessRepository>(
        () => BusinessRepositoryImpl(sl<BusinessLocalDataSource>()),
  );

  // ✅ Register Usecase
  sl.registerLazySingleton(
        () => AddBusinessUseCase(sl<BusinessRepository>()),
  );

  /// Customer
  sl.registerLazySingleton<CustomerLocalDataSource>(() =>
      CustomerLocalDataSource(),);

  sl.registerLazySingleton<CustomerRepository>(() =>
      CustomerRepositoryImpl(sl<CustomerLocalDataSource>()),);


  sl.registerLazySingleton(() => AddCustomerUseCase(sl<CustomerRepository>()),);
}
