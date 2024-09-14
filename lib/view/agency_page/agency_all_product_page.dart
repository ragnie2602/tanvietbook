import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../domain/entity/agency_category/agency_category.dart';
import '../../domain/entity/ageny_product/agency_product.dart';
import '../../shared/widgets/back_button.dart';
import '../../shared/widgets/list_view/primary_paged_grid_view.dart';
import '../../shared/widgets/loading.dart';
import 'component/agency_product_container.dart';
import 'component/product_image_item.dart';
import 'cubit/agency_cubit.dart';

class AgencyAllProduct extends StatefulWidget {
  final AgencyCubit agencyCubit;
  final ScrollController? scrollController;
  final bool? showAppBar;
  final AgencyCategory? agencyCategory;
  final BuildContext? parrentContext;
  const AgencyAllProduct(
      {super.key,
      required this.agencyCubit,
      this.scrollController,
      this.showAppBar,
      this.agencyCategory,
      this.parrentContext});

  @override
  State<AgencyAllProduct> createState() => _AgencyAllProductState();
}

class _AgencyAllProductState extends State<AgencyAllProduct> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.agencyCubit.getAllAgencyProducts(categoryId: widget.agencyCategory?.id);

    pagingController.addPageRequestListener((pageKey) {
      widget.agencyCubit.getAllAgencyProducts(
        page: pageKey,
        categoryId: widget.agencyCategory?.id,
      );
    });
  }

  @override
  bool get wantKeepAlive => true;

  final PagingController<int, AgencyProduct> pagingController = PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<AgencyCubit, AgencyState>(
      listener: (context, state) {
        state.maybeWhen(
            getAllAgencyProductsSuccess: (agencyProducts) {
              if (agencyProducts.length < 10) {
                pagingController
                    .appendLastPage(agencyProducts.toList()..removeWhere((element) => element.hidden == true));
              } else {
                pagingController.appendPage(agencyProducts.toList()..removeWhere((element) => element.hidden == true),
                    pagingController.nextPageKey! + 1);
              }
              context.read<AgencyCubit>().resetState();
            },
            orElse: () {});
      },
      buildWhen: (previous, current) => current is GetAllAgencyProductSuccess,
      builder: (context, state) {
        return state.maybeWhen(
          getAllAgencyProductsSuccess: (agencyProducts) {
            return Container(
              color: AppColor.white,
              child: Column(
                children: [
                  if (widget.showAppBar ?? false)
                    Row(
                      children: [
                        const BackButtonCustom(),
                        Expanded(
                          child: Text(
                            widget.agencyCategory?.name ?? '',
                            style: AppTextTheme.bodyStrong.copyWith(overflow: TextOverflow.ellipsis),
                            // textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  Expanded(
                    child: PrimaryPagedGridView(
                      // physics: const NeverScrollableScrollPhysics(),
                      // scrollController: widget.scrollController,
                      itemBuilder: (context, item, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              widget.parrentContext ?? context,
                              AppRoute.agencyProductDetailPage,
                              arguments: AgencyProductDetailPageAgrs(productId: item.id!, agencyCubit: context.read()),
                            );
                          },
                          child: Card(
                            // margin: const EdgeInsets.only(right: 20, left: 12),
                            // backgroundColor: AppColor.white,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(2),
                            // ),
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProductImageItemWidget(
                                  images: (item.images ?? []).map((e) => e.image ?? '').toList(),
                                  productStatus: item.status,
                                ),
                                // const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${item.name ?? ''}\n',
                                        maxLines: 2,
                                        style: AppTextTheme.bodyRegular.copyWith(overflow: TextOverflow.ellipsis),
                                      ),
                                      const SizedBox(height: 4),
                                      ProductPriceItem(
                                        salePrice: item.salePrice,
                                        price: item.price,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      pagingController: pagingController,
                      onRefresh: () {
                        pagingController.refresh();
                        context.read<AgencyCubit>().resetState();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          orElse: () {
            return const Loading();
          },
        );
      },
    );
  }
}
