import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/routes.dart';
import '../../../data/resources/resources.dart';
import '../../../model/business/product/product_detail_response.dart';
import '../../../shared/etx/view_extensions.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../../../shared/widgets/primary_button.dart';
import '../bloc/business_update_bloc.dart';

import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/button/app_button.dart';
import '../../../shared/widgets/text_field/search_with_filter.dart';
import '../../../shared/widgets/dialog_helper.dart';
import '../bloc/business_bloc.dart';
import '../category_manage/bloc/category_manage_bloc/category_manage_bloc.dart';
import 'component/business_manage_filter.dart';
import 'component/product_manage_item.dart';

class BusinessManageProductPage extends StatelessWidget {
  const BusinessManageProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BusinessProductManageArgs;

    final BusinessBloc businessBloc = BusinessBloc();
    late BusinessUpdateBloc businessUpdateBloc = BusinessUpdateBloc();

    late final ScrollController scrollController = ScrollController();

    businessBloc.currentBusinessSubTabId = args.subTabId;
    businessBloc.businessManageFilterData = BusinessManageFilterData(
      subTabId: args.subTabId,
      currentCategoryId: [args.categoryId ?? ''],
      currentCategoryName: [args.categoryName ?? ''],
    );
    // categoryManageBloc.currentSubTabId = args.subTabId;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => businessBloc
            ..add(BusinessGetAllProductEvent(
                // if has categoryId, this page is navigated from categories manage screen
                categoryId: args.categoryId,
                pageNum: 1,
                pageSize: 100)),
        ),
        BlocProvider(
          create: (context) => businessUpdateBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColor.white,
        floatingActionButton: FabAnimationButton(
          scrollController: scrollController,
          children: [
            FloatingActionButton(
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  AppRoute.businessUpdateProduct,
                  arguments: BusinessUpdateProductArgs(
                      isAddNew: true, subTabId: args.subTabId),
                ).then((value) {
                  if (value == null) return;
                  businessBloc.add(BusinessAddNewProductEvent(
                      productDetailResponse: value as ProductDetailResponse));
                  Future.delayed(const Duration(milliseconds: 100)).then(
                      (value) => scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300)));
                });
              },
              backgroundColor: AppColor.primaryColor,
              child: const Icon(Icons.add, color: AppColor.white),
            )
          ],
        ),
        appBar: PrimaryAppBar(
          title: 'Quản lí bài đăng',
          actions: [
            Center(
              child: Wrap(
                children: [
                  PrimaryButton(
                    context: context,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.businessProductRearrange,
                        arguments: BusinessProductRearrangeArgs(
                          businessBloc: businessBloc,
                        ),
                      );
                    },
                    label: 'Sắp xếp vị trí',
                    backgroundColor: AppColor.white,
                    borderColor: AppColor.primaryColor,
                    textStyle: AppTextTheme.textPrimaryColor,
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
            )
          ],
        ),
        body: SafeArea(
          child: NestedScrollView(
            controller: scrollController,
            physics: const PageScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              final categoryManageBloc = CategoryManageBloc();
              return [
                SliverAppBar(
                  expandedHeight: 120,
                  flexibleSpace: FlexibleSpaceBar(
                    background: TextFieldSearchWithFilter(
                      initialFilterValue: args.categoryName,
                      filterWidget: PostManageFilter(
                        businessManageFilterData:
                            businessBloc.businessManageFilterData,
                        categoryManageBloc: categoryManageBloc,
                        businessBloc: businessBloc,
                      ),
                      onDispose: (hasFilterChanged) {
                        if (hasFilterChanged == null) return;
                        businessBloc.add(BusinessInitialEvent());
                        businessBloc.add(BusinessGetAllProductEvent(
                          pageNum: 1,
                          pageSize: 999999999,
                          // categoryId:
                          //     businessManageFilterData.currentCategoryId
                        ));
                      },
                    ),
                  ),
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  // pinned: true,
                  floating: true,
                  snap: true,
                ),
              ];
            },
            body: MultiBlocListener(
              listeners: [
                BlocListener<BusinessUpdateBloc, BusinessUpdateState>(
                  listener: (context, state) {
                    if (state is BusinessUpdateProductSuccessState) {}
                  },
                ),
                BlocListener<BusinessBloc, BusinessState>(
                  listener: (context, state) {
                    if (state is BusinessDeleteProductDetailSuccessState) {
                      Navigator.of(context).pop();
                      toastSuccess(AlertText.deleteSuccess);
                    }
                    if (state is BusinessDeleteProductDetailFailedState) {
                      Navigator.of(context).pop();
                      toastWarning(AlertText.deleteFailed);
                    }
                  },
                ),
              ],
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: BlocBuilder<BusinessBloc, BusinessState>(
                  buildWhen: (pre, current) =>
                      current is BusinessGetAllProductSuccessState ||
                      current is BusinessInitial,
                  builder: (context, state) {
                    if (state is BusinessGetAllProductSuccessState) {
                      return state.productList.isNotEmpty
                          ? ListView.separated(
                              // controller: scrollController,
                              itemCount: state.productList.length,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return index == state.productList.length - 1
                                    ? Column(
                                        children: [
                                          ProductManageItem(
                                            productDetailResponse:
                                                state.productList[index],
                                            subTabId: args.subTabId,
                                            onEnableChanged: (isEnable) {
                                              businessUpdateBloc
                                                      .productDetailResponse =
                                                  state.productList[index]
                                                      .copyWith(
                                                          hidden: !isEnable);
                                              businessUpdateBloc.add(
                                                  BusinessUpdateProductEvent());
                                            },
                                            onDeletePressed: () {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (_) =>
                                                      getLoadingDialog());
                                              businessBloc.add(
                                                  BusinessDeleteProductDetailEvent(
                                                      pid: state
                                                          .productList[index]
                                                          .id!,
                                                      index: index));
                                            },
                                          ),
                                          const SizedBox(height: 80),
                                        ],
                                      )
                                    : ProductManageItem(
                                        productDetailResponse:
                                            state.productList[index],
                                        subTabId: args.subTabId,
                                        onEnableChanged: (isEnable) {
                                          businessUpdateBloc
                                                  .productDetailResponse =
                                              state.productList[index]
                                                  .copyWith(hidden: !isEnable);
                                          businessUpdateBloc.add(
                                              BusinessUpdateProductEvent());
                                        },
                                        onDeletePressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (_) =>
                                                  getLoadingDialog());
                                          businessBloc.add(
                                              BusinessDeleteProductDetailEvent(
                                                  pid: state
                                                      .productList[index].id!,
                                                  index: index));
                                        },
                                      );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  color: AppColor.gray09,
                                  height: 0.5,
                                );
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    Assets.icNoProduct,
                                    width: context.screenWidth / 3,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Tạo mới bài đăng ngay nào!',
                                    style: AppTextTheme.textPrimaryBold,
                                  ),
                                ],
                              ),
                            );
                    } else {
                      return ListView.separated(
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const ProductManageItemShimmer();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: AppColor.gray09,
                            height: 0.5,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
