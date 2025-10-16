import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/business/domain/repository/business_repository.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/add_business_usecase.dart';
import 'package:my_quotation_generator/features/business/presentation/provider/business_notifier.dart';
import 'package:my_quotation_generator/features/business/presentation/provider/business_state.dart';

import '../../../../core/di/injection_container.dart';
import '../../data/repository/business_repository_impl.dart';


///Repository Provider
final businessRepositoryProvider = Provider<BusinessRepository>((ref) {
  return sl<BusinessRepositoryImpl>();
});


/// Use Case Provider
final addBusinessUseCaseProvider = Provider<AddBusinessUseCase>((ref){
  final repository = ref.read(businessRepositoryProvider);
  return AddBusinessUseCase(repository);
});


/// Notifier Provider
final businessNotifyProvider =
StateNotifierProvider<BusinessNotifier, BusinessState>(
      (ref) => BusinessNotifier(sl<AddBusinessUseCase>()),
);
