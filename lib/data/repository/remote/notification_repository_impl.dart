import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import '../../../model/notification/notification_category_response.dart';
import '../../../model/notification/notification_detail_response.dart';
import '../../../services/exceptions/handle_exception.dart';
import '../../../services/notification/fcm_helper.dart';
import '../interceptor/dio_base_options.dart';
import '../interceptor/interceptor.dart';
import '../local/local_data_access.dart';
import 'repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final Dio dio = getIt.get<Dio>();
  final LocalDataAccess localDataAccess = getIt.get<LocalDataAccess>();

  NotificationRepositoryImpl() {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    dio.interceptors.add(AppInterceptor().queueInterceptor(dio: dio));
    dio.options =
        DioBaseOptions(baseUrl: Environment.notificationServiceBaseUrl)
            .baseOption;
  }

  @override
  Future<ResponseWrapper<List<NotificationCategoryResponse>>> getAllCategories(
      {int pageNum = 0, int pageSize = 10000}) async {
    String accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(
        EndPoints.getAllNotificationCategories,
        queryParameters: {
          'page': pageNum,
          'pageSize': pageSize,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: (response.data as List)
              .map((e) => NotificationCategoryResponse.fromJson(e))
              .toList(),
        );
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<NotificationDetailResponse>>> getAllNotification(
      {int pageNum = 0,
      int pageSize = 20,
      String? categoryId,
      String? keyword}) async {
    String accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(
        EndPoints.getAllNotifications,
        queryParameters: {
          'page': pageNum,
          'pageSize': pageSize,
          'type': categoryId,
          'isSend': true,
          'keyword': keyword,
        }..removeWhere((key, value) => value == null),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        final pagingData =
            DefaultPagingResponse<List<NotificationDetailResponse>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((e) => NotificationDetailResponse.fromJson(e))
              .toList(),
        );

        return ResponseWrapper.success(
          data: pagingData.data ?? [],
        );
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> registerFCMToken() async {
    final fcmToken = await FCMHelper.instance.getFcmToken();
    final String accessToken = localDataAccess.getAccessToken();
    final userId = localDataAccess.getUserId();

    try {
      final response = await dio.post(
        EndPoints.registerFCMToken,
        data: {
          'userId': userId,
          'token': fcmToken,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: true,
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
