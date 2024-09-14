import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../data/constants.dart';
import '../model/basic_info.dart';
import '../model/group_product.dart';
import '../model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';

class Api {
  final Dio dio;

  Api(
    Dio? dio,
  ) : dio = dio ?? Dio() {
    this.dio.interceptors.add(PrettyDioLogger(
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
        return status! <= 500;
      },
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    this.dio.options = options;
  }

  Future<Response<dynamic>> login(
      String username, String password, bool rememberMe) async {
    var body = jsonEncode(
        {'username': username, 'password': password, 'rememberMe': rememberMe});
    final loginResponse = await dio.post(EndPoints.login, data: body);
    return loginResponse;
  }

  // Future<CollaboratorInfo?> getCollabInfo() async {
  //   final sharedPref = await SharedPreferences.getInstance();
  //   final String? accessToken =
  //       sharedPref.getString(SharedPreferenceKey.idToken);

  //   final collabInfo = await dio.get(EndPoints.getCollabInfo,
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $accessToken'},
  //       ));

  //   log(collabInfo.data.toString());
  //   if (collabInfo.statusCode == 200) {
  //     return CollaboratorInfo.fromJson(collabInfo.data);
  //   } else {
  //     return null;
  //   }
  // }

  // Future<CollaboratorTreeResponse?> getCollabTree() async {
  //   final sharedPref = await SharedPreferences.getInstance();
  //   final String? accessToken =
  //       sharedPref.getString(SharedPreferenceKey.idToken);

  //   final collabTree = await dio.get(EndPoints.getCollabTree,
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $accessToken'},
  //       ));

  //   log("tree: ${collabTree.data}");
  //   if (collabTree.statusCode == 200) {
  //     return CollaboratorTreeResponse.fromJson(collabTree.data);
  //   } else {
  //     return null;
  //   }
  // }

  // Future<CheckCollaboratorResponse?> checkCollaborator() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   String? accessToken = prefs.getString(SharedPreferenceKey.idToken);

  //   final response = await dio.get(
  //     EndPoints.checkCollaborator,
  //     options: Options(
  //       headers: {'Authorization': 'Bearer $accessToken'},
  //     ),
  //   );

  //   log('check collab: ${response.data}');
  //   if (response.statusCode == 200) {
  //     return CheckCollaboratorResponse.fromJson(response.data);
  //   }

  //   return null;
  // }

  // Future<MemberDetailInfo?>? getMemberDetailInfo() async {
  //   final sharedPref = await SharedPreferences.getInstance();
  //   final String? accessToken =
  //       sharedPref.getString(SharedPreferenceKey.idToken);
  //   final String? username = sharedPref.getString("username");
  //
  //   final response = await dio.get(EndPoints.getMemberDetailInfo,
  //       queryParameters: {"username": username},
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $accessToken'},
  //       ));
  //   if (response.statusCode == 200) {
  //     return MemberDetailInfo.fromJson(response.data);
  //   } else {
  //     return null;
  //   }
  // }

  Future<BasicInfo?>? getMemberBasicInfo() async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);
    final String? username = sharedPref.getString("username");

    final response = await dio.get(EndPoints.getMemberBasicInfo,
        queryParameters: {"username": username},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    if (response.statusCode == 200) {
      return BasicInfo.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<Response> getBusinessTab(memberId) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);

    final response = await dio.get(EndPoints.getBusinessTab,
        queryParameters: {"memberId": memberId},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }

  Future<List<dynamic>?>? getSubTab(tabId, username) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);

    final response = await dio.get(EndPoints.getSubTab,
        queryParameters: {"TabId": tabId, "Username": username},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<List<GroupProduct>?>? getGroupProductList(subTabId, username) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);

    final response = await dio.get(EndPoints.getGroupProductList,
        queryParameters: {"SubTabId": subTabId, "Username": username},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    if (response.statusCode == 200) {
      List<dynamic> listDynamic = response.data;
      List<GroupProduct> list = [];
      for (var i in listDynamic) {
        list.add(GroupProduct.fromJson(i));
      }
      return list;
    } else {
      return null;
    }
  }

  Future<Response> swapPositionGroupProductList(
      groupProductId1, groupProductId2) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);
    final String? xLicenseKey =
        sharedPref.getString(SharedPreferenceKey.xLicenseKey);
    final body = jsonEncode({"id1": groupProductId1, "id2": groupProductId2});
    final response = await dio.post(EndPoints.swapPositionGroupProductList,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'X-License-Key': xLicenseKey
          },
        ));
    return response;
  }

  Future<List<Product>?>? getProductList(groupProductId, username) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);

    final response = await dio.get(EndPoints.getProductList,
        queryParameters: {
          "productGroupId": groupProductId,
          "Username": username
        },
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    if (response.statusCode == 200) {
      List<dynamic> listDynamic = response.data;
      List<Product> list = [];
      for (var i in listDynamic) {
        list.add(Product.fromJson(i));
      }
      return list;
    } else {
      return null;
    }
  }

  Future<Product?>? getProductViewDetail(productId, username) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final String? xLicenseKey =
        sharedPref.getString(SharedPreferenceKey.xLicenseKey);
    final response = await dio.get(EndPoints.getProductViewDetail,
        queryParameters: {"productId": productId, "Username": username},
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
            "X-License-Key": '$xLicenseKey'
          },
        ));
    if (response.statusCode == 200) {
      return Product.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<Response> getForgotPasswordMethod({required String username}) async {
    final response = await dio.get('/api/account/forgot-password-method',
        queryParameters: {"Login": username});
    return response;
  }

  Future<Response> sendOTP(
      {required String username,
      required String type,
      required String value}) async {
    final body = jsonEncode({"login": username, "type": type, "value": value});
    final response =
        await dio.post('/api/account/forgot-password-Getotp', data: body);
    return response;
  }

  Future<Response> checkOTP(
      {required String username, required String key}) async {
    final body = jsonEncode({"login": username, "key": key});
    final response =
        await dio.post('/api/account/forgot-password-CheckOtp', data: body);
    return response;
  }

  Future<Response> forgotPasswordComplete(
      {required String newPassword,
      required String username,
      required String key}) async {
    final body =
        jsonEncode({"newPassword": newPassword, "login": username, "key": key});
    final response =
        await dio.post('/api/account/forgot-password-complete', data: body);
    return response;
  }

  Future<Response> vcfFile(
      {required String username, required Object body}) async {
    final mBody = jsonEncode(body);
    final response = await dio.post('/gateway/Member/vcfFile',
        data: mBody, queryParameters: {"Username": username});
    return response;
  }

  Future<Response> getDetailMedia(
      {required String memberId, required String type}) async {
    final response = await dio.get(
        '${Environment.resourcesBaseUrl}/gateway/Member/memberViewMemberDetailMedia',
        queryParameters: {"memberId": memberId, "type": type});
    return response;
  }

  Future<Response> verifiedEmailOtp(
      {required String username, required String value}) async {
    final body = jsonEncode({"login": username, "value": value});
    final response =
        await dio.post('/api/account/verified-email-otp', data: body);
    return response;
  }

  Future<Response> verifiedEmailComplete(
      {required String username, required String key}) async {
    final body = jsonEncode({"login": username, "key": key});
    final response =
        await dio.post('/api/account/verified-email-complete', data: body);
    return response;
  }

  Future<Response> getInformation() async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.get('/api/getInformation',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ));
    return response;
  }

  // Future<SubTab?> getSubTab
}
