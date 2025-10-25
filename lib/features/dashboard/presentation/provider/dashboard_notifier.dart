import 'package:flutter_riverpod/legacy.dart';

class DashboardNotifier extends StateNotifier<int> {
  DashboardNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}
