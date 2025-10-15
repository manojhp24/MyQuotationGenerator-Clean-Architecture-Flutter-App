import 'package:get_it/get_it.dart';
import 'package:my_quotation_generator/core/database/app_database.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/add_business_usecase.dart';

import '../../features/business/data/data_sources/business_local_database.dart';
import '../../features/business/data/repository/business_repository_impl.dart';
import '../../features/business/domain/repository/business_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Ensure database initialized
  await AppDatabase.database;

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
}
