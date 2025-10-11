import 'package:my_quotation_generator/core/resource/data_state.dart';
import 'package:my_quotation_generator/features/bussiness/domain/entities/business.dart';

abstract class BusinessRepository{
  Future<DataState<int>> addBusiness(BusinessEntity business);
}