import 'dart:math' hide log;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../config/config.dart';
import '../../../data/constants.dart';
import '../../../data/repository/local/local_data_access.dart';
import '../../../data/repository/remote/agency_repository.dart';
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
import '../../../domain/entity/cart/agency_cart_item_entity/agency_cart_product_entity.dart';
import '../../../domain/entity/customer/customer.dart';
import '../../../domain/entity/user_address/user_address.dart';
import '../../../domain/entity/voucher/validate_voucher_entity.dart';
import '../../../model/agency/agency_shipping_fee/get_shipping_fee_response.dart';
import '../../../model/api/base_response.dart';
import '../../../model/member/collaborator/collaborator_response.dart';
import '../../../shared/utils/utils.dart';

part 'agency_cubit.freezed.dart';
part 'agency_state.dart';

class AgencyCubit extends Cubit<AgencyState> {
  final AgencyRepository _agencyRepository = getIt.get();
  final LocalDataAccess _localDataAccess = getIt.get();

  AgencyCubit() : super(const AgencyState.initial());

  AgencyDetail agencyDetail = AgencyDetail();
  List<int> userRole = [];
  ConvertProductDimension? currentProductDimension;
  CollaboratorResponse? _collaboratorInfo;

  resetState() {
    emit(const AgencyState.initial());
  }

  resetData() {
    userRole = [];
    currentProductDimension = null;
    _collaboratorInfo = null;
  }

  getAgencyDetail() async {
    final response = await _agencyRepository.getDetailAgency();
    if (response.status == ResponseStatus.success) {
      agencyDetail = response.data!;
      emit(AgencyState.getDetailAgencySuccess(agencyDetail: agencyDetail));
    } else {
      emit(const AgencyState.getDetailAgencyFailed());
    }
  }

  getAllAgencyProducts({String? categoryId, int page = 1, pageSize = 10}) async {
    final response = await _agencyRepository.getAllAgencyProduct(
      page: page,
      pageSize: pageSize,
      categoryId: categoryId,
    );
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.getAllAgencyProductsSuccess(
          agencyProducts: response.data!..removeWhere((element) => element.status == 0)));
    } else {
      emit(const AgencyState.getDetailAgencyFailed());
    }
  }

  Future<AgencyProduct?> getProductDetail(String productId) async {
    final response = await _agencyRepository.getProductDetail(productId: productId);
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.getProductDetailSuccess(product: response.data!));
      return response.data!;
    } else {
      emit(const AgencyState.getProductDetailFailed());
    }
    return null;
  }

  Future<CollaboratorResponse?> getCollaboratorDetail() async {
    if (_collaboratorInfo != null) return _collaboratorInfo;
    final response = await _agencyRepository.getCollaboratorDetail();
    if (response.status == ResponseStatus.success) {
      _collaboratorInfo = response.data;
      return response.data;
    } else {
      return null;
    }
  }

  getAllAddressByUser({String agency = 'tanvietbook', String? userId}) async {
    final response = await _agencyRepository.getAllAddressByUser(agency: agency);
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.getAllAddressByUserSuccess(userAddress: response.data ?? []));
    } else {
      emit(const AgencyState.getAllAddressByUserFailed());
    }
  }

  addUserAddress({required UserAddress userAddress}) async {
    final response = await _agencyRepository.addUserAddress(userAddress: userAddress);
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.addUserAddressSuccess(userAddress: response.data!));
    } else {
      emit(const AgencyState.addUserAddressFailed());
    }
  }

  updateUserAddress({required UserAddress userAddress}) async {
    final response = await _agencyRepository.updateUserAddress(userAddress: userAddress);
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.addUserAddressSuccess(userAddress: userAddress));
    } else {
      emit(const AgencyState.addUserAddressFailed());
    }
  }

  deleteUserAddress({required UserAddress userAddress}) async {
    final response = await _agencyRepository.deleteUserAddress(id: userAddress.id!);
    if (response.status == ResponseStatus.success) {
      emit(const AgencyState.deleteUserAddressSuccess());
    } else {
      emit(const AgencyState.deleteUserAddressFailed());
    }
  }

  createOrder(AgencyOrderCreateRequest agencyOrderCreateRequest) async {
    final collaboratorInfo = await getCollaboratorDetail();
    agencyOrderCreateRequest.referralName = collaboratorInfo?.referralCode;
    final response = await _agencyRepository.createOrder(agencyOrderCreateRequest);
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.createOrderSuccess(response.data ?? ''));
    } else {
      emit(const AgencyState.createOrderFailed());
    }
  }

  getUserRole() async {
    final response = await _agencyRepository.getUserRole();

    if (response.status == ResponseStatus.success) {
      final userRoleResponse = response.data!;
      if (userRoleResponse.sale ?? false) {
        userRole.add(UserRole.sale);
      }
      if (userRoleResponse.ctv ?? false) {
        userRole.add(UserRole.collaborator);
      }
      if (userRoleResponse.user ?? false) {
        userRole.add(UserRole.user);
      }
    }
  }

  validateVoucher({
    required String code,
    required double totalProductPayment,
    required double shippingFee,
    List<AgencyCartProductEntity?>? products,
  }) async {
    final response = await _agencyRepository.validateVoucher(
      code: code,
      payment: totalProductPayment,
    );

    if (response.status == ResponseStatus.success) {
      final voucherValidate = response.data!;

      List<String> errorMessage = [];
      if (voucherValidate.errorMessage != null) {
        /// handle error
        if (voucherValidate.errorCode == VoucherStatus.deactive) {
          errorMessage.add('Mã giảm giá chưa thể áp dụng vào thời gian này');
        } else if (voucherValidate.errorCode == VoucherStatus.notExist) {
          errorMessage.add('Mã giảm giá không tồn tại');
        } else if (voucherValidate.errorCode == VoucherStatus.outOfVoucher) {
          errorMessage.add('Mã giảm giá hết lượt sử dụng. Vui lòng sử dụng mã giảm giá khác.');
        } else if (voucherValidate.errorCode == VoucherStatus.endOfUse) {
          errorMessage.add('Mã giảm giá đã được sử dụng');
        } else if (voucherValidate.errorCode == VoucherStatus.expired) {
          errorMessage.add('Mã giảm giá đã hết thời gian áp dụng');
        } else if (voucherValidate.errorCode == VoucherStatus.notStarted) {
          errorMessage.add('Mã giảm giá chưa đạt thời gian áp dụng');
        } else if (voucherValidate.errorCode == VoucherStatus.notMeetMinimumValue) {
          errorMessage.add('Đơn hàng chưa đạt giá trị tối thiểu');
        } else {
          errorMessage.add('${voucherValidate.errorMessage}');
        }
      } else {
        /// handle validate
        if (totalProductPayment < (voucherValidate.data?.minimumOrderCost ?? 0)) {
          errorMessage.add('Đơn hàng chưa đạt giá trị tối thiểu');
        }
        if ((voucherValidate.data?.maxCountInUse ?? 1) <= 0) {
          errorMessage.add('Mã giảm giá hết lượt sử dụng. Vui lòng sử dụng mã giảm giá khác.');
        }

        if (voucherValidate.data?.validDate != null) {
          final validDate = Utils.dateTimeFromString(voucherValidate.data?.validDate);

          if (validDate != null && validDate.difference(DateTime.now()).inMinutes > 0) {
            errorMessage.add(
                'Chưa đạt thời gian áp dụng: ${Utils.formatDate(voucherValidate.data?.validDate ?? '', showTime: true)}');
          }
        }

        if (voucherValidate.data?.unValidDate != null) {
          final invalidDate = Utils.dateTimeFromString(voucherValidate.data?.unValidDate);
          if (invalidDate != null && invalidDate.difference(DateTime.now()).inMinutes < 0) {
            errorMessage
                .add('Hết hạn sử dụng: ${Utils.formatDate(voucherValidate.data?.unValidDate ?? '', showTime: true)}');
          }
        }

        /// product validation
        if (voucherValidate.data?.productApply != null && (voucherValidate.data?.productApply as List).isNotEmpty) {
          final List<dynamic>? productIds = voucherValidate.data?.productApply!;
          products?.forEach((product) {
            if (productIds?.contains(product?.id) == false) {
              errorMessage.add('Mã giảm giá này không áp dụng cho sản phẩm ${product?.name}');
            }
          });
        }

        /// user_role validation
        if (userRole.isEmpty) {
          await getUserRole();
        }
        if (voucherValidate.data?.userApply != null && voucherValidate.data?.userApply != UserRole.all) {
          if (voucherValidate.data?.userApply == UserRole.user && !userRole.contains(UserRole.user) ||
              voucherValidate.data?.userApply == UserRole.sale && !userRole.contains(UserRole.sale) ||
              voucherValidate.data?.userApply == UserRole.collaborator && !userRole.contains(UserRole.collaborator)) {
            errorMessage.add('Mã giảm giá không áp dụng đối với tài khoản của bạn');
          } else if (voucherValidate.data?.userApply == UserRole.custom) {
            if ((voucherValidate.data?.listUserApply is List)) {
              if (!(voucherValidate.data?.listUserApply as List).contains(_localDataAccess.getUserName())) {
                errorMessage.add('Mã giảm giá không áp dụng đối với tài khoản của bạn');
              }
            }
          }
        }
      }

      if (errorMessage.isEmpty) {
        emit(AgencyState.validateVoucherSuccess(voucherValidate));
      } else {
        emit(AgencyState.validateVoucherFailed(errorMessage));
      }
    } else {
      emit(const AgencyState.validateVoucherFailed(['Áp dụng mã giảm giá không thành công']));
    }
  }

  Future<ConvertProductDimension?> _convertProductDimension(List<ConvertProductDimension> request) async {
    final response = await _agencyRepository.convertProductDimension(
      request,
    );
    if (response.status == ResponseStatus.success) {
      return response.data;
    } else {
      return null;
    }
  }

  getShippingFee(GetShippingFeeRequest request, List<AgencyCartItemEntity>? cartItems) async {
    if (cartItems != null) {
      {
        int totalProductPrice = 0;
        for (var element in cartItems) {
          totalProductPrice += (element.product?.salePrice ?? 0) * (element.amount ?? 1);
        }
        if (totalProductPrice >= 700000) {
          emit(AgencyState.getShippingFeeSuccess(GetShippingFeeResponse(data: GetShippingFeeData(moneyTotal: 0))));
          return;
        }
      }
    }
    if ((cartItems?.length ?? 0) > 1) {
      /// calculate total dimensions of all product

      if (currentProductDimension == null) {
        final List<ConvertProductDimension> convertProductDimensions = [];
        for (var element in cartItems!) {
          for (var i = 0; i < (element.amount ?? 0).toInt(); i++) {
            convertProductDimensions.add(
              ConvertProductDimension(
                productWeight: (element.product?.weight ?? 0).toInt(),
                productLenght: (element.product?.length ?? 0).toInt(),
                productWidth: (element.product?.width ?? 0).toInt(),
                productHeight: (element.product?.height ?? 0).toInt(),
              ),
            );
          }
        }

        currentProductDimension = await _convertProductDimension(convertProductDimensions);
      }

      request.productHeight = currentProductDimension?.productHeight;
      request.productWidth = currentProductDimension?.productWidth;
      request.productLength = currentProductDimension?.productLenght;
      request.productWeight = currentProductDimension?.productWeight;
    } else {
      if ((cartItems ?? []).isNotEmpty) {
        request.productHeight = (cartItems!.first.totalHeight ?? 0).toInt();
        request.productWidth = (cartItems.first.totalWidth ?? 0).toInt();
        request.productLength = (cartItems.first.totalLength ?? 0).toInt();
        request.productWeight = (cartItems.first.totalWeight ?? 0).toInt();
      }
    }

    final response = await _agencyRepository.getShippingFee(
      request: request,
    );
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.getShippingFeeSuccess(response.data!));
    } else {
      emit(const AgencyState.getShippingFeeFailed());
    }
  }

  changeCurrentUserAddress(UserAddress? userAddress) {
    emit(AgencyState.changeUserAddressSuccess(userAddress));
  }

  changeCurrentReceiverAddress(Customer? customer) {
    emit(AgencyState.changeReceiverAddressSuccess(customer));
  }

  changePaymentMethod(int paymentMethod) {
    emit(AgencyState.changePaymentMethodSuccess(paymentMethod));
  }

  changeShippingMethod(int shippingMethod, double shippingFee) {
    emit(AgencyState.changeShippingMethodSuccess(shippingMethod, shippingFee));
  }

  changePaymentInfo({
    double totalProductPayment = 0,
    double shippingFee = 0,
    VoucherValidateEntity? voucherValidate,
  }) {
    if (voucherValidate != null) {
      double finalTotalProductPayment = totalProductPayment;
      double finalShippingFee = shippingFee;
      double discount = 0;
      switch (voucherValidate.data?.type) {
        case VoucherType.percent:
          finalTotalProductPayment = totalProductPayment -
              min(totalProductPayment * (voucherValidate.data?.percent ?? 1) ~/ 100,
                  voucherValidate.data?.maxPromotion ?? 0x7FFFFFFFFFFFFFFF);
          discount = totalProductPayment - finalTotalProductPayment;
          break;
        case VoucherType.money:
          finalTotalProductPayment =
              totalProductPayment - min(totalProductPayment, (voucherValidate.data?.percent ?? 0).toDouble());
          discount = totalProductPayment - finalTotalProductPayment;
          break;
        case VoucherType.shipping:
          finalShippingFee = finalShippingFee - min(finalShippingFee, (voucherValidate.data?.percent ?? 0).toDouble());
          discount = shippingFee - finalShippingFee;
          break;
        default:
      }
      emit(AgencyState.changePaymentInfo(
        payment: finalTotalProductPayment + finalShippingFee,
        shippingFee: finalShippingFee,
        voucherValidate: voucherValidate,
        discount: discount,
      ));
    } else {
      emit(AgencyState.changePaymentInfo(
        payment: totalProductPayment + shippingFee,
        shippingFee: shippingFee,
        voucherValidate: voucherValidate,
      ));
    }
  }

  getAllOrders({
    String? userId,
    int page = 1,
    int pageSize = 10,
    int? status,
  }) async {
    final response = await _agencyRepository.getAllOrders(
      page: page,
      pageSize: pageSize,
      agency: AppConfig.agencyName,
      status: status,
    );
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.getAllOrderSuccess(response.data ?? []));
    } else {
      emit(const AgencyState.getAllOrderFailed());
    }
  }

  getOrderDetail(String orderId) async {
    final response = await _agencyRepository.getOrderDetail(orderId);
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.getOrderDetailSuccess(response.data!));
    } else {
      emit(const AgencyState.getOrderDetailFailed());
    }
  }

  updateOrderDetail(AgencyOrderDetail agencyOrderDetail) async {
    final response = await _agencyRepository.updateOrderDetail(agencyOrderDetail.id!, agencyOrderDetail.status!);
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.updateOrderDetailSuccess(agencyOrderDetail));
    } else {
      emit(const AgencyState.getOrderDetailFailed());
    }
  }

  getAllCategories({
    int page = 1,
    int pageSize = 10,
    int? status,
  }) async {
    final response = await _agencyRepository.getAlCategories(
      page: page,
      pageSize: pageSize,
      agency: AppConfig.agencyName,
    );
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.getAllCategorySuccess(response.data ?? []));
    } else {
      emit(const AgencyState.getAllCategoryFailed());
    }
  }

  getAllEvents({
    int page = 1,
    int pageSize = 999,
    int? typeCheck,
  }) async {
    final response = await _agencyRepository.getAllEvents(
      page: page,
      pageSize: pageSize,
      typeCheck: typeCheck,
    );
    if (response.status == ResponseStatus.success) {
      emit(AgencyState.getAllEventSuccess(response.data ?? []));
    } else {
      emit(const AgencyState.getAllEventFailed());
    }
  }

  void getComissionHistory({required int page, required int pageSize}) {}
}
