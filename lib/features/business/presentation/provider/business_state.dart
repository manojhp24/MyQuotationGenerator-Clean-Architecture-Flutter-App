
import '../../domain/entities/business.dart';

class BusinessState {
  final bool isLoading;
  final List<BusinessEntity> businesses;
  final String? error;

  BusinessState({
    this.isLoading = false,
    this.businesses = const [],
    this.error,
  });

  BusinessState copyWith({
    bool? isLoading,
    List<BusinessEntity>? business,
    String? error,
  }) {
    return BusinessState(
      isLoading: isLoading ?? this.isLoading,
      businesses: businesses,
      error: error,
    );
  }
}
