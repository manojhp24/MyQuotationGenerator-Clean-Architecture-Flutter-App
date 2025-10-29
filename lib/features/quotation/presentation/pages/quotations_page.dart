import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_text_styles.dart';

class QuotationsPage extends StatelessWidget {
  const QuotationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotations List"),
      ),
      body: Center(child: Text("Quotations")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.note_add_rounded),
      ),
    );
  }
}
