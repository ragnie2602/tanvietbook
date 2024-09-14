// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../config/config.dart';
import '../interceptor/dio_base_options.dart';
import '../interceptor/interceptor.dart';
import '../local/local_data_access.dart';
import 'open_id_repository.dart';
import 'phonebook_repository.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import '../../../model/phonebook/suggested_contacts_response.dart';
import '../../../services/exceptions/handle_exception.dart';

import '../../../model/phonebook/saved_contact_response.dart';

class PhonebookRepositoryImpl implements PhonebookRepository {
  final Dio dio;
  final localDataAccess = getIt.get<LocalDataAccess>();
  final OpenIDRepository openIdRepository;

  String accessToken = '';

  PhonebookRepositoryImpl({required this.openIdRepository, required this.dio}) {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    dio.interceptors.add(AppInterceptor().queueInterceptor(dio: dio));
    accessToken = localDataAccess.getAccessToken();
    final BaseOptions options =
        DioBaseOptions(baseUrl: Environment.resourcesBaseUrl).baseOption;
    dio.options = options;
  }

  @override
  Future<ResponseWrapper<String>> addPhoneBook(
      {required String memberId, String? username}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.addPhonebook,
        data: {"memberId": memberId, "name": username}
          ..removeWhere((key, value) => value == null || value.isEmpty),
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        // return ResponseWrapper.success(
        //     data: MemberInfo.fromJson(response.data));
        return ResponseWrapper.success(data: '');
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<String>> deletePhoneBook({required String id}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.delete(
        EndPoints.deletePhonebook,
        queryParameters: {'Id': id},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        // return ResponseWrapper.success(
        //     data: MemberInfo.fromJson(response.data));
        return ResponseWrapper.success(data: '');
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<String>> updatePhoneBook() async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.updatePhonebook,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        // return ResponseWrapper.success(
        //     data: MemberInfo.fromJson(response.data));
        return ResponseWrapper.success(data: '');
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<SavedContactResponse>> viewPhoneBook(
      {String? keyword,
      String? orderBy,
      required int pageNum,
      int pageSize = 15}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.viewPhonebook,
        queryParameters: {
          "page": pageNum,
          "pageSize": pageSize,
          "keyword": keyword,
          "OrderBy": orderBy,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: SavedContactResponse.fromJson(response.data));
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<String>> searchPhoneBook() async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.searchPhonebook,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        // return ResponseWrapper.success(
        //     data: MemberInfo.fromJson(response.data));
        return ResponseWrapper.success(data: '');
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<SuggestedContactsResponse>> suggestPhoneBook(
      {required int pageNum, int pageSize = 15}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.suggestPhonebook,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        // return ResponseWrapper.success(
        //     data: MemberInfo.fromJson(response.data));
        return ResponseWrapper.success(
            data: SuggestedContactsResponse.fromJson(response.data));
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }
}
