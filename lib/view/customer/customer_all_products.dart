import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../../domain/entity/ageny_product/agency_product.dart';
import '../../domain/entity/cart/agency_cart_item_entity/agency_cart_item_entity.dart';
import '../../domain/entity/cart/agency_cart_item_entity/agency_cart_product_entity.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_drop_down_form_field.dart';
import '../../shared/widgets/primary_search_text_field.dart';
import '../agency_page/cubit/agency_cubit.dart';
import 'cubit/customer_cubit.dart';

class CustomerAllProducts extends StatefulWidget {
  const CustomerAllProducts({super.key});

  @override
  State<CustomerAllProducts> createState() => _CustomerAllProductsState();
}

class _CustomerAllProductsState extends State<CustomerAllProducts> {
  final CustomerCubit cubit = getIt.get(instanceName: 'singleton');
  int page = 1;
  List<AgencyProduct> products = [];
  int save = 0;
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  Map<AgencyProduct, int> selected = {};
  int total = 0;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 1) {
        cubit.getAllProducts(page: ++page, search: searchController.text);
      }
    });

    cubit.getAllProducts(page: 1, search: searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimaryAppBar(
            backgroundColor: AppColor.white,
            centerTitle: true,
            leading: const BackButton(),
            style: AppTextTheme.titleMedium.copyWith(fontSize: 20),
            title: 'Danh sách sản phẩm'),
        body: BlocProvider.value(
            value: cubit,
            child: Stack(children: [
              SingleChildScrollView(
                  controller: scrollController,
                  child: Column(children: [
                    const SizedBox(height: 8),
                    Container(
                        color: AppColor.white,
                        constraints: BoxConstraints(maxWidth: context.screenWidth),
                        padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 8),
                        child: Row(children: [
                          Expanded(
                            child: SizedBox(
                                height: 40,
                                child: PrimarySearchTextField(
                                    controller: searchController,
                                    hintText: 'Nhập tên sản phẩm',
                                    onChanged: (_) {},
                                    prefixIcon: const Icon(Icons.search, color: AppColor.blue02),
                                    suffixIcon: const SizedBox())),
                          ),
                          const SizedBox(width: 16),
                          PrimaryButton(
                              backgroundColor: AppColor.blue02,
                              context: context,
                              onPressed: () {
                                page = 1;
                                products.clear();
                                selected.clear();
                                cubit.getAllProducts(search: searchController.text);
                              },
                              label: 'Tìm kiếm')
                        ])),
                    const SizedBox(height: 8),
                    BlocConsumer<CustomerCubit, CustomerState>(
                      listener: (context, state) {
                        if (state is CustomerGetAllProductsSuccess) {
                          products.addAll(state.products);
                        }
                      },
                      buildWhen: (previous, current) => current is CustomerGetAllProductsSuccess,
                      builder: (context, state) => ListView.separated(
                          itemBuilder: (context, index) => ProductItem(cubit: cubit, product: products[index]),
                          itemCount: products.length,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(color: AppColor.transparent, height: 10),
                          shrinkWrap: true),
                    ),
                    BlocBuilder<CustomerCubit, CustomerState>(
                        builder: (context, state) => state is CustomerInitial
                            ? const Column(children: [
                                SizedBox(height: 8),
                                CircularProgressIndicator(),
                              ])
                            : Container()),
                    const SizedBox(height: 8),
                    SizedBox(height: context.screenHeight * 0.12)
                  ])),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      constraints: BoxConstraints(maxHeight: context.screenWidth * 0.22, maxWidth: context.screenWidth),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            color: AppColor.black.withOpacity(0.1),
                            offset: const Offset(0, -2),
                            spreadRadius: 2)
                      ], color: AppColor.white),
                      padding: const EdgeInsets.all(16),
                      child: BlocConsumer<CustomerCubit, CustomerState>(
                          listener: (context, state) {
                            if (state is CustomerUpdateMoney) {
                              save += state.save;
                              save = save < 0 ? 0 : save;
                              total += state.total;
                              total = total < 0 ? 0 : total;

                              if (state.total > 0) {
                                selected.update(state.product, (value) => value + state.amount,
                                    ifAbsent: () => state.amount);
                              } else {
                                selected.remove(state.product);
                              }
                            }
                          },
                          buildWhen: (previous, current) => current is CustomerUpdateMoney,
                          builder: (context, state) {
                            return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Flexible(
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Row(children: [
                                  Text('Tổng thanh toán', style: AppTextTheme.bodyRegular.copyWith(fontSize: 18)),
                                  const Spacer(),
                                  Text('${Utils.formatNumber(total)}đ',
                                      style: AppTextTheme.textRed.copyWith(fontSize: 18))
                                ]),
                                const SizedBox(height: 8),
                                Row(children: [
                                  const Spacer(),
                                  Text('Tiết kiệm:   ', style: AppTextTheme.bodyDescription),
                                  Text('${Utils.formatNumber(save)}đ',
                                      style: AppTextTheme.textRed.copyWith(fontSize: 12))
                                ])
                              ])),
                              const SizedBox(width: 16),
                              Column(children: [
                                const Spacer(),
                                PrimaryButton(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    context: context,
                                    label: 'Mua hàng (${selected.length})',
                                    onPressed: () {
                                      if (total == 0) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => Center(
                                                    child: Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: Container(
                                                      decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(16)),
                                                          color: AppColor.white),
                                                      padding: const EdgeInsets.all(16),
                                                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                                                        const Text('Bạn chưa chọn sản phẩm nào',
                                                            style: AppTextTheme.titleMedium),
                                                        const SizedBox(height: 14),
                                                        PrimaryButton(
                                                            context: context,
                                                            onPressed: () => Navigator.pop(context),
                                                            label: 'Xong')
                                                      ])),
                                                )));
                                      } else {
                                        Navigator.pushNamed(context, AppRoute.agencyOrderProductPage,
                                            arguments: AgencyOderProductPageAgrs(
                                                agencyCubit: AgencyCubit(),
                                                cartItems: selected.entries
                                                    .map((e) => AgencyCartItemEntity(
                                                        amount: e.value,
                                                        product: AgencyCartProductEntity(
                                                            propertyId: e.key.id,
                                                            name: e.key.name,
                                                            price: e.key.price,
                                                            salePrice: e.key.salePrice,
                                                            images: e.key.images?.map((e) => e.image ?? '').toList())))
                                                    .toList(),
                                                customer: (context.arguments as CustomerAllProductsArgs).customer));
                                      }
                                    },
                                    textStyle: AppTextTheme.text70014.copyWith(color: AppColor.white)),
                                const Spacer()
                              ])
                            ]);
                          })))
            ])));
  }
}

// ignore: must_be_immutable
class ProductItem extends StatefulWidget {
  final CustomerCubit cubit;
  final AgencyProduct product;

  const ProductItem({super.key, required this.cubit, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool check = false;
  final propertyController = TextEditingController();
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final Set<String> productProperties =
        (widget.product.productProperties ?? []).asMap().entries.map((e) => "Phân loại: ${e.value.name}").toSet();

    return Container(
        color: AppColor.white,
        constraints: BoxConstraints(maxWidth: context.screenWidth),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: CheckboxListTile(
            activeColor: AppColor.blue02,
            checkColor: AppColor.white,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (_) {
              setState(() {
                check = _ ?? false;

                if (check) {
                  widget.cubit.updateMoney(quantity, quantity * (widget.product.salePrice ?? 0),
                      quantity * ((widget.product.price ?? 0) - (widget.product.salePrice ?? 0)), widget.product);
                } else {
                  widget.cubit.updateMoney(-quantity, -quantity * (widget.product.salePrice ?? 0),
                      -quantity * ((widget.product.price ?? 0) - (widget.product.salePrice ?? 0)), widget.product);
                }
              });
            },
            side: MaterialStateBorderSide.resolveWith((states) => states.contains(MaterialState.selected)
                ? const BorderSide(color: AppColor.blue02, width: 1)
                : const BorderSide(color: AppColor.gray06, width: 1)),
            title: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              widget.product.images == null || widget.product.images![0].image == ''
                  ? SizedBox(height: context.screenWidth * 0.2, width: context.screenWidth * 0.2)
                  : Image.network(widget.product.images?[0].image ?? '',
                      height: context.screenWidth * 0.2, width: context.screenWidth * 0.2),
              const SizedBox(width: 12),
              Flexible(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${widget.product.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: AppTextTheme.titleMedium.copyWith(fontSize: 18)),
                if (widget.product.productProperties != null)
                  Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)), color: AppColor.neutral5),
                      width: context.screenWidth / 2.5,
                      child: PrimaryDropDownFormField(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        controller: propertyController,
                        initialValue: productProperties.first,
                        items: productProperties.toList(),
                        textStyle: AppTextTheme.titleSmall,
                      )),
                Row(children: [
                  Text('${(widget.product.priceStr ?? '').replaceAll(RegExp(','), '.')}   ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: AppTextTheme.boldRegular.copyWith(
                          color: AppColor.black, decoration: TextDecoration.lineThrough, fontWeight: FontWeight.w400)),
                  Text((widget.product.salePriceStr ?? '').replaceAll(RegExp(','), '.'),
                      maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true, style: AppTextTheme.boldRegular),
                ]),
                SizedBox(
                    width: context.screenWidth * 0.3,
                    child: Row(children: [
                      Expanded(
                        child: PrimaryButton(
                            backgroundColor: AppColor.neutral5,
                            borderColor: AppColor.neutral5,
                            borderRadius: const BorderRadius.all(Radius.zero),
                            contentPadding: const EdgeInsets.symmetric(vertical: 3),
                            context: context,
                            label: '-',
                            onPressed: () => setState(() {
                                  quantity - 1 < 0 ? 0 : --quantity;

                                  if (check) {
                                    widget.cubit.updateMoney(-1, -(widget.product.salePrice ?? 0),
                                        -(widget.product.price ?? 0) + (widget.product.salePrice ?? 0), widget.product);
                                  }
                                }),
                            textStyle: AppTextTheme.titleSmall),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                              decoration: BoxDecoration(border: Border.all(color: AppColor.gray08)),
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text('$quantity',
                                  style: AppTextTheme.bodySmall.copyWith(color: AppColor.black),
                                  textAlign: TextAlign.center))),
                      Expanded(
                          child: PrimaryButton(
                              backgroundColor: AppColor.neutral5,
                              borderColor: AppColor.neutral5,
                              borderRadius: const BorderRadius.all(Radius.zero),
                              contentPadding: const EdgeInsets.symmetric(vertical: 3),
                              context: context,
                              label: '+',
                              onPressed: () => setState(() {
                                    ++quantity;

                                    if (check) {
                                      widget.cubit.updateMoney(
                                          1,
                                          widget.product.salePrice ?? 0,
                                          (widget.product.price ?? 0) - (widget.product.salePrice ?? 0),
                                          widget.product);
                                    }
                                  }),
                              textStyle: AppTextTheme.titleSmall))
                    ]))
              ]))
            ]),
            value: check));
  }
}
