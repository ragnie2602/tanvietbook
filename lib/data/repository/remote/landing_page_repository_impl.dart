import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../local/local_data_access.dart';
import '../../../di/di.dart';
import '../../../model/api/base_response.dart';
import '../../../model/business/landing_page/landing_page_response.dart';

import '../../../config/config.dart';
import '../../../model/business/landing_page/landing_page_button_response.dart';
import '../../../model/business/landing_page/landing_page_call_action_response.dart';
import '../../../model/business/landing_page/landing_page_content_response.dart';
import '../../../model/business/landing_page/landing_page_image_response.dart';
import '../../../model/business/landing_page/landing_page_link_response.dart';
import '../../../services/exceptions/handle_exception.dart';
import 'landing_page_repository.dart';

class LandingPageRepositoryImpl implements LandingPageRepository {
  final LocalDataAccess _localDataAccess = getIt.get<LocalDataAccess>();
  String accessToken = '';
  final Dio dio;

  LandingPageRepositoryImpl({required this.dio}) {
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
  Future<ResponseWrapper<LandingPageResponse>> createLandingPageItem(
      Map<String, dynamic> data) async {
    try {
      final response = await dio.post(EndPoints.createLandingPage, data: data);
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: LandingPageResponse.fromJson(response.data));
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> deleteLandingPage(
      {required String landingPageId}) async {
    try {
      final response =
          await dio.delete("${EndPoints.deleteLandingPage}/$landingPageId");
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: true,
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<List<LandingPageResponse>>> getAll(
      String cateId) async {
    try {
      final response = await dio.get(EndPoints.getLandingPage,
          queryParameters: {
            "CateId": cateId,
            "username": _localDataAccess.getUserName()
          });
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List<LandingPageResponse>.from(
            response.data.map((e) => LandingPageResponse.fromJson(e)),
          ),
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> swapItem(
      {required List<String> idList, required String cateId}) async {
    try {
      final response = await dio.post(EndPoints.swapLandingPage,
          data: {"cateId": cateId, "idList": idList});
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: true,
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<List<LandingPageImageResponse>>> addImage(
      {required String landingId, required List<String> value}) async {
    try {
      final response = await dio.post(EndPoints.addImageList,
          data: {"landingID": landingId, "value": value});
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List<LandingPageImageResponse>.from(
              response.data.map((e) => LandingPageImageResponse.fromJson(e))),
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<List<LandingPageImageResponse>>> getImage(
      {required String landingId}) async {
    try {
      final response = await dio.get(EndPoints.getImageList,
          queryParameters: {"LandingId": landingId});
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List<LandingPageImageResponse>.from(
              response.data.map((e) => LandingPageImageResponse.fromJson(e))),
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<LandingPageContentResponse>> addContent(
      {required String landingId,
      required String value,
      String? contentId}) async {
    try {
      final response = await dio.post(EndPoints.addContent,
          data: {"id": contentId, "landingID": landingId, "value": value}
            ..removeWhere((key, value) => value == null || value == ''));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: LandingPageContentResponse.fromJson(response.data),
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<LandingPageContentResponse>> getContent(
      {required String landingId}) async {
    try {
      final response = await dio.get(EndPoints.getContent, queryParameters: {
        "LandingId": landingId,
        "username": _localDataAccess.getUserName()
      });
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: LandingPageContentResponse.fromJson(response.data),
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<LandingPageCallActionResponse>> addCallAction(
      {required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(EndPoints.addAction, data: data);
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: LandingPageCallActionResponse.fromJson(response.data),
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<LandingPageLinkResponse>> addLink(
      {required String landingId,
      required String value,
      required String title,
      String? linkId}) async {
    try {
      final response = await dio.post(EndPoints.addConnective,
          data: {
            "id": linkId,
            "landingID": landingId,
            "value": value,
            "title": title
          }..removeWhere((key, value) => value == null || value == ''));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: LandingPageLinkResponse.fromJson(response.data),
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<LandingPageCallActionResponse>> getCallAction(
      {required String landingId}) async {
    try {
      final response = await dio
          .get(EndPoints.getAction, queryParameters: {"LandingId": landingId});
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: LandingPageCallActionResponse.fromJson(response.data),
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<LandingPageLinkResponse>> getLink(
      {required String landingId}) async {
    try {
      final response = await dio.get(EndPoints.getConnective,
          queryParameters: {"LandingId": landingId});
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List.from(response.data)
              .map((e) => e != null ? LandingPageLinkResponse.fromJson(e) : e)
              .toList()[0],
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<LandingPageButtonResponse>> addButton(
      {required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(EndPoints.addButton, data: data);
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: LandingPageButtonResponse.fromJson(response.data),
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<LandingPageButtonResponse>> getButton(
      {required String landingId}) async {
    try {
      final response = await dio
          .get(EndPoints.getButtons, queryParameters: {"LandingId": landingId});
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List.from(response.data)
              .map((e) => e != null ? LandingPageButtonResponse.fromJson(e) : e)
              .toList()[0],
        );
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }
}
