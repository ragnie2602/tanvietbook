import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repository/remote/agency_repository.dart';
import '../../../di/di.dart';
import '../../../domain/entity/ageny_product/agency_product.dart';
import '../../../domain/entity/checkin/checkin_detail.dart';
import '../../../domain/entity/checkin/purpose.dart';
import '../../../domain/entity/customer/customer.dart';
import '../../../model/api/base_response.dart';
import '../../../model/checkin/journey_request.dart';
import '../../../model/customer/customer_response.dart';
import '../../../model/route.dart';
import '../../../shared/utils/utils.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final AgencyRepository agencyRepository = getIt.get();

  CustomerCubit() : super(CustomerInitial());

  addCustomer(CustomerResponse customer) async {
    final response = await agencyRepository.addCustomer(customer);

    if (response.status == ResponseStatus.success) {
      emit(CustomerAddCustomerSuccess(response.data ?? Customer()));
    } else {
      emit(CustomerAddCustomerFailed());
    }
  }

  checkin(Customer customer, String location, double latitude, double longitude) async {
    final response = await agencyRepository.checkin(customer, location, latitude, longitude);

    if (response.status == ResponseStatus.success) {
      emit(CustomerCheckinSuccess(response.data ?? ''));
    } else {
      emit(CustomerCheckinFailed());
    }
  }

  checkRole({String? username}) async {
    emit(CustomerInitial());

    final response = await agencyRepository.checkRole(username: username);

    if (response.status == ResponseStatus.success) {
      emit(CustomerCheckRoleSuccess(response.data ?? 0));
    } else {
      emit(CustomerCheckRoleFailed());
    }
  }

  checkout(
      {String? checkinId,
      List<XFile>? images,
      double? latitude,
      List<String>? listOrderId,
      String? location,
      double? longitude,
      String? notes,
      String? purpose}) async {
    ResponseWrapper<List<String>>? imageResponse;

    if (images != null && images.isNotEmpty) {
      imageResponse = await agencyRepository.upload(images);

      if (imageResponse.status == ResponseStatus.error) {
        emit(CustomerUploadMediaFailed());
        return;
      }
    }

    final response = await agencyRepository.checkout(
        checkinId: checkinId ?? '',
        imageLinks: imageResponse?.data ?? [],
        latitude: latitude ?? 0.0,
        location: location ?? '',
        longitude: longitude ?? 0.0,
        notes: notes ?? '',
        purpose: purpose ?? '',
        listOrderId: listOrderId);

    if (response.status == ResponseStatus.success) {
      emit(CustomerCheckoutSuccess());
    } else {
      emit(CustomerCheckoutFailed());
    }
  }

  createOrderWhileCheckin(String orderId) {
    emit(CustomerCreateOrderWhileCheckin(orderId));
  }

  editCustomer(CustomerResponse customer) async {
    final response = await agencyRepository.editCustomer(customer);

    if (response.status == ResponseStatus.success) {
      emit(CustomerEditCustomerSuccess(response.data!));
    } else {
      emit(CustomerEditCustomerFailed());
    }
  }

  getAllDistricts(String provinceId) async {
    emit(CustomerGetAllDistrictFailed());

    final response = await agencyRepository.getAllDistricts(provinceId);

    if (response.status == ResponseStatus.success) {
      emit(CustomerGetAllDistrictSuccess(response.data ?? []));
    } else {
      emit(CustomerGetAllDistrictFailed());
    }
  }

  getAllProducts({int page = 1, String? search}) async {
    emit(CustomerInitial());

    final response = await agencyRepository.getAllProducts(page: page, search: search);

    if (response.status == ResponseStatus.success) {
      emit(CustomerGetAllProductsSuccess(response.data ?? []));
    } else {
      emit(CustomerGetAllProductFailed());
    }
  }

  getAllProvince() async {
    final response = await agencyRepository.getAllProvinces();

    if (response.status == ResponseStatus.success) {
      emit(CustomerGetAllProvincesSuccess(response.data ?? []));
    } else {
      emit(CustomerGetAllProvincesFailed());
    }
  }

  getAllPurpose() async {
    final response = await agencyRepository.getAllPurpose();

    if (response.status == ResponseStatus.success) {
      emit(CustomerGetAllPurposeSuccessState(response.data ?? []));
    } else {
      emit(CustomerGetAllPurposesFailedState());
    }
  }

  /// isCurrent = true: get current user's route
  getAllRoutes({bool isCurrent = false}) async {
    final response = await agencyRepository.getAllRoutes(isCurrent: isCurrent);

    if (response.status == ResponseStatus.success) {
      emit(CustomerGetAllRoutesSuccessState(response.data ?? []));
    } else {
      emit(CustomerGetAllRoutesFailedState());
    }
  }

  getAllWards(String districtId) async {
    emit(CustomerGetAllWardFailed());

    final response = await agencyRepository.getAllWards(districtId);

    if (response.status == ResponseStatus.success) {
      emit(CustomerGetAllWardSuccess(response.data ?? []));
    } else {
      emit(CustomerGetAllWardFailed());
    }
  }

  getCheckinDetail(String id) async {
    final response = await agencyRepository.getCheckinDetail(id);

    if (response.status == ResponseStatus.success) {
      emit(CustomerGetCheckinDetailSuccess(response.data));
    } else {
      emit(CustomerGetCheckinDetailFailed());
    }
  }

  getCustomer(String id) async {
    final response = await agencyRepository.getCustomer(id);

    if (response.status == ResponseStatus.success) {
      emit(CustomerGetCustomerSuccess(response.data!));
    } else {
      emit(CustomerGetCustomerFailed());
    }
  }

  getDistance(double startLatitude, double startLongtitude, double endLatitude, double endLongtitude) async {
    emit(CustomerGetDistanceSuccess(Utils.distanceBetween(startLatitude, startLongtitude, endLatitude, endLongtitude)));
  }

  getJourneys(JourneyRequest request) async {
    emit(CustomerInitial());

    final response = await agencyRepository.getJourney(request);

    if (response.status == ResponseStatus.success) {
      emit(CustomerGetJourneySuccess(response.data ?? []));
    } else {
      emit(CustomerGetJourneyFailed());
    }
  }

  searchCustomerByRoute(String? routeId, {String? search, int page = 1}) async {
    emit(CustomerInitial());

    final response = await agencyRepository.searchCustomerByRoute(routeId, search, page);

    if (response.status == ResponseStatus.success) {
      emit(CustomerSearchCustomerByRouteSuccess(response.data ?? []));
    } else {
      emit(CustomerSearchCustomerByRouteFailed());
    }
  }

  updateMoney(int amount, int total, int save, AgencyProduct product) {
    emit(CustomerInitial());
    emit(CustomerUpdateMoney(amount: amount, product: product, save: save, total: total));
  }
}
