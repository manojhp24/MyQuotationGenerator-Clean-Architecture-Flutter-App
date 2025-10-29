import 'package:flutter/material.dart';

import '../../../domain/entities/customer.dart';
import '../card/customer_card.dart';

class CustomerListView extends StatelessWidget {
  final List<CustomerEntity> customers;

  const CustomerListView({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: customers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final customer = customers[index];
        return CustomerCard(customer: customer);
      },
    );
  }
}
