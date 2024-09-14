import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/constants.dart';
import '../../../data/resources/resources.dart';
import '../../../domain/entity/voucher/validate_voucher_entity.dart';
import '../../../shared/etx/view_extensions.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/image/primary_svg_picture.dart';
import '../../../shared/widgets/primary_button.dart';

class OrderPaymentInfo extends StatelessWidget {
  // final AgencyProduct agencyProduct;
  // final int quantity;
  final int? shipFee;
  final int? discount;
  final int price;
  final int totalPrice;
  final String? orderDate;
  final VoucherValidateDataEntity? voucherValidateDataEntity;
  const OrderPaymentInfo(
      {super.key,
      // required this.agencyProduct,
      // required this.quantity,
      required this.totalPrice,
      required this.price,
      this.shipFee,
      this.orderDate,
      this.discount,
      this.voucherValidateDataEntity});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(Assets.icDollar),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Chi tiết thanh toán',
                style: AppTextTheme.bodyStrong,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // OrderPaymentInfoItem(
          //   title: 'Giá bán',
          //   value: (agencyProduct.salePrice != null)
          //       ? agencyProduct.salePriceStr ?? ''
          //       : agencyProduct.priceStr ?? '',
          // ),
          // OrderPaymentInfoItem(
          //   title: 'Số lượng',
          //   value: quantity.toString(),
          // ),
          OrderPaymentInfoItem(
            title: 'Thành tiền sản phẩm',
            value: Utils.formatMoney(price.toDouble()),
          ),
          OrderPaymentInfoItem(
            title: 'Phí vận chuyển',
            value: shipFee == 0
                ? 'Miễn phí'
                : Utils.formatMoney((shipFee ?? 0).toDouble()),
          ),
          OrderPaymentInfoItem(
            title:
                'Mã giảm giá${voucherValidateDataEntity?.id == 'view' ? ' (${voucherValidateDataEntity?.code})' : ''}',
            value:
                '- ${Utils.formatMoney(voucherValidateDataEntity?.id == 'view' ? (-totalPrice + price + (shipFee ?? 0)).toDouble() : (discount ?? 0).toDouble())}',
            subTitle: voucherValidateDataEntity == null ||
                    voucherValidateDataEntity?.id == 'view'
                ? const SizedBox()
                : GestureDetector(
                    onTap: () => _onVoucherTapped.call(
                        context, voucherValidateDataEntity),
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ' (${voucherValidateDataEntity?.codeName}) ',
                          style: AppTextTheme.bodyRegular
                              .copyWith(color: AppColor.gray03),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.info,
                            size: 14,
                            color: AppColor.secondaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          if (orderDate != null)
            OrderPaymentInfoItem(
              title: 'Thời gian đặt hàng',
              value: Utils.formatDate(orderDate!, showTime: true),
            ),
          // OrderPaymentInfoItem(
          //   title: 'Mã giảm giá',
          //   value: agencyProduct.priceStr ?? '',
          // ),
          OrderPaymentInfoItem(
            title: 'Tổng thanh toán',
            value: Utils.formatMoney(totalPrice.toDouble()),
            textStyle: AppTextTheme.titleMedium
                .copyWith(color: AppColor.red, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  _onVoucherTapped(BuildContext context,
      VoucherValidateDataEntity? voucherValidateDataEntity) {
    String voucherPromotionText = '';
    String minOrderPaymentText = '';
    String maxOrderPaymentText = '';

    if (voucherValidateDataEntity?.type == VoucherType.percent) {
      voucherPromotionText =
          'Giảm ${voucherValidateDataEntity?.percent ?? 0 * 100}%';
    }
    if (voucherValidateDataEntity?.type == VoucherType.money) {
      voucherPromotionText =
          'Giảm ${Utils.formatMoney((voucherValidateDataEntity?.percent ?? 0).toDouble())}';
    }
    if (voucherValidateDataEntity?.type == VoucherType.shipping) {
      voucherPromotionText =
          'Giảm ${Utils.formatMoney((voucherValidateDataEntity?.percent ?? 0).toDouble())} phí vận chuyển';
    }

    minOrderPaymentText =
        'Đơn tối thiểu ${Utils.formatMoney((voucherValidateDataEntity?.minimumOrderCost ?? 0).toDouble())}';
    maxOrderPaymentText =
        'Giảm tối đa ${Utils.formatMoney((voucherValidateDataEntity?.maxPromotion ?? 0).toDouble())}';
    context.showAppDialog(Dialog(
      child: PrimaryContainer(
        backgroundColor: AppColor.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const PrimarySvgPicture(Assets.icVoucher),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  voucherPromotionText,
                  style: AppTextTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              // '$minOrderPaymentText - $maxOrderPaymentText',
              minOrderPaymentText,
              style: AppTextTheme.bodyRegular,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Mã Code: ',
                      style: AppTextTheme.bodyStrong,
                    ),
                    Text('${voucherValidateDataEntity?.codeName}',
                        style: AppTextTheme.bodyRegular),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Text(
                      'Hạn sử dụng: ',
                      style: AppTextTheme.bodyStrong,
                    ),
                    if (voucherValidateDataEntity?.validDate != null)
                      Text(
                          'Từ ${Utils.formatDate(voucherValidateDataEntity?.validDate ?? '')} đến ',
                          style: AppTextTheme.bodyRegular),
                    if (voucherValidateDataEntity?.unValidDate != null)
                      Text(
                          Utils.formatDate(
                              voucherValidateDataEntity?.unValidDate ?? ''),
                          style: AppTextTheme.bodyRegular),
                    if (voucherValidateDataEntity?.unValidDate == null)
                      const Text(
                        'Không thời hạn',
                        style: AppTextTheme.bodyRegular,
                      ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mô tả khuyến mại:',
                      style: AppTextTheme.bodyStrong,
                    ),
                    Text('${voucherValidateDataEntity?.description}',
                        style: AppTextTheme.bodyRegular),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                PrimaryButton(
                  context: context,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: 'Đóng',
                  // textStyle: AppTextTheme.textButtonPrimary
                  //     .copyWith(color: AppColor.secondaryColor),
                  // backgroundColor: AppColor.white,
                  // borderColor: AppColor.secondaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class OrderPaymentInfoItem extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? textStyle;
  final Widget? subTitle;
  const OrderPaymentInfoItem(
      {super.key,
      required this.title,
      required this.value,
      this.textStyle,
      this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textStyle ?? AppTextTheme.bodyMedium,
          ),
          if (subTitle != null) subTitle!,
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: textStyle ??
                  AppTextTheme.bodyStrong.copyWith(color: AppColor.red),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
