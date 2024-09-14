import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../local/local_data_access.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import '../../../model/business/concern/concern_response/concern_response.dart';

import '../../../config/config.dart';
import '../../../services/exceptions/handle_exception.dart';
import 'repository.dart';

class ConcernRepositoryImpl implements ConcernRepository {
  final LocalDataAccess _localDataAccess = getIt.get<LocalDataAccess>();
  String accessToken = '';
  final Dio dio;

  ConcernRepositoryImpl({required this.dio}) {
    final String accessToken = _localDataAccess.getAccessToken();

    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    final BaseOptions options = BaseOptions(
      baseUrl: Environment.resourcesBaseUrl,
      sendTimeout: 30000,
      receiveTimeout: 30000,
      followRedirects: false,
      validateStatus: (status) {
        return status! <= 400;
      },
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": 'Bearer $accessToken'
      },
    );
    dio.options = options;
  }

  @override
  Future<ResponseWrapper<ConcernResponse>> createConcern(
      {required ConcernResponse concernResponse}) async {
    accessToken = _localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.createConcern,
        data: concernResponse.toJson()
          ..removeWhere((key, value) =>
              value == null || (value is String && value.isEmpty)),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: ConcernResponse.fromJson(response.data));
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<List<ConcernResponse>>> getAllConcern() async {
    accessToken = _localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.concernGetAll,
        data: {
          "page": 1,
          "pageSize": 999999,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: ConcernResponsePaging.fromJson(response.data).data ?? []);
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }
}
