import 'package:flutter/material.dart';

import '../widgets/sections/dashboard_app_bar.dart';
import '../widgets/sections/quick_action_section.dart';
import '../widgets/sections/recent_quotation_section.dart';
import '../widgets/sections/stats_section.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ///App Bar
            DashboardAppBar(),

            /// Stats Grid
            StatsSection(),

            ///Quick Actions
            QuickActionSection(),

            RecentQuotationSection(),
          ],
        ),
      ),
    );
  }
}
