import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/business/domain/repository/business_repository.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/add_business_usecase.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/get_business_usecase.dart';
import 'package:my_quotation_generator/features/business/domain/usecases/update_business_usecase.dart';
import 'package:my_quotation_generator/features/business/presentation/provider/business_notifier.dart';
import 'package:my_quotation_generator/features/business/presentation/provider/business_state.dart';

import '../../../../core/di/injection_container.dart';



///Repository Provider
final businessRepositoryProvider = Provider<BusinessRepository>((ref) {
  return sl<BusinessRepository>();
});


/// Use Case Provider
final addBusinessUseCaseProvider = Provider<AddBusinessUseCase>((ref){
  final repository = ref.read(businessRepositoryProvider);
  return AddBusinessUseCase(repository);
});

final getBusinessUseCaseProvider = Provider<GetBusinessUseCase>((ref) {
  final repository = ref.read(businessRepositoryProvider);
  return GetBusinessUseCase(repository);
});

final updateBusinessUseCaseProvider = Provider<UpdateBusinessUseCase>((ref) {
  final repository = ref.read(businessRepositoryProvider);
  return UpdateBusinessUseCase(repository);
});

/// Notifier Provider
final businessNotifyProvider =
StateNotifierProvider<BusinessNotifier, BusinessState>((ref) {
      final addBusinessUseCase = ref.read(addBusinessUseCaseProvider);
      final getBusinessUseCase = ref.read(getBusinessUseCaseProvider);
      final updateBusinessUseCase = ref.read(updateBusinessUseCaseProvider);
      return BusinessNotifier(
          addBusinessUseCase, getBusinessUseCase, updateBusinessUseCase);
    });
