import 'package:get_it/get_it.dart';
import 'package:my_quotation_generator/core/database/app_database.dart';
// Business imports
import 'package:my_quotation_generator/features/business/data/data_sources/business_local_database.dart';
import 'package:my_quotation_generator/features/business/data/repository/business_repository_impl.dart';
import 'package:my_quotation_generator/features/business/domain/repository/business_repository.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/add_business_usecase.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/get_business_usecase.dart';
// Customer imports
import 'package:my_quotation_generator/features/customer/data/data_sources/customer_local_database.dart';
import 'package:my_quotation_generator/features/customer/data/repository/customer_repository_impl.dart';
import 'package:my_quotation_generator/features/customer/domain/repository/customer_repository.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/add_customer_usecases.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/delete_customer_usecase.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/get_customers_usecase.dart';
import 'package:my_quotation_generator/features/customer/domain/usecases/update_customer_usecase.dart';
// Product imports
import 'package:my_quotation_generator/features/products/data/data_sources/product_local_database.dart';
import 'package:my_quotation_generator/features/products/data/repository/product_repository_impl.dart';
import 'package:my_quotation_generator/features/products/domain/repository/product_repository.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/add_product_usecase.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/get_product_usecase.dart';
import 'package:my_quotation_generator/features/products/domain/usecases/update_product_usecase.dart';

// Global helpers locator instance (GetIt)
final sl = GetIt.instance;


/// Sets up all app dependencies (repositories, data sources, use cases).
/// This must run before `runApp()` in main.dart
Future<void> setupDependencies() async {
  await AppDatabase.database;

  /// BUSINESS
  sl.registerLazySingleton<BusinessLocalDataSource>(() => BusinessLocalDataSource());
  sl.registerLazySingleton<BusinessRepository>(() => BusinessRepositoryImpl(sl()));
  sl.registerLazySingleton(() => AddBusinessUseCase(sl()));
  sl.registerLazySingleton(() => GetBusinessUseCase(sl()));

  /// CUSTOMER
  sl.registerLazySingleton<CustomerLocalDataSource>(() => CustomerLocalDataSource());
  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(sl()));
  sl.registerLazySingleton(() => AddCustomerUseCase(sl()));
  sl.registerLazySingleton(() => GetCustomerUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCustomerUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCustomerUseCase(sl()));

  /// PRODUCT
  sl.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSource());
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(sl()));
  sl.registerLazySingleton(() => AddProductUseCase(sl()));
  sl.registerLazySingleton(() => GetProductUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
}
