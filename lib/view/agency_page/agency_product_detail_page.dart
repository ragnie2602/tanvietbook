import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_svg/svg.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../domain/entity/ageny_product/agency_product.dart';
import '../../domain/entity/cart/agency_cart_item_entity/agency_cart_item_entity.dart';
import '../../domain/entity/cart/agency_cart_item_entity/agency_cart_product_entity.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/image/primary_image.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_divider.dart';
import '../../shared/widgets/quill/primary_editor.dart';
import '../base/base_page_sate.dart';
import 'component/agency_product_container.dart';
import 'component/product_image_item.dart';
import 'component/quantity_widget.dart';
import 'cubit/agency_cubit.dart';
import 'cubit/cart_cubit.dart';

class AgencyProductDetailPage extends StatefulWidget {
  const AgencyProductDetailPage({super.key});

  @override
  State<AgencyProductDetailPage> createState() =>
      _AgencyProductDetailPageState();
}

class _AgencyProductDetailPageState
    extends BasePageState<AgencyProductDetailPage, AgencyCubit> {
  @override
  EdgeInsets get padding => EdgeInsets.zero;
  @override
  Color? get backgroundColor => AppColor.white;

  @override
  bool get useBlocProviderValue => true;

  @override
  bool get isUseLoading => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = context.arguments as AgencyProductDetailPageAgrs;
    setCubit = args.agencyCubit;
    cubit.getProductDetail(args.productId);
    cartCubit = context.read();
    cartCubit.getAllCartItems();
  }

  @override
  void dispose() {
    cubit.resetState();
    super.dispose();
  }

  late int q = 1;

  AgencyProductProperty? selectdProductProperty;
  late AgencyProduct product;
  late CartCubit cartCubit;
  late AgencyProductDetailPageAgrs args;

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: 'Chi tiết sản phẩm',
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoute.agencyCartPage);
            },
            child: BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) =>
                  current is ChangeCartItemListSize,
              builder: (context, state) {
                return Badge.count(
                  count: state is ChangeCartItemListSize ? state.size : 0,
                  isLabelVisible:
                      state is ChangeCartItemListSize && state.size > 0,
                  backgroundColor: AppColor.secondaryColor,
                  textColor: AppColor.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      Assets.icCart,
                      color: Colors.black,
                      height: 20,
                      width: 20,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: BlocBuilder<AgencyCubit, AgencyState>(
        buildWhen: (previous, current) =>
            current is GetProductDetailSuccess &&
            current.product.id == args.productId,
        builder: (context, state) {
          return state.maybeWhen(
              getProductDetailSuccess: (product) {
                this.product = product;
                if (product.productProperties != null &&
                    product.productProperties!.isNotEmpty) {
                  selectdProductProperty = product.productProperties?.first;
                }
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProductImageItemWidget(
                                  images: (product.images ??
                                          [AgencyProductImage(image: '')])
                                      .map((e) => e.image ?? '')
                                      .toList(),
                                  productStatus: product.status),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name ?? '',
                                      style: AppTextTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 10),
                                    ProductPriceItem(
                                      price: product.price,
                                      salePrice: product.salePrice,
                                    ),
                                  ],
                                ),
                              ),
                              const PrimaryDivider(
                                thickness: 6,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (product.productProperties != null)
                                      const Text(
                                        'Lựa chọn',
                                        style: AppTextTheme.bodyStrong,
                                      ),
                                    if (product.productProperties != null)
                                      const SizedBox(height: 10),
                                    if (product.productProperties != null)
                                      StatefulBuilder(
                                          builder: (subContext, innerSetState) {
                                        return Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: (product
                                                      .productProperties ??
                                                  [])
                                              .map((e) => InkWell(
                                                    onTap: () {
                                                      if (selectdProductProperty !=
                                                          e) {
                                                        innerSetState(() =>
                                                            selectdProductProperty =
                                                                e);
                                                      }
                                                    },
                                                    child: PrimaryContainer(
                                                      backgroundColor:
                                                          selectdProductProperty ==
                                                                  e
                                                              ? AppColor
                                                                  .primaryBackgroundContainer
                                                              : AppColor
                                                                  .neutral5,
                                                      borderColor:
                                                          selectdProductProperty ==
                                                                  e
                                                              ? AppColor
                                                                  .primaryColor
                                                              : AppColor
                                                                  .transparent,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          PrimaryNetworkImage(
                                                            imageUrl:
                                                                e.image ?? '',
                                                            height: 20,
                                                            width: 40,
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            e.name ?? '',
                                                            style: AppTextTheme
                                                                .bodyMedium,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        );
                                      }),
                                    if (product.productProperties != null)
                                      const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            'Số lượng',
                                            style: AppTextTheme.bodyStrong,
                                          ),
                                        ),
                                        QuantityWidget(
                                          initialQuantity: 1,
                                          onValueChanged: (quantity) {
                                            q = quantity;
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const PrimaryDivider(
                                thickness: 6,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Thông tin sản phẩm:',
                                      style: AppTextTheme.bodyStrong,
                                    ),
                                    const SizedBox(height: 10),
                                    PrimaryEditor(
                                      controller: QuillController.basic(),
                                      readOnly: true,
                                    )..controller.document =
                                        Utils.parseQuillDocument(
                                            product.description),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                      const PrimaryDivider(
                        thickness: 6,
                      ),
                      if (product.status != ProductStatus.outOfProduct &&
                          product.status != ProductStatus.outOfStock)
                        PrimaryContainer(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: BlocListener<CartCubit, CartState>(
                                  listener: (context, state) {
                                    if (state is AddToCartSuccess) {
                                      hideLoading();
                                      toastSuccess(
                                          'Thêm vào giỏ hàng thành công!');
                                    }
                                    if (state is AddToCartFailed) {
                                      hideLoading();
                                      toastSuccess(
                                          'Thêm vào giỏ hàng thất bại!');
                                    }
                                  },
                                  child: PrimaryButton(
                                    context: context,
                                    backgroundColor: AppColor.white,
                                    textStyle: AppTextTheme.textButtonPrimary
                                        .copyWith(color: AppColor.primaryColor),
                                    borderColor: AppColor.primaryColor,
                                    onPressed: () {
                                      showLoading();
                                      cartCubit.addToCart(
                                        productId: selectdProductProperty?.id ??
                                            product.id ??
                                            '',
                                        amount: q,
                                      );
                                    },
                                    label: 'Thêm vào giỏ hàng',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: PrimaryButton(
                                  context: context,
                                  isClickable: false,
                                  onPressed: () {
                                    if (q <= 0) {
                                      toastWarning(
                                          'Bạn chưa cập nhật số lượng sản phẩm!');
                                      return;
                                    }

                                    Navigator.pushNamed(
                                      context,
                                      AppRoute.agencyOrderProductPage,
                                      arguments: AgencyOderProductPageAgrs(
                                        cartItems: [
                                          AgencyCartItemEntity(
                                            amount: q,
                                            product: AgencyCartProductEntity(
                                              id: product.id,
                                              name: product.name,
                                              price: product.price,
                                              salePrice: product.salePrice,
                                              propertyId:
                                                  selectdProductProperty?.id,
                                              productPropertyName:
                                                  selectdProductProperty?.name,
                                              productPropertyImage:
                                                  selectdProductProperty?.image,
                                              images: product.images
                                                  ?.map((e) => e.image ?? '')
                                                  .toList(),
                                              height: product.height,
                                              width: product.width,
                                              length: product.length,
                                              weight: product.weight,
                                            ),
                                            totalHeight:
                                                (product.height ?? 0) * q,
                                            totalWidth: (product.width ?? 0),
                                            totalLength: (product.length ?? 0),
                                            totalWeight:
                                                (product.weight ?? 0) * q,
                                          )
                                        ],
                                        agencyCubit: cubit,
                                      ),
                                    );
                                  },
                                  label: 'Mua ngay',
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
              orElse: () => const Loading());
        },
      ),
    );
  }
}
