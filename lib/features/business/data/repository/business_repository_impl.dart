import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/business/data/models/business.dart';
import 'package:my_quotation_generator/features/business/domain/entities/business.dart';
import 'package:my_quotation_generator/features/business/domain/repository/business_repository.dart';

import '../data_sources/business_local_database.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessLocalDataSource localDataSource;

  BusinessRepositoryImpl(this.localDataSource);

  @override
  Future<DataState<int>> addBusiness(BusinessEntity business) async {
    try {
      final model = BusinessModel(
        businessName: business.businessName,
        contactName: business.contactName,
        mobileNumber: business.mobileNumber,
        email: business.email,
        address1: business.address1,
        address2: business.address2,
        otherInfo: business.otherInfo,
        gstIn: business.gstIn,
        state: business.state,
        businessCategory: business.businessCategory,
        accountName: business.accountName,
        accountNumber: business.accountNumber,
        bankName: business.bankName,
        upiId: business.upiId,
      );

      final id = await localDataSource.addBusiness(model.toMap());
      return DataSuccess(id);
    } catch (e) {
      return DataFailed(Exception('Failed to add business: $e'));
    }
  }

  @override
  Future<DataState<int>> updateBusiness(BusinessEntity business) async {
    if (business.id == null) {
      return DataFailed<int>(Exception("Business id required for update"));
    }

    try {
      final model = BusinessModel.fromEntity(business);
      final result = await localDataSource.updateBusiness(
        model.toMap(),
        business.id!,
      );
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(Exception('Repository error: Database error'));
    }
  }

  @override
  Future<DataState<List<BusinessEntity>>> getBusiness() async {
    try {
      final List<Map<String, dynamic>> data = await localDataSource
          .getBusiness();

      final business = data
          .map((e) => BusinessModel.fromMap(e).toEntity())
          .toList();

      return DataSuccess(business);
    } catch (e) {
      return DataFailed(Exception("Failed to get business data $e"));
    }
  }
}
