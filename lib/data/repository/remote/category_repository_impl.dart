import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import '../../../model/business/category/business_category_response.dart';
import '../../../model/business/category/category_list_item.dart';
import '../../../services/exceptions/handle_exception.dart';
import '../../constants.dart';
import '../local/local_data_access.dart';
import 'category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final LocalDataAccess _localDataAccess = getIt.get<LocalDataAccess>();
  String accessToken = '';
  final Dio dio;

  CategoryRepositoryImpl({required this.dio}) {
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
  Future<ResponseWrapper<BusinessCategoryResponse>> createCategory(
      {required BusinessCategoryResponse category}) async {
    accessToken = _localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.createBusinessCategory,
        data: category.toJson()..removeWhere((key, value) => value == null),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: BusinessCategoryResponse.fromJson(response.data));
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> updateCategory(
      {required Map<String, dynamic> data}) async {
    accessToken = _localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.updateBusinessCategory,
        data: data..removeWhere((key, value) => value == null),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> deleteCategory(String id) async {
    accessToken = _localDataAccess.getAccessToken();
    try {
      final response = await dio.delete(
        '${EndPoints.deleteCategory}/$id',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> swapCategory(List<String> idList) async {
    accessToken = _localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.swapCategory,
        data: {
          "memberId": _localDataAccess.getUserId(),
          "idList": idList,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<BusinessCategoryGetAllResponse>>
      getAllBusinessCategory(
          {required String subTabId, String? username}) async {
    accessToken = _localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.getAllBusinessCategory,
        queryParameters: {
          "subTabId": subTabId,
          "username": username ?? _localDataAccess.getUserName(),
          "page": 1,
          "pageSize": 999999
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: BusinessCategoryGetAllResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<BusinessCategoryGetAllResponse>>
      getAllBusinessCategoryByType(
          {required String subTabId,
          String? username,
          required int page,
          required int pageSize,
          String type = CategoryType.all}) async {
    accessToken = _localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.getAllBusinessCategoryByType,
        queryParameters: {
          "subTabId": subTabId,
          "username": username ?? _localDataAccess.getUserName(),
          "page": page,
          "pageSize": pageSize,
          "type": type
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: BusinessCategoryGetAllResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<CategoryListItem>>> getUninitializedList(
      {required String? subTabId}) async {
    accessToken = _localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.getUninitializedList,
        queryParameters: {
          "subTabId": subTabId,
          "username": _localDataAccess.getUserName(),
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List<CategoryListItem>.from(
            response.data.map(
              (e) => CategoryListItem.fromJson(e),
            ),
          ),
        );
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }
}
