import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../domain/entity/user_address/user_address.dart';
import '../../domain/entity/voucher/validate_voucher_entity.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/dialog_helper.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../base/base_page_sate.dart';
import 'agency_order_list_page.dart';
import 'component/order_status_text.dart';
import 'component/payment_info_block.dart';
import 'component/user_address_item.dart';
import 'cubit/agency_cubit.dart';

class AgencyOrderDetailPage extends StatefulWidget {
  const AgencyOrderDetailPage({super.key});

  @override
  State<AgencyOrderDetailPage> createState() => _AgencyOrderDetailPageState();
}

class _AgencyOrderDetailPageState
    extends BasePageState<AgencyOrderDetailPage, AgencyCubit> {
  @override
  PreferredSizeWidget? get appBar => const PrimaryAppBar(
        title: 'Thông tin đơn hàng',
      );

  @override
  EdgeInsets get padding => const EdgeInsets.symmetric(vertical: 16);

  @override
  bool get useBlocProviderValue => true;

  @override
  bool get isUseLoading => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = context.arguments as AgencyGetOrderDetailPageAgrs;
    setCubit = args.agencyCubit;
    cubit.getOrderDetail(args.orderId);
  }

  @override
  void dispose() {
    super.dispose();
    cubit.resetState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<AgencyCubit, AgencyState>(
      listener: (context, state) {
        state.maybeWhen(
          updateOrderDetailSuccess: (agencyOrderDetail) {
            toastSuccess(AlertText.updateSuccess);
            context.pop();
          },
          orElse: () {},
        );
      },
      buildWhen: (previous, current) => current is AgencyGetOrderDetailSuccess,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Loading(),
          getOrderDetailSuccess: (agencyOrderDetail) {
            // calculate total salePrice
            double totalProductPrice = 0;
            agencyOrderDetail.products?.forEach((element) {
              totalProductPrice += (element.productPropertySalePrice ?? 0) *
                  (element.amount ?? 0);
            });

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icLocation,
                              color: AppColor.secondaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Thông tin khách hàng',
                                  style: AppTextTheme.bodyStrong,
                                ),
                                Text(
                                  agencyOrderDetail.orderMethod ==
                                          OrderMethod.forMe
                                      ? (' (Đặt cho tôi)')
                                      : '',
                                  style: AppTextTheme.bodySmall
                                      .copyWith(color: AppColor.gray05),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: UserAddressItem(
                            userAddress: UserAddress(
                              name: agencyOrderDetail.fullName,
                              phoneNumber: agencyOrderDetail.phoneNumber,
                              email: agencyOrderDetail.email,
                              address: agencyOrderDetail.address,
                              province: agencyOrderDetail.province,
                              district: agencyOrderDetail.district,
                              commune: agencyOrderDetail.commune,
                            ),
                            showLocationIcon: false,
                            showSettingButton: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  PrimaryContainer(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(Assets.icShipping),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phương thức vận chuyển',
                              style: AppTextTheme.bodyStrong,
                            ),
                            const SizedBox(height: 10),
                            Text(agencyOrderDetail.transportMethod ==
                                    TransportMethod.viettelPost
                                ? 'Vận chuyển bằng Viettel Post'
                                : 'Nhận hàng tại kho'),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  'Trạng thái: ',
                                ),
                                OrderStatusTextWidget(
                                    status: agencyOrderDetail.status,
                                    statusStr: agencyOrderDetail.statusStr),
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  PrimaryContainer(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(Assets.icDollar),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phương thức thanh toán',
                              style: AppTextTheme.bodyStrong,
                            ),
                            const SizedBox(height: 10),
                            Text(agencyOrderDetail.paymentMethodStr ?? ''),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  'Trạng thái: ',
                                ),
                                Text(
                                  '${agencyOrderDetail.paymentStatusStr}',
                                  style: AppTextTheme.bodyStrong.copyWith(
                                      color: agencyOrderDetail.paymentStatus ==
                                              PaymentStatus.paid
                                          ? AppColor.successColor
                                          : AppColor.secondaryColor),
                                ),
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    itemCount: agencyOrderDetail.products?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final orderItem = agencyOrderDetail.products?[index];
                      return PrimaryContainer(
                        padding: EdgeInsets.zero,
                        // backgroundColor: AppColor.primaryBackgroundContainer,
                        child: AgencyOrderItem(
                          item: orderItem!,
                          status: agencyOrderDetail.status ?? 1,
                          statusStr: agencyOrderDetail.statusStr ?? '',
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoute.agencyProductDetailPage,
                                arguments: AgencyProductDetailPageAgrs(
                                    agencyCubit: cubit,
                                    productId: agencyOrderDetail.id ?? ''));
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  PrimaryContainer(
                    padding: EdgeInsets.zero,
                    // backgroundColor: AppColor.primaryBackgroundContainer,
                    child: OrderPaymentInfo(
                      // agencyProduct: AgencyProduct(
                      //   name: agencyOrderDetail.productName,
                      //   price: agencyOrderDetail.price,
                      //   priceStr: Utils.formatMoney(
                      //       (agencyOrderDetail.price ?? 0).toDouble()),
                      // ),
                      // quantity: agencyOrderDetail.quantity ?? 0,
                      price: totalProductPrice.toInt(),
                      shipFee: agencyOrderDetail.transportFee,
                      totalPrice: agencyOrderDetail.payment ?? 0,
                      orderDate: agencyOrderDetail.createdDate,
                      voucherValidateDataEntity:
                          (agencyOrderDetail.discountCode == null ||
                                  agencyOrderDetail.discountCode!.isEmpty)
                              ? null
                              : VoucherValidateDataEntity(
                                  id: 'view',
                                  code: '${agencyOrderDetail.discountCode}'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (agencyOrderDetail.status == OrderStatus.pending)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PrimaryButton(
                        context: context,
                        backgroundColor: AppColor.white,
                        borderColor: AppColor.errorColor,
                        textStyle: AppTextTheme.textButtonPrimary
                            .copyWith(color: AppColor.errorColor),
                        onPressed: () {
                          context.showAppDialog(
                            getAlertDialog(
                                context: context,
                                title: 'Xác nhận',
                                message:
                                    'Bạn có chắc chắn muốn huỷ đơn hàng này',
                                onPositivePressed: () {
                                  showLoading();
                                  cubit.updateOrderDetail(
                                    agencyOrderDetail
                                      ..status = OrderStatus.canceled
                                      ..statusStr = OrderStatusStr.canceled,
                                  );
                                }),
                          );
                        },
                        label: 'Huỷ đơn hàng',
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
