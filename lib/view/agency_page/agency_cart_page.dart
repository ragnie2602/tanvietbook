import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../domain/entity/ageny_product/agency_product.dart';
import '../../domain/entity/cart/agency_cart_item_entity/agency_cart_item_entity.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/button/primary_group_checkbox.dart';
import '../../shared/widgets/container/primary_container.dart';
import '../../shared/widgets/dialog_helper.dart';
import '../../shared/widgets/image/primary_image.dart';
import '../../shared/widgets/image/primary_svg_picture.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/no_data.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_divider.dart';
import '../base/base_page_sate.dart';
import 'component/agency_product_container.dart';
import 'component/quantity_widget.dart';
import 'cubit/agency_cubit.dart';
import 'cubit/cart_cubit.dart';

class AgencyCartPage extends StatefulWidget {
  const AgencyCartPage({super.key});

  @override
  State<AgencyCartPage> createState() => _AgencyCartPageState();
}

class _AgencyCartPageState extends BasePageState<AgencyCartPage, CartCubit> {
  @override
  bool get isUseLoading => true;

  @override
  bool get useBlocProviderValue => true;
  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  Color? get backgroundColor => AppColor.white;

  @override
  PreferredSizeWidget? get appBar =>
      const PrimaryAppBar(title: 'Giỏ hàng', actions: []);

  @override
  void initState() {
    super.initState();
    setCubit = context.read();
    cubit.getAllCartItems(force: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  int? status;

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        state.maybeWhen(
          addToCartSuccess: (agencyCartItemEntity) {
            hideLoading();
          },
          addToCartFailed: () {
            hideLoading();
            toastWarning(AlertText.error);
          },
          deleteCartItemSuccess: (id) {
            hideLoading();
            toastSuccess(AlertText.deleteSuccess);
          },
          deleteCartItemFailed: () {
            hideLoading();
          },
          orElse: () {},
        );
      },
      buildWhen: (previous, current) => current is AllCartItemsSuccess,
      builder: (context, state) {
        return state.maybeWhen(getAllCartItemsSuccess: (items) {
          if (items.isEmpty) return const NoData();
          return RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: () async {
              cubit.getAllCartItems(force: true);
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => CartItemWidget(
                      agencyCartItemEntity: items[index],
                      onItemChecked: (checked) {
                        if (checked) {
                          cubit.selectedItems.add(items[index]);
                        } else {
                          cubit.selectedItems.remove(items[index]);
                        }
                        cubit.changeTotalPrice();
                      },
                      onQuantityChanged: (quantity) {
                        cubit.changeTotalPrice();
                      },
                      onPropertyChanged: (productProperty) {
                        showLoading();
                        cubit.addToCart(
                          cartItemId: items[index].id,
                          productId: productProperty.id ?? '',
                          productPropertyId: productProperty.id,
                          productPropertyName: productProperty.name,
                          amount: 0,
                        );
                      },
                      actionAfterValueChanged: (quantity) {
                        showLoading();
                        cubit.addToCart(
                          cartItemId: items[index].id,
                          productId: items[index].product?.propertyId ??
                              items[index].product?.id ??
                              '',
                          amount: quantity,
                        );
                      },
                      onDeletePressed: () {
                        showLoading();
                        cubit.deleteCartItem(items[index].id ?? '');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Text('Tổng thanh toán: '),
                            const Spacer(),
                            BlocBuilder<CartCubit, CartState>(
                              buildWhen: (previous, current) =>
                                  current is ChangeTotalPriceSuccess,
                              builder: (context, state) {
                                return Text(
                                  Utils.formatMoney(
                                      ((state is ChangeTotalPriceSuccess)
                                              ? state.total
                                              : 0)
                                          .toDouble()),
                                  style: AppTextTheme.bodyStrong
                                      .copyWith(color: AppColor.red),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      PrimaryButton(
                        context: context,
                        label: 'Mua hàng',
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoute.agencyOrderProductPage,
                              arguments: AgencyOderProductPageAgrs(
                                agencyCubit: context.read(),
                                cartItems: cubit.selectedItems,
                              ));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }, orElse: () {
          return const Loading();
        });
      },
    );
  }
}

class CartItemWidget extends StatefulWidget {
  final AgencyCartItemEntity agencyCartItemEntity;
  final Function(bool value) onItemChecked;
  final Function(int quantity) onQuantityChanged;
  final Function(AgencyProductProperty productProperty) onPropertyChanged;
  final Function(int quantity) actionAfterValueChanged;
  final Function() onDeletePressed;
  const CartItemWidget(
      {super.key,
      required this.agencyCartItemEntity,
      required this.onItemChecked,
      required this.onQuantityChanged,
      required this.actionAfterValueChanged,
      required this.onPropertyChanged,
      required this.onDeletePressed});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryGroupCheckbox(
                initialValue: const [false],
                onChanged: (value) {
                  widget.onItemChecked.call(value[0]);
                },
                items: const [''],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: PrimaryNetworkImage(
                  imageUrl: (widget.agencyCartItemEntity.product != null &&
                          widget.agencyCartItemEntity.product!.images != null &&
                          widget
                              .agencyCartItemEntity.product!.images!.isNotEmpty)
                      ? widget.agencyCartItemEntity.product!.images!.first
                      : '',
                  width: 60,
                  height: 60,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.agencyCartItemEntity.product?.name ?? '',
                            style: AppTextTheme.bodyStrong,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //
                            context.showAppDialog(
                              getAlertDialog(
                                context: context,
                                title: AlertText.confirm,
                                message: AlertText.alertDeleteText,
                                onPositivePressed: () {
                                  widget.onDeletePressed.call();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Xoá',
                            style: AppTextTheme.textButtonPrimary.copyWith(
                              color: const Color(0xFFBABABA),
                              decoration: TextDecoration.underline,
                              decorationColor: const Color(0xFFBABABA),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryContainer(
                      backgroundColor: AppColor.neutral5.withOpacity(.5),
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Phân loại: ',
                            style: AppTextTheme.bodyMedium,
                          ),
                          Expanded(
                            child: DropdownSearch<AgencyProductProperty>(
                              asyncItems: (text) async {
                                final productDetail = await context
                                    .read<AgencyCubit>()
                                    .getProductDetail(widget
                                            .agencyCartItemEntity.product?.id ??
                                        '');
                                final propertyList =
                                    productDetail?.productProperties;
                                return propertyList ?? [];
                              },

                              selectedItem: AgencyProductProperty(
                                  name: widget.agencyCartItemEntity.product
                                      ?.productPropertyName),
                              // selectedItem: ,
                              itemAsString: (item) => '${item.name}',
                              onChanged: (value) {
                                widget.agencyCartItemEntity.product
                                    ?.propertyId = value?.id;
                                widget.onPropertyChanged.call(value!);
                              },
                              dropdownButtonProps: const DropdownButtonProps(
                                icon: PrimarySvgPicture(Assets.iconArrowDown),
                              ),

                              dropdownDecoratorProps: DropDownDecoratorProps(
                                baseStyle: AppTextTheme.bodyRegular.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                ),
                                dropdownSearchDecoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor),
                                  ),
                                  isDense: true,
                                  isCollapsed: false,
                                  constraints: BoxConstraints(maxHeight: 32),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 8),
                                ),
                                textAlign: TextAlign.left,
                              ),

                              // dropdownBuilder: (context, selectedItem) {
                              //   return Text(selectedItem?.name ?? '');
                              // },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ProductPriceItem(
                      salePrice: widget.agencyCartItemEntity.product?.salePrice,
                      price: widget.agencyCartItemEntity.product?.price,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    QuantityWidget(
                      onValueChanged: (quantity) {
                        widget.agencyCartItemEntity.amount = quantity;
                        widget.onQuantityChanged.call(quantity);
                      },
                      actionAfterValueChanged: (quantity) {
                        widget.actionAfterValueChanged.call(quantity);
                      },
                      debounce: 1000,
                      initialQuantity: widget.agencyCartItemEntity.amount,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const PrimaryDivider(
            thickness: 4,
          ),
        ],
      ),
    );
  }
}
