import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../../model/api/base_response.dart';
import '../../../services/exceptions/handle_exception.dart';
import '../../model/public_api/location.dart';
import 'repository.dart';

class UtilitiesRepositoryImpl implements UtilityRepository {
  final Dio dio;

  UtilitiesRepositoryImpl({required this.dio}) {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: false,
      responseHeader: true,
      requestBody: true,
      requestHeader: true,
    ));
    final BaseOptions options = BaseOptions(
      baseUrl: EndPoints.publicAddressBaseUrl,
      sendTimeout: 30000,
      receiveTimeout: 30000,
      followRedirects: false,
      validateStatus: (status) {
        return status! <= 400;
      },
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    dio.options = options;
  }

  @override
  Future<ResponseWrapper<List<Province>>> getProvincesList() async {
    try {
      final citiesStr =
          await rootBundle.loadString('assets/resources/cities.json');
      final provincesList = jsonDecode(citiesStr) as List;

      return ResponseWrapper.success(
        data: List<Province>.from(
          provincesList.map((model) => Province.fromJson(model)),
        ),
      );
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: "", data: []);
    }
  }

  @override
  Future<ResponseWrapper<List<District>>> getDistrictsList() async {
    try {
      final districtsStr =
          await rootBundle.loadString('assets/resources/districts.json');
      final districtsList = jsonDecode(districtsStr) as List;

      return ResponseWrapper.success(
        data: List<District>.from(
          districtsList.map((model) => District.fromJson(model)),
        ),
      );
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(data: [], message: "");
    }
  }

  @override
  Future<ResponseWrapper<List<Ward>>> getCommunesList() async {
    try {
      final wardsStr =
          await rootBundle.loadString('assets/resources/wards.json');
      final wardsList = jsonDecode(wardsStr) as List;

      return ResponseWrapper.success(
        data: List<Ward>.from(
          wardsList.map((model) => Ward.fromJson(model)),
        ),
      );
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

// getCommunesList(String? name,List<District> provincesList) async {
//   int? index = 1;
//   for (var i in listDistricts) {
//     if (i.name == name) {
//       index = i.code;
//     }
//   }
//   var url = Uri.parse('https://provinces.open-api.vn/api/d/$index?depth=2');
//   var response = await http.get(url, headers: {
//     "Accept": "application/json",
//     "content-type": "application/json"
//   });
//   District district =
//       District.fromJson(json.decode(utf8.decode(response.bodyBytes)));
//   listCommunes = district.wards!;
//   commune ??= listCommunes[0].name;
//   setState(() {});
// }
}
