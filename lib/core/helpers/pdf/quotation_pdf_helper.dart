import 'dart:io';

import 'package:flutter/services.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../features/customer/domain/entities/customer.dart';
import '../../../features/quotation/domain/entities/quotation_entity.dart';
import '../../../features/quotation/domain/entities/quotation_item_entity.dart';

Future<String> generateQuotationPdfFile({
  required QuotationEntity quotation,
  required CustomerEntity customer,
  required List<QuotationItemEntity> items,
  required List<BusinessEntity> business,
}) async {
  final businessInfo = business.isNotEmpty ? business.first : null;
  final fonts = await loadFonts();
  final pdf = createPdfDocument(fonts);

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(24),
      build: (_) => buildPdfContent(
        quotation: quotation,
        customer: customer,
        items: items,
        businessInfo: businessInfo,
      ),
    ),
  );

  return await savePdfFile(pdf, quotation.quoteNo);
}

Future<PdfFonts> loadFonts() async {
  final regular = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
  );
  final bold = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'),
  );
  return PdfFonts(regular: regular, bold: bold);
}

pw.Document createPdfDocument(PdfFonts fonts) {
  return pw.Document(
    theme: pw.ThemeData.withFont(
      base: fonts.regular,
      bold: fonts.bold,
    ),
  );
}

pw.Widget buildPdfContent({
  required QuotationEntity quotation,
  required CustomerEntity customer,
  required List<QuotationItemEntity> items,
  required BusinessEntity? businessInfo,
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      buildHeader(businessInfo),
      pw.SizedBox(height: 20),
      buildCustomerSection(customer),
      pw.SizedBox(height: 10),
      buildQuotationInfo(quotation),
      pw.SizedBox(height: 15),
      buildGreeting(),
      pw.SizedBox(height: 15),
      buildTableHeader(),
      ...buildItemRows(items),
      pw.Divider(),
      buildGrandTotal(quotation.grandTotal),
      pw.SizedBox(height: 30),
      buildSignatureSection(businessInfo),
      pw.Spacer(),
      buildPageNumber(),
    ],
  );
}

pw.Widget buildHeader(BusinessEntity? businessInfo) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            businessInfo?.businessName ?? "",
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text("Phone: ${businessInfo?.mobileNumber}"),
          pw.Text("Email: ${businessInfo?.email}"),
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
  );
}

pw.Widget buildCustomerSection(CustomerEntity customer) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text("To,"),
      pw.Text(customer.customerName ?? ""),
      if (customer.address1 != null) pw.Text(customer.address1!),
      if (customer.mobile != null) pw.Text("Phone: ${customer.mobile}"),
    ],
  );
}

pw.Widget buildQuotationInfo(QuotationEntity quotation) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Text("Quotation No: ${quotation.quoteNo}"),
      pw.Text(
        "Date: ${quotation.quoteDate.day}/"
            "${quotation.quoteDate.month}/"
            "${quotation.quoteDate.year}",
      ),
    ],
  );
}

pw.Widget buildGreeting() {
  return pw.Text(
    "Dear Sir/Madam,\n"
        "Thank you for your inquiry. We are pleased to quote as below.",
  );
}

pw.Widget buildTableHeader() {
  return pw.Container(
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
  );
}

List<pw.Widget> buildItemRows(List<QuotationItemEntity> items) {
  return items.asMap().entries.map((entry) {
    final index = entry.key + 1;
    final item = entry.value;

    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        children: [
          pw.Expanded(flex: 1, child: pw.Text("$index")),
          pw.Expanded(flex: 4, child: pw.Text(item.productName)),
          pw.Expanded(flex: 2, child: pw.Text(item.quantity.toString())),
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
  }).toList();
}

pw.Widget buildGrandTotal(double grandTotal) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.end,
    children: [
      pw.Text(
        "GRAND TOTAL  ₹${grandTotal.toStringAsFixed(2)}",
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    ],
  );
}

pw.Widget buildSignatureSection(BusinessEntity? businessInfo) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text("Form, ${businessInfo!.businessName}"),
      pw.SizedBox(height: 30),
      pw.Text("AUTHORIZED SIGNATURE"),
    ],
  );
}

pw.Widget buildPageNumber() {
  return pw.Align(
    alignment: pw.Alignment.centerRight,
    child: pw.Text("Page 1 of 1"),
  );
}

Future<String> savePdfFile(pw.Document pdf, String quoteNo) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File("${dir.path}/quotation_$quoteNo.pdf");
  await file.writeAsBytes(await pdf.save());
  return file.path;
}

class PdfFonts {
  final pw.Font regular;
  final pw.Font bold;

  PdfFonts({required this.regular, required this.bold});
}