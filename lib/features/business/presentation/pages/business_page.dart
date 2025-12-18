import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Business Details"),
        ),
        body: const Center(
          child: Text("Business Page"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push("/add-business"),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
