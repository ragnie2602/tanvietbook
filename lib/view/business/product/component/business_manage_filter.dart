import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../model/business/category/business_category_response.dart';

import '../../../../data/constants.dart';
import '../../../../data/resources/resources.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/button/action_button.dart';
import '../../../../shared/widgets/button/primary_group_checkbox.dart';
import '../../../../shared/widgets/carousel/primary_range_slider.dart';
import '../../../../shared/widgets/container_shimmer.dart';
import '../../../../shared/widgets/primary_drop_down_check_box.dart';
import '../../../../shared/widgets/primary_shimmer.dart';
import '../../bloc/business_bloc.dart';
import '../../category_manage/bloc/category_manage_bloc/category_manage_bloc.dart';

class PostManageFilter extends StatelessWidget {
  final CategoryManageBloc categoryManageBloc;
  final BusinessBloc businessBloc;
  final BusinessManageFilterData businessManageFilterData;

  const PostManageFilter({
    super.key,
    required this.businessManageFilterData,
    required this.categoryManageBloc,
    required this.businessBloc,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = TextEditingController();
    categoryManageBloc.currentSubTabId = businessManageFilterData.subTabId;
    bool isSoldOut = businessManageFilterData.isSoldOut;
    bool isHidden = businessManageFilterData.isHidden;
    List<String>? currentCategoryId =
        businessManageFilterData.currentCategoryId;
    List<String>? currentCategoryName =
        businessManageFilterData.currentCategoryName;
    double? rangeFrom = businessManageFilterData.rangeFrom;
    double? rangeTo = businessManageFilterData.rangeTo;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: categoryManageBloc
            ..add(CategoryManageGetAllByTypeEvent(type: CategoryType.post)),
        ),
        BlocProvider.value(
          value: businessBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Text(
                      'Lọc bài đăng',
                      style: AppTextTheme.textPrimary,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: AppColor.gray09,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Loại', style: AppTextTheme.textPrimary),
                    PrimaryGroupCheckbox(
                        items: const ['Hết hàng', 'Ẩn bài đăng'],
                        onChanged: (valueChanged) {
                          isSoldOut = valueChanged[0];
                          isHidden = valueChanged[1];
                        },
                        initialValue: [
                          businessManageFilterData.isSoldOut,
                          businessManageFilterData.isHidden
                        ]),
                    const SizedBox(height: 20),
                    const Text('Danh mục', style: AppTextTheme.textPrimary),
                    const SizedBox(height: 10),
                    BlocBuilder<CategoryManageBloc, CategoryManageState>(
                      builder: (context, state) {
                        List<BusinessCategoryResponse> initialCategory = [];
                        if (state is CategoryManageGetAllSuccessState) {
                          final categoryNameList = state.categoryList;
                          if (state.categoryList.isNotEmpty) {
                            for (int i = 0;
                                i < state.categoryList.length;
                                i++) {
                              // if (state.categoryList[i].categoryName ==
                              //     businessManageFilterData
                              //         .currentCategoryName) {
                              //   initialCategory.add(state.categoryList[i]);
                              //   break;
                              // }
                            }
                          } else {
                            return const Text(
                              'Bạn cần tạo danh mục trước khi tạo bài đăng.',
                              style: AppTextTheme.textLowPriority,
                            );
                          }
                          return PrimaryDropDownCheckBox<
                              BusinessCategoryResponse>(
                            items: [...categoryNameList],
                            initialItems: initialCategory,
                            controller: categoryController,
                            onChanged: (value) {
                              log('value: $value');
                              businessBloc.businessManageFilterData =
                                  businessBloc.businessManageFilterData
                                      .copyWith(
                                currentCategoryId: List.from(
                                  value.map((e) => e.id),
                                ),
                                currentCategoryName:
                                    List.from(value.map((e) => e.categoryName)),
                              );
                              currentCategoryName?.clear();
                              currentCategoryName?.addAll(
                                  value.map((e) => e.categoryName ?? ''));
                              currentCategoryId?.clear();
                              currentCategoryId
                                  ?.addAll(value.map((e) => e.id ?? ''));
                              // if (index > 0) {
                              //   currentCategoryId =
                              //       state.categoryList[index - 1].id;
                              //   currentCategoryName =
                              //       state.categoryList[index - 1].categoryName;
                              // } else {
                              //   currentCategoryId = null;
                              //   currentCategoryName = null;
                              // }
                            },
                            hintText: categoryNameList.isEmpty
                                ? 'Bạn chưa tạo danh mục Bài đăng nào'
                                : null,
                          );
                        } else {
                          return const PrimaryShimmer(
                              child: ContainerShimmer());
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    PrimaryRangeSlider(
                      from: businessManageFilterData.rangeFrom ?? 0,
                      to: businessManageFilterData.rangeTo ?? 0,
                      onChanged: (from, to) {
                        rangeFrom = from;
                        rangeTo = to;
                      },
                    ),
                    const SizedBox(height: 30),
                    ActionButton(onSave: () {
                      businessManageFilterData.currentCategoryId =
                          currentCategoryId;
                      businessManageFilterData.currentCategoryName =
                          currentCategoryName;
                      businessManageFilterData.isSoldOut = isSoldOut;
                      businessManageFilterData.isHidden = isHidden;
                      businessManageFilterData.rangeFrom = rangeFrom;
                      businessManageFilterData.rangeTo = rangeTo;

                      final List<String> filterList = [];
                      if (currentCategoryName != null) {
                        filterList.addAll(currentCategoryName);
                      }
                      if (isSoldOut) {
                        filterList.add('Hết hàng');
                      }
                      if (isHidden) {
                        filterList.add('Đang ẩn');
                      }
                      if (rangeFrom != null && rangeTo != null) {
                        filterList.add(
                            '${Utils.formatMoney(rangeFrom!)}-${Utils.formatMoney(rangeTo!)}');
                      } else {
                        // filterList.add('≥${Utils.formatMoney(rangeFrom!)}');
                        // filterList.add('≤${Utils.formatMoney(rangeTo!)}');
                      }

                      Navigator.pop(context, businessManageFilterData);
                    }, onCancel: () {
                      Navigator.pop(context);
                    }),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
