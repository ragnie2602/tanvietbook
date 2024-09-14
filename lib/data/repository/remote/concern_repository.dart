import '../../../model/business/concern/concern_response/concern_response.dart';

import '../../../model/api/base_response.dart';

abstract class ConcernRepository {
  Future<ResponseWrapper<List<ConcernResponse>>> getAllConcern();

  Future<ResponseWrapper<ConcernResponse>> createConcern(
      {required ConcernResponse concernResponse});
}
