import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../model/api/error_response.dart';
import '../../shared/utils/view_utils.dart';
import 'app_exception.dart';

void handleException(
  Object e, {
  Function()? popupCallback,
  Function(DioError err)? errorCallback,
  Function(int? statusCode, ErrorResponse err)? errCallback,
}) async {
  String message = '';

  log(e.toString());
  switch (e.runtimeType) {
    case SocketException:
      message = 'Không có kết nối mạng';
      break;

    case DioError:
      {
        e as DioError;
        if (e.response?.statusCode == 401) {
          return;
        }
        var dioError = _parseDioError(e, (err) => null, (statusCode, err) => null);
        message = dioError ?? '';
        break;
      }

    case AppException:
      {
        e as AppException;
        message = e.message;
        break;
      }
    case Response:
      message = 'Đã xảy ra lỗi, vui lòng thử lại sau!';
      break;
    default:
      message = 'Đã xảy ra lỗi, vui lòng thử lại sau! \n ${e.toString()}';
  }

  if (message.isNotEmpty) {
    Future.delayed(const Duration(milliseconds: 100)).then((value) => showGlobalDialog(message: message));
  }
}

dynamic _parseDioError(
  DioError err,
  Function(DioError err)? errorCallback,
  Function(int? statusCode, ErrorResponse err)? errCallback,
) {
  log('parsing error: $err');

  try {
    if (err.error is SocketException) {
      if (err.message.contains("Failed host lookup")) {
        return "Đã xảy ra lỗi. Vui lòng thử lại sau!";
      }
      return 'Không có kết nối mạng. Vui lòng kiểm tra lại';
    }

    if (err.type == DioErrorType.connectTimeout) {
      return 'Kết nối mạng không ổn định. Vui lòng kiểm tra lại';
    }

    if (err.type == DioErrorType.cancel) {
      return err.message;
    }
    if (err.type == DioErrorType.response) {
      switch (err.response?.statusCode) {
        case 204:
          return 'Không tồn tại thông tin này trong hệ thống.\n(Mã lỗi: 204)';
        case 404:
          return 'Hệ thống đang gặp sự cố, bạn vui lòng thử lại sau.\n(Mã lỗi: 404)';
        case 500:
          return 'Hệ thống đang gặp sự cố, bạn vui lòng thử lại sau.\n(Mã lỗi: 500)';
        default:
          if ((err.response!.statusCode ?? 500) > 500) {
            return 'Hệ thống đang gặp sự cố, bạn vui lòng thử lại sau.\n(Mã lỗi: ${err.response?.statusCode})';
          }
          return err.message;
      }
    }

    var error = ErrorResponse.fromJson(err.response?.data);
    switch (err.response?.statusCode) {
      case 404:
        return error.status;
      default:
        errCallback?.call(err.response?.statusCode, error);
        errorCallback?.call(err);
    }

    if (errCallback != null) return;
    return error.status;
  } catch (e) {
    return e.toString();
  }
}
