import 'package:my_quotation_generator/features/business/data/data_sources/business_local_database.dart';
import 'package:my_quotation_generator/features/business/data/models/business.dart';
import 'package:my_quotation_generator/features/customer/data/data_sources/customer_local_database.dart';

import '../../../../core/helpers/pdf/quotation_pdf_helper.dart';
import '../../../../core/resource/data_state.dart';
import '../../../customer/data/models/customer.dart';
import '../../domain/entities/quotation_entity.dart';
import '../../domain/entities/quotation_item_entity.dart';
import '../../domain/repository/quotation_repository.dart';
import '../data_sources/quotation_local_data_source.dart';
import '../models/quotation_item_model.dart';
import '../models/quotation_model.dart';

class QuotationRepositoryImpl implements QuotationRepository {
  final QuotationLocalDataSource _quotationLocalDataSource;
  final CustomerLocalDataSource _customerLocalDataSource;
  final BusinessLocalDataSource _businessLocalDataSource;

  QuotationRepositoryImpl(
    this._quotationLocalDataSource,
    this._customerLocalDataSource, this._businessLocalDataSource,
  );

  @override
  Future<DataState<int>> createQuotation(
    QuotationEntity quotation,
    List<QuotationItemEntity> items,
  ) async {
    try {
      final quotationModel = QuotationModel.fromEntity(quotation);
      final quotationId = await _quotationLocalDataSource.insertQuotation(
        (quotationModel.toMap()),
      );

      for (final item in items) {
        final itemWithQuotationId = QuotationItemEntity(
          id: item.id,
          productId: item.productId,
          productName: item.productName,
          quantity: item.quantity,
          unitPrice: item.unitPrice,
          gstPercent: item.gstPercent,
          gstAmount: item.gstAmount,
          totalPrice: item.totalPrice,
          quotationId: quotationId,
        );

        final itemModel = QuotationItemModel.fromEntity(itemWithQuotationId);

        await _quotationLocalDataSource.insertQuotationItem(itemModel.toMap());
      }

      return DataSuccess(quotationId);
    } catch (e) {
      return DataFailed(Exception('Failed to create quotation: $e'));
    }
  }

  @override
  Future<DataState<String>> generateQuotationPdf(int quotationId) async {
    try {
      final quotationMap = await _quotationLocalDataSource.getQuotation(
        quotationId,
      );
      final quotation = QuotationModel.fromMap(quotationMap).toEntity();

      final itemsMap = await _quotationLocalDataSource.getQuotationItems(
        quotationId,
      );
      final items = itemsMap.map((e) => QuotationItemModel.fromMap(e)).toList();

      final customerMap = await _customerLocalDataSource.getCustomerById(
        quotation.customerId,
      );
      final customer = CustomerModel.fromMap(customerMap).toEntity();

      final  businessList = await _businessLocalDataSource.getBusiness();
      final businesses = businessList
          .map((map) => BusinessModel.fromMap(map).toEntity())
          .toList();


      final path = await generateQuotationPdfFile(
        customer: customer,
        items: items,
        quotation: quotation,
        business: businesses
      );
      return DataSuccess(path);
    } catch (e) {
      return DataFailed(Exception("Failed to generate PDF: ${e.toString()}"));
    }
  }
}
