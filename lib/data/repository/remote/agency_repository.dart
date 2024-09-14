import 'package:image_picker/image_picker.dart';

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
import '../../../model/agency/agency_shipping_fee/get_shipping_fee_response.dart';
import '../../../model/agency/comission/agency_comission_history_response.dart';
import '../../../model/agency/comission/agency_comission_info_response.dart';
import '../../../model/agency/comission/agency_comission_tree_response.dart';
import '../../../model/agency/comission/agency_kpi_info_response.dart';
import '../../../model/api/base_response.dart';
import '../../../model/checkin/journey_request.dart';
import '../../../model/customer/customer_response.dart';
import '../../../model/member/collaborator/collaborator_response.dart';
import '../../../model/route.dart';
import '../../../model/user_role/user_role_response.dart';

abstract class AgencyRepository {
// customer
  Future<ResponseWrapper<Customer>> addCustomer(CustomerResponse customer);

  Future<ResponseWrapper<String>> checkin(
      Customer customer, String location, double latitude, double longitude);

  Future<ResponseWrapper<bool>> checkout(
      {String checkinId,
      required List<String> imageLinks,
      double latitude,
      List<String>? listOrderId,
      String location,
      double longitude,
      String notes,
      String purpose});

  Future<ResponseWrapper<Customer>> editCustomer(CustomerResponse customer);

  Future<ResponseWrapper<Customer>> getCustomer(String id);

  // agency
  Future<ResponseWrapper<AgencyDetail>> getDetailAgency();

  Future<ResponseWrapper<List<AgencyProduct>>> getAllAgencyProduct({
    int page = 1,
    int pageSize = 10,
    String? categoryId,
  });

  Future<ResponseWrapper<AgencyProduct>> getProductDetail({
    required String productId,
  });
  Future<ResponseWrapper<List<UserAddress>>> getAllAddressByUser(
      {required String agency, String? userId});

  Future<ResponseWrapper<UserAddress>> addUserAddress(
      {required UserAddress userAddress});

  Future<ResponseWrapper<UserAddress>> updateUserAddress(
      {required UserAddress userAddress});

  Future<ResponseWrapper<bool>> deleteUserAddress({required String id});

  Future<ResponseWrapper<VoucherValidateEntity>> validateVoucher(
      {required String code, required double payment});

  Future<ResponseWrapper<ConvertProductDimension>> convertProductDimension(
      List<ConvertProductDimension> request);

  Future<ResponseWrapper<UserRoleResponse>> getUserRole();

  Future<ResponseWrapper<GetShippingFeeResponse>> getShippingFee(
      {required GetShippingFeeRequest request});

  Future<ResponseWrapper<String>> createOrder(
      AgencyOrderCreateRequest agencyOrderCreateRequest);

  Future<ResponseWrapper<AgencyOrderDetail>> getOrderDetail(String orderId);

  Future<ResponseWrapper<bool>> updateOrderDetail(
    String orderId,
    int status,
  );

  Future<ResponseWrapper<List<AgencyOrderDetail>>> getAllOrders({
    required String agency,
    String? userId,
    int page = 1,
    int pageSize = 10,
    int? status,
  });

  ///gateway/agency/order/transport-status-list

  Future<ResponseWrapper<List<Map<String, String>>>> getAllDistricts(
      String provinceId);
  Future<ResponseWrapper<List<AgencyProduct>>> getAllProducts(
      {int page, String? search});
  Future<ResponseWrapper<List<Map<String, String>>>> getAllProvinces();
  Future<ResponseWrapper<List<Map<String, String>>>> getAllWards(
      String districtId);

  Future<ResponseWrapper<List<Purpose>>> getAllPurpose();

  Future<ResponseWrapper<List<RouteEntity>>> getAllRoutes(
      {bool isCurrent = false});

  Future<ResponseWrapper<List<AgencyCategory>>> getAlCategories({
    required String agency,
    int page = 1,
    int pageSize = 999,
  });

  // affiliate
  Future<ResponseWrapper<CollaboratorResponse?>> getCollaboratorDetail(
      {String? username});

  Future<ResponseWrapper<bool>> checkCollaboratorExist({String? username});

  Future<ResponseWrapper<bool>> regsiterCollaborator(
      CollaboratorResponse collaboratorInfo);

  Future<ResponseWrapper<AgencyComissionInfo>> getComissionInfo(
      {String? username});
  Future<ResponseWrapper<List<KPIInfoResponse>>> getKPIInfo();

  Future<ResponseWrapper<AgencyComissionTree>> getComissionTree({
    int page = 1,
    int pageSize = 999,
    bool isOwn = false,
  });

  Future<ResponseWrapper<List<AgencyComissionHistoryResponse>>>
      getComissionHistory({
    int page = 1,
    int pageSize = 999,
    int? status,
    String? startDate,
    String? endDate,
    String? name,
    int? level,
    String? type,
  });

  Future<ResponseWrapper<List<AgencyCartItemEntity>>> getAllCartItems();

  Future<ResponseWrapper<CheckinDetail>> getCheckinDetail(String id);

  Future<ResponseWrapper<AgencyCartItemEntity>> addToCart(
      {String? cartItemId, required String productId, required int amount});

  Future<ResponseWrapper<double>> getDistance(double startLatitude,
      double startLongtitude, double endLatitude, double endLongtitude);

  Future<ResponseWrapper<List<CheckinDetail>>> getJourney(
      JourneyRequest request);

  Future<ResponseWrapper<bool>> deleteCartItem(String cartItemId);

  Future<ResponseWrapper<int>> checkRole({String? username});

  Future<ResponseWrapper<bool>> checkSale(String? username, String agency);

  Future<ResponseWrapper<List<Customer>>> searchCustomerByRoute(
      String? routeId, String? search, int page);

  Future<ResponseWrapper<List<String>>> upload(List<XFile> images);

  Future<ResponseWrapper<List<EventEntity>>> getAllEvents({
    int page = 1,
    int pageSize = 999,
    int? typeCheck,
  });
}
