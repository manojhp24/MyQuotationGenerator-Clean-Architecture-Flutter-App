import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_text_styles.dart';

class DashboardNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const DashboardNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: AppTextStyle.navLabel(context),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Customer'),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Products',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Quotation',
        ),
      ],
    );
  }
}
