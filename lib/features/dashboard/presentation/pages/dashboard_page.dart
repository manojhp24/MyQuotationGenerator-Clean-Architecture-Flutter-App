import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/sections/dashboard_app_bar.dart';
import '../widgets/sections/quick_action_section.dart';
import '../widgets/sections/recent_quotation_section.dart';
import '../widgets/sections/stats_section.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: const [
            /// App Bar
            DashboardAppBar(),

            /// Stats Grid
            StatsSection(),

            /// Quick Actions
            QuickActionSection(),

            /// Recent Quotations
            RecentQuotationSection(),

            /// Extra spacing at bottom
            SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}