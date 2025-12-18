import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../features/customer/domain/entities/customer.dart';
import '../../../features/quotation/domain/entities/quotation_entity.dart';
import '../../../features/quotation/domain/entities/quotation_item_entity.dart';

Future<String> generateQuotationPdfFile({
  required QuotationEntity quotation,
  required CustomerEntity customer,
  required List<QuotationItemEntity> items,
}) async {
  final regularFont = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
  );
  final boldFont = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'),
  );

  final pdf = pw.Document(
    theme: pw.ThemeData.withFont(
      base: regularFont,
      bold: boldFont,
    ),
  );

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(24),
      build: (_) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            /// HEADER
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "GOWRI EVENTS",
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text("Phone: 6361337631"),
                    pw.Text("Email: info@gowrievents.com"),
                  ],
                ),
                pw.Text(
                  "QUOTATION",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            /// CUSTOMER
            pw.Text("To,"),
            pw.Text(customer.customerName ?? ""),
            if (customer.address1 != null) pw.Text(customer.address1!),
            if (customer.mobile != null) pw.Text("Phone: ${customer.mobile}"),

            pw.SizedBox(height: 10),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Quotation No: ${quotation.quoteNo}"),
                pw.Text(
                  "Date: ${quotation.quoteDate.day}/"
                      "${quotation.quoteDate.month}/"
                      "${quotation.quoteDate.year}",
                ),
              ],
            ),

            pw.SizedBox(height: 15),

            pw.Text(
              "Dear Sir/Madam,\n"
                  "Thank you for your inquiry. We are pleased to quote as below.",
            ),

            pw.SizedBox(height: 15),

            /// TABLE HEADER (same as dummy)
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(vertical: 6),
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  top: pw.BorderSide(),
                  bottom: pw.BorderSide(),
                ),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(flex: 1, child: pw.Text("#")),
                  pw.Expanded(flex: 4, child: pw.Text("DESCRIPTION")),
                  pw.Expanded(flex: 2, child: pw.Text("QTY")),
                  pw.Expanded(flex: 2, child: pw.Text("PRICE")),
                  pw.Expanded(flex: 2, child: pw.Text("TOTAL")),
                ],
              ),
            ),

            /// ITEMS (row-based, not pw.Table)
            ...items.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final item = entry.value;

              return pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 6),
                child: pw.Row(
                  children: [
                    pw.Expanded(flex: 1, child: pw.Text("$index")),
                    pw.Expanded(
                      flex: 4,
                      child: pw.Text(item.productName),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Text(item.quantity.toString()),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Text("₹${item.unitPrice.toStringAsFixed(2)}"),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Text("₹${item.totalPrice.toStringAsFixed(2)}"),
                    ),
                  ],
                ),
              );
            }),

            pw.Divider(),

            /// GRAND TOTAL
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  "GRAND TOTAL  ₹${quotation.grandTotal.toStringAsFixed(2)}",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 30),

            pw.Text("For, GOWRI EVENTS"),
            pw.SizedBox(height: 30),
            pw.Text("AUTHORIZED SIGNATURE"),

            pw.Spacer(),

            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text("Page 1 of 1"),
            ),
          ],
        );
      },
    ),
  );

  final dir = await getApplicationDocumentsDirectory();
  final file =
  File("${dir.path}/quotation_${quotation.quoteNo}.pdf");

  await file.writeAsBytes(await pdf.save());
  return file.path;
}
