import '../../domain/entity/agency/agency_detail.dart';
import '../../domain/entity/agency_order_detail/agency_order_detail.dart';
import '../../domain/entity/agency_order_detail/product_order_entity.dart';
import '../../domain/entity/ageny_product/agency_product.dart';
import '../../domain/entity/voucher/validate_voucher_entity.dart';
import '../../model/agency/agency_detail_response/agency_detail_response.dart';
import '../../model/agency/agency_order_detail_response/agency_order_detail_response.dart';
import '../../model/agency/agency_product_response/agency_product_response.dart';
import '../../model/agency/voucher/voucher_validate_response.dart';
import '../../shared/utils/utils.dart';
import '../constants.dart';
import 'base_data_mapper.dart';

class AgencyDetailMapper
    extends BaseDataMapper<AgencyDetailResponse, AgencyDetail> {
  @override
  AgencyDetail mapToEntity(AgencyDetailResponse? data) {
    return AgencyDetail(
      id: data?.id,
      name: data?.name,
      shortName: data?.shortName,
      domain: data?.domain,
      logo: data?.logo,
      background: data?.background,
      color: data?.color,
      description: data?.description,
      field: data?.field,
      address: data?.address,
      agency: data?.agency,
      path: data?.path
          ?.map((e) => AgencyPath(
                id: e.id,
                title: e.title,
                value: e.value,
                agencyInfoId: e.agencyInfoId,
                type: e.type,
                error: e.error,
              ))
          .toList(),
      listAgencyCateProd: data?.listAgencyCateProd
          ?.map((e) => AgencyCategoryProduct(
                name: e.name,
                link: e.link,
                image: e.image,
                description: e.description,
                agency: e.agency,
              ))
          .toList(),
      pdf: data?.pdf,
      instruction: data?.instruction,
    );
  }
}

class AgencyProductDataMapper
    extends BaseDataMapper<AgencyProductResponse, AgencyProduct> {
  @override
  AgencyProduct mapToEntity(AgencyProductResponse? data) {
    return AgencyProduct(
      id: data?.id,
      sku: data?.sku,
      name: data?.name,
      price: (data?.price ?? 0).toInt(),
      priceStr: Utils.formatMoney(data?.price ?? 0),
      salePrice: (data?.salePrice ?? 0).toInt(),
      salePriceStr: Utils.formatMoney((data?.salePrice ?? 0).toDouble()),
      status: data?.status,
      urlVideo: data?.urlVideo,
      titleVideo: data?.titleVideo,
      images: data?.images
          ?.map((e) => AgencyProductImage(
                id: e.id,
                productId: e.productId,
                image: e.image,
              ))
          .toList(),
      productProperties: data?.productProperties
          ?.map(
            (e) => AgencyProductProperty(
              id: e.id,
              name: e.name,
              image: e.image,
              productId: e.productId,
            ),
          )
          .toList(),
      hidden: data?.hidden,
      groupProdName: data?.groupProdName,
      feeShip: (data?.feeShip ?? 0).toInt(),
      feeShipStr: Utils.formatMoney((data?.feeShip ?? 0).toDouble()),
      description: data?.description,
      createdDate: data?.createdDate,
      weight: data?.weight,
      length: data?.length,
      width: data?.width,
      height: data?.height,
    );
  }
}

class AgencyOrderDataMapper
    extends BaseDataMapper<AgencyOrderDetailResponse, AgencyOrderDetail> {
  @override
  AgencyOrderDetail mapToEntity(AgencyOrderDetailResponse? data) {
    final bool isOrderForCustomer = data?.receiverId != null;
    return AgencyOrderDetail(
      id: data!.id,
      // sku: data?.sku,
      status: data.status,
      statusStr: _getStatusStrByType(data.status),
      userName: data.userName,
      userId: data.userId,
      transportFee: data.transportFee,
      transportMethod: data.transportMethod,
      // transactionId: data.transactionId,
      referralName: data.referralName,
      products: data.productOrders
          ?.map((e) => ProductOrderEntity(
                amount: e.amount,
                productName: e.product?.name,
                productPropertyId: e.product?.propertyId,
                productPropertyName: e.product?.productPropertyName,
                productPropertyImage: e.product?.productPropertyImage ??
                    ((e.product?.images != null &&
                            e.product!.images!.isNotEmpty)
                        ? e.product!.images!.first
                        : ''),
                productPropertyPrice: e.product?.price ?? 0,
                productPropertySalePrice: e.product?.salePrice ?? 0,
              ))
          .toList(),

      phoneNumber:
          isOrderForCustomer ? data.receiverPhoneNumber : data.phoneNumber,
      paymentStatus: data.paymentStatus,
      paymentStatusStr: _getPaymentStatusStrByType(data.paymentStatus),
      payment: data.payment?.toInt(),
      paymentMethod: data.paymentMethod,
      paymentMethodStr: _getPaymentMethodStrByType(data.paymentMethod),
      orderCode: data.orderCode,
      orderMethod: data.orderMethod,
      fullName: isOrderForCustomer ? data.receiverName : data.fullName,
      email: isOrderForCustomer ? data.receiverEmail : data.email,
      province: isOrderForCustomer ? data.receiverProvince : data.province,
      district: isOrderForCustomer ? data.receiverDistrict : data.district,
      commune: isOrderForCustomer ? data.receiverCommune : data.commune,
      address: isOrderForCustomer ? data.receiverAddress : data.address,
      createdDate: data.createdDate,
      discountCode: data.discountCode,
      note: data.note,
      transactionId: data.transportId,
    );
  }

  String? _getStatusStrByType(int? status) {
    switch (status) {
      case OrderStatus.pending:
        return OrderStatusStr.pending;
      case OrderStatus.packaging:
        return OrderStatusStr.packaging;
      case OrderStatus.delivering:
        return OrderStatusStr.delivering;
      case OrderStatus.delivered:
        return OrderStatusStr.delivered;
      case OrderStatus.canceled:
        return OrderStatusStr.canceled;
      case OrderStatus.refunded:
        return OrderStatusStr.refunded;

      default:
        return '';
    }
  }

  String? _getPaymentStatusStrByType(int? status) {
    switch (status) {
      case PaymentStatus.notPaid:
        return PaymentStatusStr.notPaid;
      case PaymentStatus.paid:
        return PaymentStatusStr.paid;
      case PaymentStatus.canceled:
        return PaymentStatusStr.canceled;
      default:
        return '';
    }
  }

  String? _getPaymentMethodStrByType(int? method) {
    switch (method) {
      case PaymentMethod.cash:
        return PaymentMethodStr.cash;
      case PaymentMethod.internetBanking:
        return PaymentMethodStr.internetBanking;
      default:
        return '';
    }
  }
}

class AgencyVoucherValidateDataMapper
    extends BaseDataMapper<VoucherValidateResponse, VoucherValidateEntity> {
  @override
  VoucherValidateEntity mapToEntity(VoucherValidateResponse? data) {
    return VoucherValidateEntity(
      success: data?.success,
      errorCode: data?.errorCode,
      errorMessage: data?.errorCode == '-1'
          ? 'Mã giảm giá không tồn tại'
          : data?.errorMessage,
      data: VoucherValidateDataEntity(
        id: data?.data?.id,
        code: data?.data?.code,
        codeName: data?.data?.codeName,
        status: data?.data?.status,
        minimumOrderCost: data?.data?.minimumOrderCost,
        maxCountInUse: data?.data?.maxCountInUse,
        validDate: data?.data?.validDate,
        unValidDate: data?.data?.unValidDate,
        type: data?.data?.type,
        percent: data?.data?.percent,
        maxPromotion: data?.data?.maxPromotion,
        description: data?.data?.description,
        coinChange: data?.data?.coinChange,
        memberClass: data?.data?.memberClass,
        productApply: data?.data?.productApply,
        error: data?.data?.error,
        promotionMethod: data?.data?.promotionMethod,
        productGroupApplyArr: data?.data?.productGroupApplyArr,
        orderApply: data?.data?.orderApply,
        validate: data?.data?.validate,
        userApply: data?.data?.userApply,
        listUserApply: data?.data?.listUserApply,
      ),
    );
  }
}
