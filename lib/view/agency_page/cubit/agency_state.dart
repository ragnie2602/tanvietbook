part of 'agency_cubit.dart';

@Freezed(equal: false)
class AgencyState with _$AgencyState {
  const factory AgencyState.initial() = _Initial;
  const factory AgencyState.getDetailAgencySuccess(
      {required AgencyDetail agencyDetail}) = DetailAgencySuccess;
  const factory AgencyState.getDetailAgencyFailed() = _DetailAgencyFailed;
  const factory AgencyState.getAllAgencyProductsSuccess(
          {required List<AgencyProduct> agencyProducts}) =
      GetAllAgencyProductSuccess;
  const factory AgencyState.getAllAgencyProductsFailed() =
      GetAllAgencyProductFailed;

  const factory AgencyState.getProductDetailSuccess(
      {required AgencyProduct product}) = GetProductDetailSuccess;
  const factory AgencyState.getProductDetailFailed() = GetProductDetailFailed;

  const factory AgencyState.getAllAddressByUserSuccess(
      {required List<UserAddress> userAddress}) = GetAllUserAddresslSuccess;
  const factory AgencyState.getAllAddressByUserFailed() =
      GetAllUserAddressFailed;
  const factory AgencyState.addUserAddressSuccess(
      {required UserAddress userAddress}) = AgencyAddUserAddresslSuccess;
  const factory AgencyState.addUserAddressFailed() =
      AgencyAddUserAddresslFailed;

  const factory AgencyState.deleteUserAddressSuccess() =
      AgencyDeleteUserAddresslSuccess;
  const factory AgencyState.deleteUserAddressFailed() =
      AgencyDeleteUserAddresslFailed;

  const factory AgencyState.createOrderSuccess(String orderId) =
      AgencyCreateOrderSuccess;
  const factory AgencyState.createOrderFailed() = AgencyCreateOrderFailed;

  const factory AgencyState.validateVoucherSuccess(
      VoucherValidateEntity voucherValidate) = AgencyValidateVoucherSuccess;
  const factory AgencyState.validateVoucherFailed(List<String>? errorMessage) =
      AgencyValidateVoucherFailed;

  const factory AgencyState.getShippingFeeSuccess(
      GetShippingFeeResponse shippingFeeResponse) = AgencyGetShippingFeeSuccess;
  const factory AgencyState.getShippingFeeFailed() = AgencyGetShippingFeeFailed;

  const factory AgencyState.getOrderDetailSuccess(
      AgencyOrderDetail agencyOrderDetail) = AgencyGetOrderDetailSuccess;
  const factory AgencyState.getOrderDetailFailed() = AgencyGetOrderDetailFailed;

  const factory AgencyState.updateOrderDetailSuccess(
      AgencyOrderDetail agencyOrderDetail) = AgencyUpdateOrderDetailSuccess;
  const factory AgencyState.updateOrderDetailFailed() =
      AgencyUpdateOrderDetailFailed;

  const factory AgencyState.getAllOrderSuccess(List<AgencyOrderDetail> orders) =
      AgencyGetAllOrderSuccess;
  const factory AgencyState.getAllOrderFailed() = AgencyGetAllOrderFailed;

  const factory AgencyState.getAllCategorySuccess(
      List<AgencyCategory> categories) = AgencyGetAllAgencyCategorySuccess;
  const factory AgencyState.getAllCategoryFailed() =
      AgencyGetAllAgencyCategoryFailed;

  const factory AgencyState.changePaymentMethodSuccess(int paymentMethod) =
      ChangePaymentMethodSuccess;

  const factory AgencyState.changeShippingMethodSuccess(
      int method, double shippingFee) = ChangeShippingMethodSuccess;

  const factory AgencyState.changeUserAddressSuccess(UserAddress? userAddress) =
      ChangeUserAddressSuccess;

  const factory AgencyState.changeReceiverAddressSuccess(Customer? customer) =
      ChangeReceiverAddressSuccess;

  const factory AgencyState.changePaymentInfo({
    @Default(0) double payment,
    @Default(0) double shippingFee,
    @Default(0) double discount,
    VoucherValidateEntity? voucherValidate,
  }) = ChangePaymentInfoState;

  const factory AgencyState.getAllEventSuccess(List<EventEntity>? events) =
      AgencyGetAllEventSuccess;
  const factory AgencyState.getAllEventFailed() = AgencyGetAllEventFailed;

  const factory AgencyState.getEventSuccess(EventEntity? event) =
      AgencyGetEventSuccess;
  const factory AgencyState.getEventFailed() = AgencyGetEventFailed;
}
