import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/dashboard/presentation/provider/dashboard_notifier.dart';

final dashboardIndexProvider = StateNotifierProvider<DashboardNotifier, int>(
  (ref) => DashboardNotifier(),
);
