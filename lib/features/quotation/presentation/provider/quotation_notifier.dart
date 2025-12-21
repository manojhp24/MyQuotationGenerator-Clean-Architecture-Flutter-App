import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_entity.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_item_entity.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_state.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/usecases/create_quotation_usecase.dart';
import '../../domain/usecases/generate_quotation_pdf_use_case.dart';
import '../../domain/entities/quotation_data.dart';

class QuotationNotifier extends StateNotifier<QuotationState> {
  QuotationNotifier() : super(QuotationState.initial());



  // Date
  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  void reset() {
    state = QuotationState.initial();
  }

  // Customer
  void selectCustomer(CustomerEntity customer) {
    state = state.copyWith(selectedCustomer: customer);
  }

  void removeCustomer() {
    state = state.copyWith(selectedCustomer: null);
  }

  // Products → Quotation Items
  void addProduct(ProductEntity product, int quantity) {
    final alreadyExists =
    state.items.any((e) => e.productId == product.id);

    if (alreadyExists) return;

    final unitPrice = double.tryParse(product.price) ?? 0;
    final gstPercent = double.tryParse(product.gst) ?? 0;

    final gstAmount =
        (unitPrice * quantity) * (gstPercent / 100);

    final item = QuotationItemEntity(
      productId: product.id!,
      productName: product.productName,
      quantity: quantity,
      unitPrice: unitPrice,
      gstPercent: gstPercent,
      gstAmount: gstAmount,
      totalPrice: (unitPrice * quantity) + gstAmount,
    );

    state = state.copyWith(
      items: [...state.items, item],
    );
  }

  void removeItem(int productId) {
    state = state.copyWith(
      items: state.items.where((e) => e.productId != productId).toList(),
    );
  }

  // Save + PDF
  Future<DataState<String>> generateQuotationAndPdf() async {
    if (state.selectedCustomer == null) {
      return DataFailed(Exception("Please select a customer"));
    }

    if (state.items.isEmpty) {
      return DataFailed(Exception("Please add at least one product"));
    }

    final quotation = QuotationEntity(
      quoteNo: "QUOT-001",
      customerId: state.selectedCustomer!.id!,
      quoteDate: state.date,
      subTotal: state.subTotal,
      taxTotal: state.taxTotal,
      grandTotal: state.grandTotal, status: 'Active',
    );

    final saveResult = await sl<CreateQuotationUsecase>()(
      QuotationData(
        quotation: quotation,
        items: state.items,
      ),
    );

    if (saveResult is! DataSuccess<int>) {
      return DataFailed(Exception("Failed to save quotation"));
    }

    final quotationId = saveResult.data!;

    final pdfResult =
    await sl<GenerateQuotationPdfUseCase>()(quotationId);
    debugPrint(pdfResult.error.toString());
    if (pdfResult is! DataSuccess<String>) {
      return DataFailed(Exception("Failed to generate PDF ${pdfResult.error}"));

    }

    return DataSuccess(pdfResult.data!);
  }
}
