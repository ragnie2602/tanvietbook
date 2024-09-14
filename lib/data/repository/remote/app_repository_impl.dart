import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../model/business/detail/business_detail_response.dart';
import '../../../model/business/sub_tab/business_sub_tab_response.dart';

import '../../../config/config.dart';
import '../../../model/api/base_response.dart';
import '../../../model/business/business_get_all_response/business_get_all_response.dart';
import '../../../model/business/overall/business_overall_response.dart';
import '../../../model/business/product/product_detail_response.dart';
import '../../../model/business/product/product_get_all_response.dart';
import '../../../model/member/additional_path_response.dart';
import '../../../model/member/base_info_response.dart';
import '../../../model/member/contact_default_type_response.dart';
import '../../../model/member/contact_member_info.dart';
import '../../../model/member/member_detail_info.dart';
import '../../../model/member/organization_info_response.dart';
import '../../../services/exceptions/handle_exception.dart';
import '../interceptor/dio_base_options.dart';
import '../interceptor/interceptor.dart';
import '../local/local_data_access.dart';
import 'repository.dart';

class AppRepositoryImpl implements AppRepository {
  final Dio dio;
  final LocalDataAccess localDataAccess;
  final OpenIDRepository openIdRepository;
  final AppInterceptor appInterceptor;

  String accessToken = '';

  AppRepositoryImpl({
    required this.appInterceptor,
    required this.openIdRepository,
    required this.localDataAccess,
    required this.dio,
  }) {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    dio.interceptors.add(appInterceptor.queueInterceptor(dio: dio));
    dio.options =
        DioBaseOptions(baseUrl: Environment.resourcesBaseUrl).baseOption;
  }

  @override
  Future<ResponseWrapper<bool>> updateMemberBaseInfo(
      {required BaseInfoResponse baseInfo}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(EndPoints.updateMemberBaseInfo,
          data: baseInfo.toJson()
            ..removeWhere((key, value) =>
                value == null || (value is! bool && value.isEmpty))
            ..addAll({'memberId': localDataAccess.getUserId()}),
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<MemberInfo>> getMemberInfoByUsername(
      {required String username}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(EndPoints.getMemberInfoByUsername,
          queryParameters: {"Username": username},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: MemberInfo.fromJson(response.data));
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  // @override
  // Future<BasicInfo?>? getMemberBasicInfo() async {
  //   final String accessToken = localDataAccess.getAccessToken();
  //   final String username = localDataAccess.getUserName();
  //
  //   final response = await dio.get(
  //     EndPoints.getMemberBasicInfo,
  //     queryParameters: {"username": username},
  //     options: Options(
  //       headers: {'Authorization': 'Bearer $accessToken'},
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     return BasicInfo.fromJson(response.data);
  //   } else {
  //     return null;
  //   }
  // }

  @override
  Future<ResponseWrapper<MemberInfo>> getMemberOwnInfo() async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(EndPoints.getMemberOwnInfo,
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: MemberInfo.fromJson(response.data));
      } else {
        return ResponseWrapper.error(message: '');
      }
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: e.toString());
    }
  }

  @override
  Future<ResponseWrapper<bool>> updateMemberInfo(
      {MemberInfo? memberInfo}) async {
    accessToken = localDataAccess.getAccessToken();
    final data = memberInfo?.toJson()
      // cause logo can be null when user clear their logo
      ?..removeWhere((key, value) =>
          key != 'logo' && (value == null || value is! bool && value.isEmpty));

    try {
      final response = await dio.patch(EndPoints.updateMemberInfo,
          data: data,
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<MemberInfo>> getMemberBaseInfoViewOwn() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<List<ContactDefaultTypeResponse>>>
      getMemberContactDefaultList({required bool isType, String? type}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.getContactDefaultTypeInfo,
        queryParameters: {
          "IsType": isType,
          "type": type,
        }..removeWhere((key, value) => value == null),
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: List.from((response.data as List)
                .map((e) => ContactDefaultTypeResponse.fromJson(e))));
      }
      return ResponseWrapper.error(message: '');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<List<ContactInfoResponse>>> getMemberContactInfo(
      {required String contactBaseId}) async {
    accessToken = localDataAccess.getAccessToken();
    log(accessToken);
    try {
      final response = await dio.get(EndPoints.getContactInfo,
          queryParameters: {
            'ContactBaseId': contactBaseId,
          },
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: List.from((response.data as List)
                .map((e) => ContactInfoResponse.fromJson(e))));
      }
      return ResponseWrapper.error(
          message: '', statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<List<ContactInfoResponse>>>
      getMemberContactInfoViewOwn({required String contactBaseId}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(EndPoints.getContactInfoViewOwn,
          queryParameters: {
            'ContactBaseId': contactBaseId,
          },
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: List.from((response.data as List)
                .map((e) => ContactInfoResponse.fromJson(e))));
      }
      return ResponseWrapper.error(
          message: '', statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<bool>> addMemberContactInfo(
      {required ContactInfoResponse contactInfoResponse}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(EndPoints.addContactInfo,
          data: contactInfoResponse.toJson()
            ..removeWhere((key, value) =>
                value == null || value is! bool && value.isEmpty),
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<bool>> deleteMemberContactInfo(
      {required String contactId, required String contactBaseId}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.delete(EndPoints.deleteContactInfo,
          queryParameters: {"Id": contactId, "ContactBaseId": contactBaseId},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  // organization
  @override
  Future<ResponseWrapper<OrganizationInfoResponse>> getMemberOrganizationInfo(
      {required String organizationBaseId}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.getOrganizationInfo,
        queryParameters: {
          'OrganizationBaseId': organizationBaseId,
        },
        // options: Options(
        //   headers: {'Authorization': 'Bearer $accessToken'},
        // )
      );
      log('message0: $response');
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: OrganizationInfoResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '', statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<OrganizationInfoResponse>>
      getMemberOrganizationInfoViewOwn(
          {required String organizationBaseId}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(EndPoints.getOrganizationInfoViewOwn,
          queryParameters: {
            'OrganizationBaseId': organizationBaseId,
          },
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: OrganizationInfoResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '', statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<bool>> updateMemberOrganization({
    required OrganizationInfoResponse organizationInfo,
  }) async {
    accessToken = localDataAccess.getAccessToken();
    log(organizationInfo.toJson().toString());
    final data = organizationInfo.toJson()
      ..removeWhere(
          (key, value) => value == null || value is! bool && value.isEmpty);

    try {
      final response = await dio.post(EndPoints.addOrganizationInfoViewOwn,
          data: data,
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  // additional path
  @override
  Future<ResponseWrapper<bool>> addMemberAdditionalPathInfoViewOwn(
      {required AdditionalPathInfoResponse additionalPathInfoResponse}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(EndPoints.addAdditionalPathInfo,
          data: additionalPathInfoResponse.toJson()
            ..removeWhere((key, value) =>
                key != 'image' &&
                (value == null || (value is! bool && value.isEmpty))),
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<bool>> deleteMemberAdditionalPathInfoViewOwn(
      {required String pathId, required String basePathId}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.delete(EndPoints.deleteAdditionalPathInfo,
          queryParameters: {"Id": pathId, "PathBaseId": basePathId},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<List<AdditionalPathInfoResponse>>>
      getMemberAdditionalPathInfo(
          {required String additionalPathBaseId}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(EndPoints.getAdditionalPathInfo,
          queryParameters: {
            'PathBaseId': additionalPathBaseId,
          },
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: List.from((response.data as List)
                .map((e) => AdditionalPathInfoResponse.fromJson(e))));
      }
      return ResponseWrapper.error(
          message: '', statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<ResponseWrapper<List<AdditionalPathInfoResponse>>>
      getMemberAdditionalPathInfoViewOwn(
          {required String additionalPathBaseId}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.getAdditionalPathInfoViewOwn,
        queryParameters: {
          'PathBaseId': additionalPathBaseId,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: List.from((response.data as List)
                .map((e) => AdditionalPathInfoResponse.fromJson(e))));
      }
      return ResponseWrapper.error(
          message: '', statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  // qr code
  @override
  Future<ResponseWrapper<bool>> getQrCode({required String username}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response =
          await dio.post('https://me-dev.eztek.net${EndPoints.getQrCode}',
              data: {
                "data": '${Environment.resourcesBaseUrl}/scancard/$username',
                "type": "normal",
              },
              options: Options(
                headers: {'Authorization': 'Bearer $accessToken'},
              ));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> swapDisplayPosition(List<String> data) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.swapDisplayPosition,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> swapAdditionalPathPosition(
      List<String> data) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.swapAdditionalPathPosition,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> swapContactPosition(List<String> data) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.swapContactPosition,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<BusinessOverallResponse>> getBusinessOverall(
      {required String bid}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        '${EndPoints.getBusinessOverall}/$bid',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: BusinessOverallResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<BusinessDetailResponse>> getBusinessDetail(
      {required String bid}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        '${EndPoints.getBusinessInfoViewOwn}$bid',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: BusinessDetailResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<BusinessGetAllResponse>>> getAllBusiness(
      {String? username}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.getAllBusiness,
        queryParameters: {
          "username": username ?? localDataAccess.getUserName(),
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: List.from((response.data as List)
                .map((e) => BusinessGetAllResponse.fromJson(e))
                .toList()));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<BusinessSubTabResponse>>> getBusinessSubTab(
      {required String bid, String? username}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.getAllBusinessSubTab,
        queryParameters: {
          "websiteId": bid,
          "username": username ?? localDataAccess.getUserName(),
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List<BusinessSubTabResponse>.from(
            (response.data as List)
                .map((e) => BusinessSubTabResponse.fromJson(e)),
          ).toList(),
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
  Future<ResponseWrapper<BusinessDetailResponse>> updateBusinessDetail(
      {required BusinessDetailUpdateRequest
          businessDetailUpdateRequest}) async {
    accessToken = localDataAccess.getAccessToken();
    final data = businessDetailUpdateRequest.toJson()
      ..removeWhere(
          (key, value) => value == null || (value is! bool && value.isEmpty));
    log(jsonEncode(data));
    try {
      final response = await dio.post(
        EndPoints.updateBusinessDetail,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: BusinessDetailResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<ProductDetailResponse>> getBusinessProductDetail(
      {String? postId, String? username}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        '${EndPoints.getBusinessProductDetail}/$postId',
        queryParameters: {
          "username": username ?? localDataAccess.getUserName(),
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: ProductDetailResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<ProductDetailResponse>> updateBusinessProduct(
      {required ProductDetailResponse productDetailResponse}) async {
    accessToken = localDataAccess.getAccessToken();
    final data = productDetailResponse.toJson()
      ..removeWhere((key, value) =>
          value == null ||
          (value is! bool && (value is String && value.isEmpty)));
    try {
      final response = await dio.post(
        EndPoints.updateBusinessProduct,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: ProductDetailResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<ProductDetailResponse>> createBusinessProduct(
      {required ProductDetailResponse productDetailResponse}) async {
    accessToken = localDataAccess.getAccessToken();
    final data = productDetailResponse.toJson()
      ..removeWhere((key, value) =>
          value == null ||
          (value is! bool && (value is String && value.isEmpty)));
    try {
      final response = await dio.post(
        EndPoints.createBusinessProduct,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: ProductDetailResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<ProductGetAllResponse>> getAllBusinessProduct(
      {String? subTabId,
      String? categoryId,
      String? keyword,
      required int pageNum,
      required int pageSize,
      String? username}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.getAllBusinessProduct,
        queryParameters: {
          "cateId": categoryId,
          "subTabId": subTabId,
          "keyword": keyword,
          "username": username ?? localDataAccess.getUserName(),
          "page": pageNum,
          "pageSize": pageSize
        }..removeWhere(
            (key, value) => value == null || value is String && value.isEmpty),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: ProductGetAllResponse.fromJson(response.data));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> deleteBusinessProduct(
      {required String pid}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.delete(
        '${EndPoints.deleteBusinessProduct}/$pid',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> changeBusinessProductPosition(
      {required List<String> pidList, String? categoryId}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.swapBusinessProduct,
        data: {
          "idList": pidList,
          "categoryId": categoryId,
        }..removeWhere((key, value) => value == null || value == ''),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> activeAnoCard(
      {required String cardId, required String key}) async {
    accessToken = localDataAccess.getAccessToken();
    final username = localDataAccess.getUserName();
    try {
      final response = await dio.post(
        EndPoints.activeAnoCard,
        data: {"activatedUsername": username, "cardId": cardId, "key": key},
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      if (response.statusCode == 204) {
        return ResponseWrapper.success(data: false);
      }
      if (response.statusCode == 400) {
        return ResponseWrapper.error(
            data: false, message: response.data.toString());
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }
}
