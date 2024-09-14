import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/config.dart';
import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/repository/local/local_data_access.dart';
import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';
import '../../di/di.dart';
import '../../domain/entity/agency_order_create_request/agency_get_shipping_fee_request.dart';
import '../../domain/entity/agency_order_create_request/agency_order_create_request.dart';
import '../../domain/entity/agency_order_create_request/product_order_c.dart';
import '../../domain/entity/customer/customer.dart';
import '../../domain/entity/user_address/user_address.dart';
import '../../domain/entity/voucher/validate_voucher_entity.dart';
import '../../shared/bloc/get_image/get_image_bloc.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/dialog_helper.dart';
import '../../shared/widgets/image/primary_image.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../base/base_page_sate.dart';
import '../customer/cubit/customer_cubit.dart';
import 'component/agency_product_container.dart';
import 'component/payment_info_block.dart';
import 'component/payment_method_block.dart';
import 'component/shipping_method_block.dart';
import 'component/user_address_block.dart';
import 'component/voucher_block.dart';
import 'cubit/agency_cubit.dart';
import 'cubit/cart_cubit.dart';

class AgencyOrderProductPage extends StatefulWidget {
  const AgencyOrderProductPage({super.key});

  @override
  State<AgencyOrderProductPage> createState() => _AgencyOrderProductPageState();
}

class _AgencyOrderProductPageState extends BasePageState<AgencyOrderProductPage, AgencyCubit> {
  @override
  PreferredSizeWidget? get appBar => const PrimaryAppBar(
        title: 'Thông tin đơn hàng',
      );
  @override
  EdgeInsets get padding => EdgeInsets.zero;
  @override
  bool get useBlocProviderValue => true;

  @override
  bool get isUseLoading => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = context.arguments as AgencyOderProductPageAgrs;
    setCubit = args.agencyCubit;
    if (!_isInitialized) {
      cubit.getAllAddressByUser();
      _isInitialized = true;
    }
    _setUpOrderRequest();
  }

  @override
  void dispose() {
    cubit.currentProductDimension = null;
    super.dispose();
  }

  void _setUpOrderRequest() async {
    Future.delayed(const Duration(milliseconds: 300)).then((value) => cubit.changePaymentMethod(PaymentMethod.cash));

    agencyOrderCreateRequest ??= AgencyOrderCreateRequest(
        agency: AppConfig.agencyName,
        orderCode: '',
        note: '',
        status: OrderStatus.pending,
        paymentStatus: PaymentStatus.notPaid,
        productOrderCs: args.cartItems
            ?.map((e) => ProductOrderC(
                  amount: e.amount,
                  productPropertyId: e.product?.propertyId ?? e.product?.id,
                ))
            .toList(),
        transportMethod: ShippingMethod.viettelPost,
        paymentMethod: PaymentMethod.cash,
        orderMethod: OrderMethod.forMe);
    getShippingFeeRequest = GetShippingFeeRequest(orderService: 'VSL7');
  }

  late AgencyOderProductPageAgrs args;
  AgencyOrderCreateRequest? agencyOrderCreateRequest;
  late GetShippingFeeRequest getShippingFeeRequest;
  final GetImageBloc _getImageBloc = GetImageBloc();
  bool isOrderForCustomer = false;
  int currentPayment = -1;
  double initialShippingFee = -1;
  double currentShippingFee = -1;
  VoucherValidateEntity? currentVoucherValidate;
  bool _isInitialized = false;

  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider(
      create: (context) => _getImageBloc,
      lazy: false,
      child: MultiBlocListener(
        listeners: [
          BlocListener<GetImageBloc, GetImageState>(
            listener: (context, state) {
              if (state is GetImageGetImageUrlSuccessState) {
                agencyOrderCreateRequest!.image = state.imageUrl;
                agencyOrderCreateRequest!.paymentStatus = PaymentStatus.paid;
                cubit.createOrder(agencyOrderCreateRequest!);
              }
              if (state is GetImageGetImageUrlErrorState) {
                hideLoading();
              }
            },
          ),
          BlocListener<AgencyCubit, AgencyState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                getAllAddressByUserSuccess: (userAddresses) {
                  if (userAddresses.isEmpty) {
                    cubit.changeCurrentUserAddress(null);
                  } else {
                    final UserAddress userAddress = userAddresses.firstWhere(
                      (element) => element.status == AddressStatus.main,
                      orElse: () => userAddresses.first,
                    );
                    cubit.changeCurrentUserAddress(userAddress);
                  }
                },
                changeUserAddressSuccess: (userAddress) {
                  agencyOrderCreateRequest!
                    ..province = userAddress?.province
                    ..district = userAddress?.district
                    ..commune = userAddress?.commune
                    ..address = userAddress?.address
                    ..fullName = userAddress?.name
                    ..phoneNumber = userAddress?.phoneNumber
                    ..email = userAddress?.email
                    ..userName = getIt.get<LocalDataAccess>().getUserName()
                    ..receiverAddress = userAddress?.province
                    ..receiverCommune = userAddress?.district
                    ..receiverDistrict = userAddress?.commune
                    ..receiverProvince = userAddress?.address
                    ..receiverEmail = userAddress?.email
                    ..receiverName = userAddress?.name
                    ..receiverPhoneNumber = userAddress?.phoneNumber
                    ..receiverId = userAddress?.id;

                  cubit.getShippingFee(
                      getShippingFeeRequest
                        ..senderAddress = AppConfig.agencySenderAddress
                        ..receiverAddress = Utils.formatAddress(
                          userAddress?.address,
                          userAddress?.commune,
                          userAddress?.district,
                          userAddress?.province,
                        ),
                      args.cartItems);
                },
                changeReceiverAddressSuccess: (Customer? customer) {
                  agencyOrderCreateRequest!
                    ..receiverAddress = customer?.address
                    ..receiverCommune = customer?.commune
                    ..receiverDistrict = customer?.district
                    ..receiverProvince = customer?.province
                    ..receiverEmail = customer?.email
                    ..receiverName = customer?.fullname
                    ..receiverPhoneNumber = customer?.mobile
                    ..receiverId = customer?.id;

                  print(agencyOrderCreateRequest);

                  cubit.getShippingFee(
                    getShippingFeeRequest
                      ..senderAddress = AppConfig.agencySenderAddress
                      ..receiverAddress = Utils.formatAddress(
                        customer?.address,
                        customer?.commune,
                        customer?.district,
                        customer?.province,
                      ),
                    args.cartItems,
                  );
                },
                changeShippingMethodSuccess: (method, shippingFee) {
                  agencyOrderCreateRequest!.transportMethod = method;
                  double totalProductPayment = 0;
                  args.cartItems?.forEach((element) {
                    totalProductPayment += (element.product?.salePrice ?? 0) * (element.amount ?? 0);
                  });
                  initialShippingFee = shippingFee;
                  currentShippingFee = shippingFee;

                  cubit.changePaymentInfo(
                    totalProductPayment: totalProductPayment,
                    shippingFee: initialShippingFee,
                    voucherValidate: currentVoucherValidate,
                  );
                },
                changePaymentMethodSuccess: (paymentMethod) {
                  agencyOrderCreateRequest!.paymentMethod = paymentMethod;
                },
                changePaymentInfo: (payment, shippingFee, discount, voucherValidate) {
                  currentPayment = payment.toInt();
                  currentShippingFee = shippingFee;
                  agencyOrderCreateRequest!.transportFee = shippingFee.toInt();

                  agencyOrderCreateRequest!.payment = currentPayment;
                },
                createOrderSuccess: (orderId) {
                  hideLoading();
                  toastSuccess('Tạo đơn hàng thành công');
                  Future.delayed(const Duration(milliseconds: 150)).then(
                    (value) => Navigator.of(context).pushReplacementNamed(AppRoute.agencyOrderProductSuccessPage),
                  );
                  context.read<CartCubit>().deleteCartItem(
                        '',
                        deleteFromLocal: true,
                        productIds: args.cartItems?.map((e) => e.product?.id ?? '').toList(),
                      );
                  if (args.customer != null) {
                    getIt.get<CustomerCubit>(instanceName: 'singleton').createOrderWhileCheckin(orderId);
                  }
                },
                createOrderFailed: () {
                  hideLoading();
                  toastWarning('Tạo đơn hàng thất bại');
                },
                deleteUserAddressSuccess: () => cubit.getShippingFee(
                  GetShippingFeeRequest(orderService: 'VSL7'),
                  args.cartItems,
                ),
                getShippingFeeSuccess: (shippingFeeResponse) {
                  if (currentPayment == -1) {
                    cubit.changeShippingMethod(
                        ShippingMethod.viettelPost, (shippingFeeResponse.data?.moneyTotal ?? 0).toDouble());
                    currentShippingFee = (shippingFeeResponse.data?.moneyTotal ?? 0).toDouble();
                  }
                },
                validateVoucherSuccess: (voucherValidate) {
                  hideLoading();
                  if (voucherValidate.errorMessage != null) {
                    toastWarning(voucherValidate.errorMessage!);
                  } else {
                    toastSuccess('Áp dụng mã giảm giá thành công!');
                  }

                  double totalProductPayment = 0;
                  args.cartItems?.forEach((element) {
                    totalProductPayment += (element.product?.salePrice ?? 0) * (element.amount ?? 0);
                  });

                  currentVoucherValidate = voucherValidate;
                  agencyOrderCreateRequest!.typeVoucher = int.tryParse(voucherValidate.data?.id ?? '');
                  agencyOrderCreateRequest!.discountCode = voucherValidate.data?.code;
                  cubit.changePaymentInfo(
                    totalProductPayment: totalProductPayment,
                    shippingFee: initialShippingFee,
                    voucherValidate: currentVoucherValidate,
                  );
                },
                validateVoucherFailed: (errorMessage) {
                  hideLoading();
                  _showValidateVoucherFailedDialog(errorMessage ?? []);
                },
              );
            },
          )
        ],
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                        children: (args.cartItems ?? [])
                            .map(
                              (e) => PrimaryContainer(
                                padding: const EdgeInsets.all(16),
                                backgroundColor: AppColor.primaryColor.withOpacity(.1),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: PrimaryNetworkImage(
                                        imageUrl: e.product?.productPropertyImage != null &&
                                                e.product!.productPropertyImage!.isNotEmpty
                                            ? e.product!.productPropertyImage
                                            : e.product?.images != null && e.product!.images!.isNotEmpty
                                                ? e.product!.images?.first
                                                : '',
                                        height: 120,
                                        width: 120,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.product?.name ?? '',
                                              style: AppTextTheme.bodyStrong,
                                              maxLines: 2,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Số lượng: ${e.amount}',
                                              style: AppTextTheme.bodyMedium,
                                              maxLines: 2,
                                            ),
                                            const SizedBox(height: 10),
                                            if (e.product?.productPropertyName != null &&
                                                (e.product?.productPropertyName ?? '').isNotEmpty)
                                              Text(
                                                'Phân loại: ${e.product?.productPropertyName}',
                                                style: AppTextTheme.bodyMedium,
                                                maxLines: 2,
                                              ),
                                            if (e.product?.productPropertyName != null &&
                                                (e.product?.productPropertyName ?? '').isNotEmpty)
                                              const SizedBox(height: 10),
                                            ProductPriceItem(
                                              price: e.product?.price,
                                              salePrice: e.product?.salePrice,
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            )
                            .toList()),
                    const SizedBox(height: 10),
                    UserAddressBlock(
                        customer: args.customer,
                        isOrderForCustomerChanged: (isOrderForCustomer) {
                          this.isOrderForCustomer = isOrderForCustomer;
                          agencyOrderCreateRequest?.orderMethod =
                              isOrderForCustomer ? OrderMethod.forCustomer : OrderMethod.forMe;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    VoucherBlock(
                      onApplied: (code) => _onVoucherApplied(code),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<AgencyCubit, AgencyState>(
                      buildWhen: (previous, current) => current is AgencyGetShippingFeeSuccess,
                      builder: (context, state) {
                        return ShippingMethodBlock(
                          shipFee: 0,
                          agencyDetail: cubit.agencyDetail,
                        );
                      },
                    ),
//
                    const SizedBox(
                      height: 10,
                    ),
                    UserPaymentBlock(
                      shipFee: 0,
                      agencyDetail: cubit.agencyDetail,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<AgencyCubit, AgencyState>(
                      buildWhen: (previous, current) => current is ChangePaymentInfoState,
                      builder: (context, state) {
                        return state.maybeWhen(
                          changePaymentInfo: (payment, shippingFee, discount, voucherValidate) {
                            int totalProductPrice = 0;
                            for (var element in args.cartItems!) {
                              totalProductPrice += (element.product?.salePrice ?? 0) * (element.amount ?? 1);
                            }
                            return OrderPaymentInfo(
// agencyProduct: args.product,
// quantity: e.amount,
                              shipFee: initialShippingFee.toInt(),
                              totalPrice: payment.toInt(),
                              price: totalProductPrice,
                              discount: discount.toInt(),
                              voucherValidateDataEntity: voucherValidate?.data,
                            );
                          },
                          orElse: () => const SizedBox(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            PrimaryContainer(
              padding: const EdgeInsets.all(16.0),
// backgroundColor: AppColor.white,
              child: BlocBuilder<AgencyCubit, AgencyState>(
                buildWhen: (previous, current) => current is ChangePaymentInfoState,
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state.maybeWhen(
                      changePaymentInfo: (payment, shippingFee, discount, voucherValidate) {
                        return Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                children: [
                                  const Text(
                                    'Tổng giá: ',
                                  ),
                                  Text(
                                    Utils.formatMoney(payment.toDouble()),
                                    style: AppTextTheme.bodyStrong.copyWith(color: AppColor.secondaryColor),
                                  ),
                                ],
                              ),
                            ),
                            PrimaryButton(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                context: context,
                                onPressed: _onCreateOrder,
                                label: 'Đặt hàng')
                          ],
                        );
                      },
                      orElse: () => const SizedBox(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _onVoucherApplied(code) {
    showLoading();

    int totalProductPrice = 0;
    for (var element in args.cartItems!) {
      totalProductPrice += (element.product?.salePrice ?? 0) * (element.amount ?? 1);
    }

    cubit.validateVoucher(
      code: code,
      totalProductPayment: totalProductPrice.toDouble(),
      shippingFee: currentShippingFee.toDouble(),
      products: args.cartItems?.map((e) => e.product).toList(),
    );
  }

  _onCreateOrder() async {
    // agencyOrderCreateRequest.productPropertyId =
    //     args.productProperty?.id ?? args.product.id;
    if (isOrderForCustomer &&
        (agencyOrderCreateRequest!.receiverId == null || agencyOrderCreateRequest!.receiverId!.isEmpty)) {
      toastWarning('Bạn chưa chọn khách hàng');
      return;
    }
    if (agencyOrderCreateRequest!.paymentMethod == PaymentMethod.internetBanking) {
      if (_getImageBloc.imageData.first.type == ImageDataType.addNew) {
        toastWarning('Hình ảnh thanh toán là bắt buộc');
      } else {
        showLoading();
        _getImageBloc
            .add(GetImageGetImageUrlEvent(imagePath: _getImageBloc.imageData.first.data, imageType: ImageType.none));
      }
    } else {
      showLoading();
      if (args.customer != null) {
        agencyOrderCreateRequest!.receiverAddress = args.customer!.address;
        agencyOrderCreateRequest!.receiverCommune = args.customer!.commune;
        agencyOrderCreateRequest!.receiverDistrict = args.customer!.district;
        agencyOrderCreateRequest!.receiverEmail = args.customer!.email;
        agencyOrderCreateRequest!.receiverId = args.customer!.id;
        agencyOrderCreateRequest!.receiverName = args.customer!.fullname;
        agencyOrderCreateRequest!.receiverPhoneNumber = args.customer!.mobile;
        agencyOrderCreateRequest!.receiverProvince = args.customer!.province;
        agencyOrderCreateRequest!.orderMethod = 1;
      }
      cubit.createOrder(agencyOrderCreateRequest!);
    }
  }

  void _showValidateVoucherFailedDialog(List<String> errorMessage) {
    context.showAppDialog(
      getErrorDialog(
        context: context,
        message: '',
        messageWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: errorMessage
              .map(
                (e) => Row(
                  children: [
                    const Icon(
                      Icons.error_outline_sharp,
                      color: AppColor.errorColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(
                      e,
                      style: AppTextTheme.bodyStrong,
                    )),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
