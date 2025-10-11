import 'package:get_it/get_it.dart';
import 'package:my_quotation_generator/features/bussiness/data/repository/business_repository_impl.dart';
import 'package:my_quotation_generator/features/bussiness/domain/repository/business_repository.dart';
import 'package:my_quotation_generator/features/bussiness/domain/usecases/add_business_usecase.dart';
import 'package:sqflite/sqflite.dart';

import 'package:my_quotation_generator/features/bussiness/data/data_sources/business_local_database.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final db = await BusinessLocalDb.database;
  sl.registerLazySingleton<Database>(() => db);

  sl.registerLazySingleton<BusinessRepository>(
    () => BusinessRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => AddBusinessUseCase(sl()));
}
