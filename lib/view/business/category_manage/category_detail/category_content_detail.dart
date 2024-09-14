import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../data/constants.dart';
import '../../../../data/resources/resources.dart';
import '../../../../shared/widgets/primary_app_bar.dart';
import '../../../../shared/widgets/primary_button.dart';
import 'bloc/category_call_action_bloc/category_call_action_bloc.dart';
import 'bloc/category_detail_bloc.dart';
import 'component/category_call_action.dart';
import 'component/category_content.dart';
import 'component/category_images.dart';
import 'component/category_link.dart';
import 'component/edit_bottom_bar/choose_type_content_bottom.dart';

import '../../../../config/routes.dart';
import '../../../../shared/widgets/loading.dart';
import 'component/category_button.dart';

class CategoryContentDetail extends StatefulWidget {
  final String? categoryId;
  final LandingPageViewType? viewType;
  const CategoryContentDetail({Key? key, this.categoryId, this.viewType})
      : super(key: key);

  @override
  State<CategoryContentDetail> createState() => _CategoryContentDetailState();
}

class _CategoryContentDetailState extends State<CategoryContentDetail>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CategoryDetailBloc bloc = CategoryDetailBloc();
  late CategoryContentDetailArgs args;
  LandingPageViewType? viewType;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.viewType == LandingPageViewType.view) {
      viewType = LandingPageViewType.view;
      bloc.add(CategoryDetailInitEvent(categoryId: widget.categoryId!));
    } else {
      args = ModalRoute.of(context)!.settings.arguments
          as CategoryContentDetailArgs;
      if (args.type == LandingPageViewType.edit) {
        viewType = LandingPageViewType.edit;
        bloc.add(CategoryDetailInitEvent(categoryId: args.categoryId));
      } else if (args.type == LandingPageViewType.add) {
        viewType = LandingPageViewType.add;
        bloc.add(CategoryDetailCreateEvent(categoryId: args.categoryId));
      }
    }
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColor.white,
        appBar: viewType == LandingPageViewType.view
            ? null
            : const PrimaryAppBar(
                backgroundColor: AppColor.bgAppBarEditColor,
                title: 'Chỉnh sửa landing page',
                canPop: true,
              ),
        body: BlocConsumer<CategoryDetailBloc, CategoryDetailState>(
          listener: (context, state) {
            if (state is CategoryDetailInitial) {
              if (state.list.isNotEmpty) {
                try {
                  final key = state.list[bloc.currentIndex].key;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Scrollable.ensureVisible(key.currentContext!);
                  });
                } catch (e) {
                  log(e.toString());
                }
              }
            }
            if (state is CategoryDetailScrollToCTAState) {
              try {
                final key = state.key;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Scrollable.ensureVisible(key.currentContext!);
                });
              } catch (e) {
                log(e.toString());
              }
            }
          },
          buildWhen: (previous, current) {
            if (current is CategoryDetailInitial) {
              return true;
            }
            if (current is CategoryDetailLoading) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is CategoryDetailInitial) {
              if (state.list.isNotEmpty) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          viewType == LandingPageViewType.view
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: PrimaryButton(
                                    context: context,
                                    textStyle: AppTextTheme.textPrimaryColor,
                                    icon: Icons.add,
                                    iconColor: AppColor.primaryColor,
                                    borderColor: AppColor.primaryColor,
                                    backgroundColor: Colors.white,
                                    onPressed: () {
                                      showBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            ChooseTypeContentBottom(
                                          position: index + 1,
                                          categoryDetailBloc: bloc,
                                        ),
                                      );
                                    },
                                    label: 'Thêm thành phần',
                                  ),
                                ),
                      shrinkWrap: true,
                      itemCount: state.list.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        switch (state.list[index].type) {
                          case 0:
                            return CategoryImages(
                              categoryDetailBloc: bloc,
                              index: index,
                              viewType: viewType == LandingPageViewType.view
                                  ? LandingPageItemViewType.forLandingPageView
                                  : LandingPageItemViewType.forLandingPageEdit,
                              title: state.list[index].title ?? '',
                              id: state.list[index].id ?? '',
                              key: state.list[index].key,
                            );
                          case 1:
                            return CategoryContent(
                              categoryDetailBloc: bloc,
                              index: index,
                              id: state.list[index].id ?? '',
                              viewType: viewType == LandingPageViewType.view
                                  ? LandingPageItemViewType.forLandingPageView
                                  : LandingPageItemViewType.forLandingPageEdit,
                              key: state.list[index].key,
                            );
                          case 2:
                            return CategoryLink(
                              categoryDetailBloc: bloc,
                              index: index,
                              id: state.list[index].id ?? '',
                              viewType: viewType == LandingPageViewType.view
                                  ? LandingPageItemViewType.forLandingPageView
                                  : LandingPageItemViewType.forLandingPageEdit,
                              key: state.list[index].key,
                            );
                          case 3:
                            return CategoryCallAction(
                              categoryDetailBloc: bloc,
                              index: index,
                              id: state.list[index].id ?? '',
                              viewType: viewType == LandingPageViewType.view
                                  ? LandingPageItemViewType.forLandingPageView
                                  : LandingPageItemViewType.forLandingPageEdit,
                              callActionBloc: CategoryCallActionBloc(),
                              key: state.list[index].key,
                            );
                          case 4:
                            return CategoryButton(
                              viewType: viewType == LandingPageViewType.view
                                  ? LandingPageItemViewType.forLandingPageView
                                  : LandingPageItemViewType.forLandingPageEdit,
                              categoryDetailBloc: bloc,
                              index: index,
                              id: state.list[index].id ?? '',
                            );
                        }
                        return const SizedBox();
                      },
                    ),
                    viewType == LandingPageViewType.view
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(20),
                            child: PrimaryButton(
                              context: context,
                              textStyle: AppTextTheme.textPrimaryColor,
                              icon: Icons.add,
                              iconColor: AppColor.primaryColor,
                              borderColor: AppColor.primaryColor,
                              backgroundColor: Colors.white,
                              onPressed: () {
                                showBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        ChooseTypeContentBottom(
                                            position: state.list.length + 1,
                                            categoryDetailBloc: bloc));
                              },
                              label: 'Thêm thành phần',
                            ),
                          ),
                    const SizedBox(height: 50)
                  ],
                );
              } else {
                if (viewType == LandingPageViewType.view) {
                  return Container(
                    color: AppColor.gray10,
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(Assets.icNoData),
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            "assets/images/img_business_blank.svg"),
                        const SizedBox(height: 30),
                        const Text(
                          "Tạo riêng cho mình một landing page ngay nào! ",
                          style: AppTextTheme.textPrimary,
                        ),
                        const SizedBox(height: 30),
                        PrimaryButton(
                          context: context,
                          textStyle: AppTextTheme.textPrimaryColor,
                          icon: Icons.add,
                          iconColor: AppColor.primaryColor,
                          borderColor: AppColor.primaryColor,
                          backgroundColor: Colors.white,
                          onPressed: () {
                            showBottomSheet(
                              context: context,
                              builder: (context) => ChooseTypeContentBottom(
                                  position: 1, categoryDetailBloc: bloc),
                            );
                          },
                          label: 'Thêm thành phần',
                        ),
                      ],
                    ),
                  );
                }
              }
            } else {
              return const Loading();
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
