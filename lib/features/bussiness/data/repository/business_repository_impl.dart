import 'package:dio/dio.dart';
import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/bussiness/data/models/business.dart';
import 'package:my_quotation_generator/features/bussiness/domain/entities/business.dart';
import 'package:my_quotation_generator/features/bussiness/domain/repository/business_repository.dart';
import 'package:sqflite/sqflite.dart';


// Repository: insert, fetch, update business data in SQLite
class BusinessRepositoryImpl implements BusinessRepository {

  final Database db;

  BusinessRepositoryImpl(this.db);

  @override
  Future<DataState<int>> addBusiness(BusinessEntity business) async {
    try {
      final model = BusinessModel(
          businessName: business.businessName,
          mobileNumber: business.mobileNumber,
          contactName: business.contactName,
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
          upiId: business.upiId
      );

      final id = await db.insert("business", model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,);

      return DataSuccess(id);
    } catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: 'local-db'),
          error: e.toString(),
        ),
      );
    }
  }

}