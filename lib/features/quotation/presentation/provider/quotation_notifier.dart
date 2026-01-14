import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_entity.dart';
import 'package:my_quotation_generator/features/quotation/domain/entities/quotation_item_entity.dart';
import 'package:my_quotation_generator/features/quotation/domain/usecases/get_quotations_use_case.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_list_ui_model.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_state.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/resource/data_state.dart';
import '../../../business/domain/usecases/get_business_usecase.dart';
import '../../domain/entities/quotation_data.dart';
import '../../domain/usecases/create_quotation_usecase.dart';
import '../../domain/usecases/generate_quotation_pdf_use_case.dart';

class QuotationNotifier extends StateNotifier<QuotationState> {
  QuotationNotifier(this.getQuotationsUseCase)
      : super(QuotationState.initial());

  final GetQuotationsUseCase getQuotationsUseCase;



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
  void resetForm() {
    state = state.copyWith(
      date: DateTime.now(),
      items: [],
      selectedCustomer: null,
      error: null,
    );
  }

  void updateSearch(String value) {
    state = state.copyWith(searchQuery: value);
  }

  List<QuotationListItem> get filteredQuotation {
    if (state.searchQuery.isEmpty) {
      return state.quotations;
    }
    final query = state.searchQuery.toLowerCase();

    return state.quotations.where((q) {
      return q.quoteNo.toLowerCase().contains(query) ||
          q.customerName.toLowerCase().contains(query);
    }).toList();
  }


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
    // Basic validations
    if (state.selectedCustomer == null) {
      return DataFailed(Exception("Please select a customer."));
    }

    if (state.items.isEmpty) {
      return DataFailed(Exception("Please add at least one product."));
    }

    final businessList = await sl<GetBusinessUseCase>()();
    if (businessList.data!.isEmpty) {
      return DataFailed("Please add business details first.");
    }

    final quotation = QuotationEntity(
      quoteNo: state.nextQuotationNo,
      customerId: state.selectedCustomer!.id!,
      quoteDate: state.date,
      subTotal: state.subTotal,
      taxTotal: state.taxTotal,
      grandTotal: state.grandTotal,
      pdfPath: '',
    );

    // Save quotation
    final saveResult = await sl<CreateQuotationUsecase>()(
      QuotationData(quotation: quotation, items: state.items),
    );

    if (saveResult is! DataSuccess<int>) {
      return DataFailed(Exception("Saving quotation failed. Try again."));
    }

    final quotationId = saveResult.data!;

    // Generate PDF
    final pdfResult = await sl<GenerateQuotationPdfUseCase>()(quotationId);

    if (pdfResult is! DataSuccess<String>) {
      final message = pdfResult.error?.toString() ?? "PDF generation failed.";
      return DataFailed(message);
    }

    return DataSuccess(pdfResult.data!);
  }


  Future<void> getQuotations() async {
    state = state.copyWith(isLoading: true);

    final result = await getQuotationsUseCase();

    if (result is DataSuccess) {
      final quotationData = result.data ?? [];

      for(final q in quotationData){
        debugPrint( 'QuoteNo: ${q.quoteNo}, Customer: ${q.customerName}, Total: ${q.grandTotal}, Pdf: ${q.pdfPath}');
      }

      state = state.copyWith(quotations: quotationData, isLoading: false);
    } else {
      state = state.copyWith(error: result.error.toString(), isLoading: false);
    }
  }


  void increaseQuantity(int productId) {
    final updatedItems = state.items.map((item) {
      if (item.productId == productId) {
        final newQty = item.quantity + 1;
        final gstAmount =
            (item.unitPrice * newQty) * (item.gstPercent / 100);

        return item.copyWith(
          quantity: newQty,
          gstAmount: gstAmount,
          totalPrice: (item.unitPrice * newQty) + gstAmount,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  void decreaseQuantity(int productId) {
    final updatedItems = state.items.map((item) {
      if (item.productId == productId && item.quantity > 1) {
        final newQty = item.quantity - 1;
        final gstAmount =
            (item.unitPrice * newQty) * (item.gstPercent / 100);

        return item.copyWith(
          quantity: newQty,
          gstAmount: gstAmount,
          totalPrice: (item.unitPrice * newQty) + gstAmount,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }



}
