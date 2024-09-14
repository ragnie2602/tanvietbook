import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../../di/di.dart';
import '../../../domain/entity/agency/agency_detail.dart';
import '../../../domain/entity/agency_category/agency_category.dart';
import '../../../domain/entity/agency_order_create_request/agency_convert_product_dimension_request.dart';
import '../../../domain/entity/agency_order_create_request/agency_get_shipping_fee_request.dart';
import '../../../domain/entity/agency_order_create_request/agency_order_create_request.dart';
import '../../../domain/entity/agency_order_detail/agency_order_detail.dart';
import '../../../domain/entity/ageny_product/agency_product.dart';
import '../../../domain/entity/appointment/event_entity.dart';
import '../../../domain/entity/cart/agency_cart_item_entity/agency_cart_item_entity.dart';
import '../../../domain/entity/checkin/checkin_detail.dart';
import '../../../domain/entity/checkin/purpose.dart';
import '../../../domain/entity/customer/customer.dart';
import '../../../domain/entity/user_address/user_address.dart';
import '../../../domain/entity/voucher/validate_voucher_entity.dart';
import '../../../model/agency/agency_detail_response/agency_detail_response.dart';
import '../../../model/agency/agency_order_detail_response/agency_order_detail_response.dart';
import '../../../model/agency/agency_product_response/agency_product_response.dart';
import '../../../model/agency/agency_shipping_fee/get_shipping_fee_response.dart';
import '../../../model/agency/cart/agency_cart_item_response.dart';
import '../../../model/agency/comission/agency_comission_history_response.dart';
import '../../../model/agency/comission/agency_comission_info_response.dart';
import '../../../model/agency/comission/agency_comission_tree_response.dart';
import '../../../model/agency/comission/agency_kpi_info_response.dart';
import '../../../model/agency/voucher/voucher_validate_response.dart';
import '../../../model/api/base_response.dart';
import '../../../model/appointment/event_response.dart';
import '../../../model/checkin/checkin_detail_response.dart';
import '../../../model/checkin/journey_request.dart';
import '../../../model/checkin/purpose.dart';
import '../../../model/customer/customer_response.dart';
import '../../../model/member/collaborator/collaborator_response.dart';
import '../../../model/route.dart';
import '../../../model/route/route_response.dart';
import '../../../model/user_role/user_role_response.dart';
import '../../../services/exceptions/handle_exception.dart';
import '../../../shared/utils/utils.dart';
import '../../constants.dart';
import '../../mapper/agency_cart_data_mapper.dart';
import '../../mapper/agency_data_mapper.dart';
import '../../mapper/appointment_data_mapper.dart';
import '../../mapper/checkin_data_mapper.dart';
import '../../mapper/customer_data_mapper.dart';
import '../../mapper/route_data_mapper.dart';
import '../interceptor/dio_base_options.dart';
import '../interceptor/interceptor.dart';
import '../local/local_data_access.dart';
import 'agency_repository.dart';

class AgencyRepositoryImpl implements AgencyRepository {
  final Dio dio = getIt.get<Dio>();
  final LocalDataAccess localDataAccess = getIt.get<LocalDataAccess>();
  String accessToken = '';

  AgencyRepositoryImpl() {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    dio.interceptors.add(AppInterceptor().queueInterceptor(dio: dio));
    dio.options = DioBaseOptions(baseUrl: Environment.agencyBaseUrl).baseOption;
  }

  late final AgencyDetailMapper _agencyDetailMapper = getIt.get();
  late final AgencyProductDataMapper _agencyProductDataMapper = getIt.get();
  late final AgencyOrderDataMapper _agencyOrderDataMapper = getIt.get();
  late final AgencyCartDatalMapper _agencyCartDatalMapper = getIt.get();
  late final AgencyVoucherValidateDataMapper _agencyVoucherValidateDataMapper =
      getIt.get();

  late final PurposeDataMapper _purposeDataMapper = getIt.get();
  late final CheckinDetailDataMapper _checkinDetailDataMapper = getIt.get();
  late final CustomerDataMapper _customerDataMapper = getIt.get();
  late final RouteDataMapper _routeDataMapper = getIt.get();
  late final EventDataMapper _eventDataMapper = getIt.get();

  @override
  Future<ResponseWrapper<Customer>> addCustomer(
      CustomerResponse customer) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final data = (customer..username = localDataAccess.getUserName()).toJson()
        ..removeWhere((key, value) => value == null || value.toString().isEmpty)
        ..addEntries(<String, int>{'type': 1}.entries);

      if (data['routeId'] == null) {
        data['routeId'] = null;
        data['type'] = 2;
      }

      final response = await dio.post(EndPoints.addCustomer,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          data: data);

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: _customerDataMapper
                .mapToEntity(CustomerResponse.fromJson(response.data)));
      }
      return ResponseWrapper.error(
          statusCode: response.statusCode, message: response.statusMessage);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<Customer>> editCustomer(
      CustomerResponse customer) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.patch(EndPoints.editCustomer,
          data: customer.toJson()
            ..removeWhere(
                (key, value) => value == null || value.toString().isEmpty),
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: _customerDataMapper
                .mapToEntity(CustomerResponse.fromJson(response.data)));
      }
      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<Customer>> getCustomer(String id) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(EndPoints.getCustomer + id,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: _customerDataMapper
                .mapToEntity(CustomerResponse.fromJson(response.data)));
      }
      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<String>> checkin(Customer customer, String location,
      double latitude, double longitude) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(EndPoints.checkin,
          data: {
            "routeId": customer.routeId,
            "customerId": customer.id,
            "locationCheckin": location,
            "longitudeCheckin": longitude,
            "latitudeCheckin": latitude,
            "status": 0,
            "agency": AppConfig.agencyName
          },
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: response.data["id"]);
      }
      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> checkout(
      {String checkinId = '',
      required List<String> imageLinks,
      double latitude = 0.0,
      List<String>? listOrderId,
      String location = '',
      double longitude = 0.0,
      String notes = '',
      String purpose = ''}) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(EndPoints.checkout,
          data: {
            "checkinId": checkinId,
            "locationCheckout": location,
            "longitudeCheckout": longitude,
            "latitudeCheckout": latitude,
            "purpose": purpose,
            "images": imageLinks,
            "note": notes,
            "orderTotal": listOrderId?.length ?? 0,
            "listOrderId": listOrderId
          },
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<AgencyDetail>> getDetailAgency() async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(EndPoints.getAgencyDetail,
          queryParameters: {'Agency': AppConfig.agencyName}
            ..removeWhere((key, value) => value is String && value.isEmpty),
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: _agencyDetailMapper
                .mapToEntity(AgencyDetailResponse.fromJson(response.data)));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<AgencyProduct>>> getAllAgencyProduct(
      {String? categoryId, int page = 1, int pageSize = 10}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.getAllAgencyProduct,
        data: {
          'Agency': AppConfig.agencyName,
          'page': page,
          'pageSize': pageSize,
          'cateId': categoryId,
        }..removeWhere(
            (key, value) => value == null || value is String && value.isEmpty),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        final responsePaging =
            DefaultPagingResponse<List<AgencyProductResponse>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((e) => AgencyProductResponse.fromJson(e))
              .toList(),
        );

        return ResponseWrapper.success(
            data: (responsePaging.data ?? [])
                .map((e) => _agencyProductDataMapper.mapToEntity(e))
                .toList());
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<AgencyProduct>> getProductDetail(
      {required String productId}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        '${EndPoints.getProductDetail}/$productId',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: _agencyProductDataMapper
                .mapToEntity(AgencyProductResponse.fromJson(response.data)));
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<UserAddress>>> getAllAddressByUser(
      {required String agency, String? userId}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.getAllAddressByUser,
        data: {
          "agency": AppConfig.agencyName,
          "userid": userId ?? localDataAccess.getUserId(),
        }..removeWhere((key, value) => value.isEmpty),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: (response.data as List)
              .map((e) => UserAddress.fromJson(e))
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
  Future<ResponseWrapper<UserAddress>> addUserAddress(
      {required UserAddress userAddress}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.addUserAddress,
        data: userAddress.toJson()..removeWhere((key, value) => value == null),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: UserAddress.fromJson(response.data),
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
  Future<ResponseWrapper<UserAddress>> updateUserAddress(
      {required UserAddress userAddress}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.put(
        EndPoints.addUserAddress,
        data: userAddress.toJson()..removeWhere((key, value) => value == null),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: UserAddress.fromJson(response.data),
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
  Future<ResponseWrapper<bool>> deleteUserAddress({required String id}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.delete(
        EndPoints.addUserAddress,
        data: {
          'id': id,
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

  @override
  Future<ResponseWrapper<String>> createOrder(
      AgencyOrderCreateRequest agencyOrderCreateRequest) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.addOrder,
        data: agencyOrderCreateRequest.toJson()
          ..removeWhere((key, value) => value == null),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: response.data['message']);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<AgencyOrderDetail>>> getAllOrders({
    required String agency,
    String? userId,
    int page = 1,
    int pageSize = 10,
    int? status,
  }) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.getAllAgencyOrders,
        data: {
          'agency': agency,
          'userId': userId ?? localDataAccess.getUserId(),
          'page': page,
          'pageSize': pageSize,
          'status': status,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        final responsePaging =
            DefaultPagingResponse<List<AgencyOrderDetailResponse>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((e) => AgencyOrderDetailResponse.fromJson(e))
              .toList(),
        );

        return ResponseWrapper.success(
          data: List.from(responsePaging.data!
              .map((e) => _agencyOrderDataMapper.mapToEntity(e))
              .toList()),
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
  Future<ResponseWrapper<List<Map<String, String>>>> getAllDistricts(
      String provinceId) async {
    var mydio = Dio();

    try {
      final response = await mydio.get(
          'https://api-hust.eztek.net/show-all-district-in-city',
          queryParameters: {'city_code': provinceId});

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List.from(
            (response.data as List).map((e) => {
                  "code": e["code"].toString(),
                  "full_name": e["full_name"].toString()
                }),
          ),
        );
      }

      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<Map<String, String>>>> getAllProvinces() async {
    var mydio = Dio();

    try {
      final response =
          await mydio.get('https://api-hust.eztek.net/show-all-city');

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List.from(
            (response.data as List).map((e) => {
                  "code": e["code"].toString(),
                  "full_name": e["full_name"].toString()
                }),
          ),
        );
      }

      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<Map<String, String>>>> getAllWards(
      String districtId) async {
    var mydio = Dio();

    try {
      final response = await mydio.get(
          'https://api-hust.eztek.net/show-all-ward-in-district',
          queryParameters: {'district_code': districtId});

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List.from(
            (response.data as List).map((e) => {
                  "code": e["code"].toString(),
                  "full_name": e["full_name"].toString()
                }),
          ),
        );
      }

      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<Purpose>>> getAllPurpose() async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(EndPoints.getAllPurpose,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          queryParameters: {'agency': AppConfig.agencyName});

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: (response.data as List)
              .map((e) =>
                  _purposeDataMapper.mapToEntity(PurposeResponse.fromJson(e)))
              .toList(),
        );
      }

      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<RouteEntity>>> getAllRoutes(
      {bool isCurrent = false}) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(EndPoints.routes,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          data: {
            'agency': AppConfig.agencyName,
            'manager': isCurrent ? localDataAccess.getUserName() : null,
            'page': 1,
            'pageSize': 1000,
          }..removeWhere((key, value) => value == null));

      if (response.statusCode == 200) {
        final responsePaging =
            DefaultPagingResponse<List<RouteResponse>>.fromJson(
          response.data,
          (json) =>
              (json as List).map((e) => RouteResponse.fromJson(e)).toList(),
        );

        return ResponseWrapper.success(
          data: List.from((responsePaging.data as List)
              .map((e) => _routeDataMapper.mapToEntity(e))),
        );
        // return ResponseWrapper.success(data: (response.data['data'] as List).map((e) => _routeDataMapper.mapToEntity(RouteResponse.fromJson(e))).toList());
      }
      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<AgencyOrderDetail>> getOrderDetail(
      String orderId) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        '${EndPoints.getAgencyOrderDetail}/$orderId',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: _agencyOrderDataMapper
              .mapToEntity(AgencyOrderDetailResponse.fromJson(response.data)),
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
  Future<ResponseWrapper<bool>> updateOrderDetail(
      String orderId, int status) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.put(
        EndPoints.updateOrder,
        data: {
          'id': orderId,
          'status': status,
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

  @override
  Future<ResponseWrapper<List<AgencyCategory>>> getAlCategories({
    required String agency,
    int page = 1,
    int pageSize = 999999,
  }) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.getAllCategories,
        data: {
          'agency': agency,
          'page': page,
          'pageSize': pageSize,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        final responsePaging =
            DefaultPagingResponse<List<AgencyCategory>>.fromJson(
          response.data,
          (json) =>
              (json as List).map((e) => AgencyCategory.fromJson(e)).toList(),
        );

        return ResponseWrapper.success(
          data: responsePaging.data!,
        );
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  //collaborator
  @override
  Future<ResponseWrapper<CollaboratorResponse?>> getCollaboratorDetail(
      {String? username}) async {
    accessToken = localDataAccess.getAccessToken();
    username = username ?? localDataAccess.getUserName();
    try {
      final response = await dio.get(
        '${EndPoints.getCollaboratorInfo}/$username',
        queryParameters: {
          'Agency': AppConfig.agencyName,
        }..removeWhere((key, value) => value is String && value.isEmpty),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: CollaboratorResponse.fromJson(response.data));
      }
      if (response.statusCode == 204) {
        return ResponseWrapper.success(data: null);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> checkCollaboratorExist(
      {String? username}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        EndPoints.checkCollaboratorExist,
        queryParameters: {
          'Agency': AppConfig.agencyName,
          'Username': username,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: (response.data as Map)['isExisted'] ?? false);
      }
      if (response.statusCode == 204) {
        return ResponseWrapper.success(data: false);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> regsiterCollaborator(
      CollaboratorResponse collaboratorInfo) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.regsiterCollaborator,
        data: collaboratorInfo.toJson()
          ..removeWhere((key, value) => value == null),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      }
      if (response.statusCode == 204) {
        return ResponseWrapper.success(data: false);
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<AgencyComissionInfo>> getComissionInfo(
      {String? username}) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(
        '${EndPoints.getComissionInfo}/node/${username ?? localDataAccess.getUserName()}',
        queryParameters: {
          'Agency': AppConfig.agencyName,
        }..removeWhere((key, value) => value is String && value.isEmpty),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: AgencyComissionInfo.fromJson(response.data));
      }

      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<KPIInfoResponse>>> getKPIInfo() async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(
        '/sale/kpis',
        queryParameters: {
          'Agency': AppConfig.agencyName,
          'Username': localDataAccess.getUserName(),
        }..removeWhere((key, value) => value is String && value.isEmpty),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: (response.data as List)
                .map((e) => KPIInfoResponse.fromJson(e))
                .toList());
      }

      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<AgencyComissionTree>> getComissionTree({
    int page = 1,
    int pageSize = 999,
    bool isOwn = false,
  }) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.get(
        isOwn
            ? ('/gateway/collaborators/own/trees/${localDataAccess.getUserName()}')
            : EndPoints.getComissionInfo,
        queryParameters: {
          'Agency': AppConfig.agencyName,
          'Page': page,
          'PageSize': pageSize,
        }..removeWhere((key, value) => value is String && value.isEmpty),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: AgencyComissionTree.fromJson(response.data));
      }

      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<AgencyComissionHistoryResponse>>>
      getComissionHistory(
          {int page = 1,
          int pageSize = 999,
          int? status,
          String? startDate,
          String? endDate,
          String? name,
          int? level,
          String? type}) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(
        EndPoints.getComissionHistory,
        data: {
          "name": name,
          "status": status,
          "type": type,
          "level": level,
          "startDate": startDate,
          "endDate": endDate,
          "page": page,
          "pageSize": pageSize,
          "agency": AppConfig.agencyName,
        }..removeWhere(
            (key, value) => value == null || value is String && value.isEmpty),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        final responsePaging = DefaultPagingResponse<
            List<AgencyComissionHistoryResponse>>.fromJson(
          response.data,
          (json) => (json as List)
              .map((e) => AgencyComissionHistoryResponse.fromJson(e))
              .toList(),
        );

        return ResponseWrapper.success(data: responsePaging.data ?? []);
      }

      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<AgencyCartItemEntity>>> getAllCartItems() async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(
        '${EndPoints.getAllCartItems}/${localDataAccess.getUserId()}',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        try {
          return ResponseWrapper.success(
            data: List.from(response.data!
                .map((e) => _agencyCartDatalMapper
                    .mapToEntity(AgencyCartItemResponse.fromJson(e)))
                .toList()),
          );
        } catch (e) {
          // log('message: $e');
          return ResponseWrapper.success(data: []);
        }
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<AgencyCartItemEntity>> addToCart(
      {String? cartItemId,
      required String productId,
      required int amount}) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(
        '/gateway/agency/cart',
        data: {
          "id": cartItemId,
          "productId": productId,
          "amount": amount,
          "userId": localDataAccess.getUserId(),
        }..removeWhere((key, value) => value == null),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: _agencyCartDatalMapper
              .mapToEntity(AgencyCartItemResponse.fromJson(response.data)),
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
  Future<ResponseWrapper<bool>> deleteCartItem(String cartItemId) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.delete(
        '/gateway/agency/cart/$cartItemId',
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

  @override
  Future<ResponseWrapper<VoucherValidateEntity>> validateVoucher(
      {required String code, required double payment}) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(
        '/gateway/voucher/validate',
        data: {
          'code': code,
          'amount': payment,
          'agency': AppConfig.agencyName,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: _agencyVoucherValidateDataMapper
              .mapToEntity(VoucherValidateResponse.fromJson(response.data)),
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
  Future<ResponseWrapper<ConvertProductDimension>> convertProductDimension(
      List<ConvertProductDimension> request) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(
        '/gateway/agency/transport/convert-product-dimensions',
        data: request.map((e) => e.toJson()).toList(),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: ConvertProductDimension.fromJson(response.data),
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
  Future<ResponseWrapper<GetShippingFeeResponse>> getShippingFee(
      {required GetShippingFeeRequest request}) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(
        '/tanviet/viettel-post/get-price-nlp',
        data: request.toJson()
          ..removeWhere(
              (key, value) => value == null || value.toString().isEmpty),
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: GetShippingFeeResponse.fromJson(response.data),
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
  Future<ResponseWrapper<List<AgencyProduct>>> getAllProducts(
      {int page = 1, String? search}) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(EndPoints.getAllAgencyProduct,
          data: {
            "agency": AppConfig.agencyName,
            "name": search,
            "page": page,
            "pageSize": 10,
            "status": 1
          },
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List.from(
            (response.data["data"] as List).map((e) => _agencyProductDataMapper
                .mapToEntity(AgencyProductResponse.fromJson(e))),
          ),
        );
      }
      return ResponseWrapper.error(
          statusCode: response.statusCode, message: response.statusMessage);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<int>> checkRole({String? username}) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(EndPoints.checkRole,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          queryParameters: {
            'UserName': username ?? localDataAccess.getUserName(),
            'Agency': AppConfig.agencyName
          });

      if (response.statusCode == 200) {
        int data = response.data['sale']
            ? UserRole.sale
            : response.data['ctv']
                ? UserRole.collaborator
                : UserRole.user;

        localDataAccess.setUserRole(data);

        return ResponseWrapper.success(data: data);
      }
      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<bool>> checkSale(
      String? username, String agency) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(EndPoints.checkSaleStaff,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          queryParameters: {
            'Username': username ?? localDataAccess.getUserName(),
            'Agency': agency
          });

      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: true);
      } else {
        return ResponseWrapper.error(
            message: '${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<double>> getDistance(double startLatitude,
      double startLongtitude, double endLatitude, double endLongtitude) async {
    var myDio = Dio();
    try {
      final response = await myDio.get(
          'https://router.project-osrm.org/route/v1/driving/$startLongtitude,$startLatitude;$endLongtitude,$endLatitude?overview=false');

      if (response.statusCode == 200 && response.data["code"] == "Ok") {
        return ResponseWrapper.success(
            data: (response.data["routes"] as List)[0]["distance"] ?? 0.0);
      } else {
        return ResponseWrapper.error();
      }
    } catch (e) {
      return ResponseWrapper.error();
    }
  }

  @override
  Future<ResponseWrapper<List<Customer>>> searchCustomerByRoute(
      String? routeId, String? search, int page) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(EndPoints.searchCustomerByRoute,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          queryParameters: {
            'Agency': AppConfig.agencyName,
            'Search': search,
            'Page': page,
            'PageSize': 5,
            'Type': routeId == null ? 2 : 1,
            'RouteId': routeId
          }..removeWhere((key, value) => value == null));

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: List.from(
            (response.data['data'] as List).map((e) =>
                _customerDataMapper.mapToEntity(CustomerResponse.fromJson(e))),
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

  @override
  Future<ResponseWrapper<List<String>>> upload(List<XFile> images) async {
    accessToken = localDataAccess.getAccessToken();
    var mydio = Dio();
    FormData formData = FormData();

    for (var image in images) {
      formData.files
          .add(MapEntry("file", MultipartFile.fromFileSync(image.path)));
    }
    formData.fields.add(const MapEntry("source", AppConfig.agencyName));

    try {
      final response = await mydio.put(
          Environment.cdnBaseUrl + EndPoints.upload,
          data: formData,
          options: Options(headers: {
            'Accept': 'application/json',
            'content-type': 'multipart/form-data'
          }));

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: (response.data as List).map((e) => e.toString()).toList());
      }
      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<CheckinDetail>> getCheckinDetail(String id) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get(EndPoints.checkinDetail,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          queryParameters: {'CheckinId': id});

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: _checkinDetailDataMapper
                .mapToEntity(CheckinDetailResponse.fromJson(response.data)));
      }
      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<List<CheckinDetail>>> getJourney(
      JourneyRequest request) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(EndPoints.getJourneys,
          data: request.toJson(),
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: (response.data as List).map((e) {
            return _checkinDetailDataMapper
                .mapToEntity(CheckinDetailResponse.fromJson(e));
          }).toList(),
        );
      }
      return ResponseWrapper.error(
          message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<UserRoleResponse>> getUserRole() async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.get('/gateway/user/check-role',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          queryParameters: {
            'Agency': AppConfig.agencyName,
            'UserName': localDataAccess.getUserName(),
          });

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
          data: UserRoleResponse.fromJson(response.data),
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
  Future<ResponseWrapper<List<EventEntity>>> getAllEvents(
      {int page = 1, int pageSize = 999, int? typeCheck}) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post('/gateway/event/search',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          data: {
            'agency': AppConfig.agencyName,
            'userId': localDataAccess.getUserId(),
            'page': page,
            'typeCheck': typeCheck,
            'dateCheck': Utils.toStringIsoDateTime(DateTime.now().toString()),
            'pageSize': pageSize,
          }..removeWhere((key, value) => value == null));

      if (response.statusCode == 200) {
        final responsePaging =
            DefaultPagingResponse<List<EventResponse>>.fromJson(
          response.data,
          (json) =>
              (json as List).map((e) => EventResponse.fromJson(e)).toList(),
        );

        return ResponseWrapper.success(
            data: (responsePaging.data ?? [])
                .map((e) => _eventDataMapper.mapToEntity(e))
                .toList());
      }
      return ResponseWrapper.error(
          message: '${response.statusCode} ${response.statusMessage}');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }
}
