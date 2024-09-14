import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import '../../../services/exceptions/handle_exception.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../view/login_screens/login_screen.dart';
import '../local/local_data_access.dart';
import '../remote/repository.dart';

class AppInterceptor {
  final LocalDataAccess localDataAccess = getIt.get<LocalDataAccess>();
  final OpenIDRepository openIdRepository = getIt.get<OpenIDRepository>();

  QueuedInterceptorsWrapper queueInterceptor({required Dio dio}) => QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          handler.next(options);
          // check access token is retrieved?
        },
        onResponse: (response, handler) {
          log('onResponse: ${response.requestOptions.path} \n  $response');
          handler.next(response);
        },
        onError: (error, handler) async {
          log('onError: $error \n');
          if (error.response?.statusCode == 401) {
            final response = await openIdRepository.refreshToken();
            if (response.status == ResponseStatus.success) {
              final opts = Options(
                method: error.requestOptions.method,
                headers: {
                  'Authorization': 'Bearer ${localDataAccess.getAccessToken()}',
                  'Retry-Count': 1,
                },
              );
              return handler.resolve(await dio.request(error.requestOptions.path,
                  options: opts,
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters));
            } else {
              showGlobalDialog(
                  message: 'Phiên đăng nhập của bạn đã hết hạn. Vui lòng đăng nhập lại để tiếp tục sử dụng',
                  callbackWhenDismiss: (value) {
                    ViewUtils.getRootNavigatorKey().currentState?.pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                  });
              localDataAccess.clearAccessToken();
              localDataAccess.clearRefreshToken();
              localDataAccess.setIsRegisterFCMToken(false);
              return handler.next(error);
            }
          } else if (error.response?.statusCode == 404) {
            handler.reject(error);
          } else {
            if (error.response?.statusCode != 404) {
              handleException(error);
            }
          }
        },
      );
}
