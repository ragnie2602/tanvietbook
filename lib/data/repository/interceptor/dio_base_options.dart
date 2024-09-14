import 'package:dio/dio.dart';

class DioBaseOptions {
  late BaseOptions baseOption;

  DioBaseOptions({required String baseUrl}) {
    baseOption = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
      followRedirects: true,
      validateStatus: (status) {
        return status! <= 400;
      },
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
  }
}
