import 'package:flutter_riverpod/legacy.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';
import 'package:my_quotation_generator/features/products/domain/entities/product.dart';
import 'package:my_quotation_generator/features/quotation/presentation/provider/quotation_state.dart';

class QuotationNotifier extends StateNotifier<QuotationState> {
  QuotationNotifier() : super(const QuotationState());

  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  void dateReset() {
    state = const QuotationState();
  }

  void selectedProducts(ProductEntity products) {
    final updatedProducts = [...state.selectedProduct, products];
    state = state.copyWith(selectedProduct: updatedProducts);
  }

  void selectedCustomer(CustomerEntity customers) {
    final updatedCustomers = [customers];
    state = state.copyWith(selectedCustomer: updatedCustomers);
  }

  void removeCustomer(int id) {
    final updatedCustomerList = state.selectedCustomer
        .where((c) => c.id != id)
        .toList();
    state = state.copyWith(selectedCustomer: updatedCustomerList);
  }

  void removeProduct(int id) {
    final updatedProductList = state.selectedProduct
        .where((p) => p.id != id)
        .toList();
    state = state.copyWith(selectedProduct: updatedProductList);
  }

  void updateProduct(ProductEntity updated) {
    final updatedList = state.selectedProduct.map((p) {
      return p.id == updated.id ? updated : p;
    }).toList();

    state = state.copyWith(selectedProduct: updatedList);
  }
}
