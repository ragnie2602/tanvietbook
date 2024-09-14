import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/constants.dart';
import '../bloc/category_detail_bloc.dart';

import '../../../../../data/resources/colors.dart';
import '../../../../../data/resources/themes.dart';
import '../../../../../model/business/landing_page/landing_page_call_action_response.dart';
import '../../../../../shared/widgets/bouncing.dart';
import '../../../../../shared/widgets/loading.dart';
import '../bloc/category_button_bloc/category_button_bloc.dart';
import '../bloc/category_call_action_bloc/category_call_action_bloc.dart';
import 'category_base_item.dart';
import 'category_call_action.dart';

class CategoryButton extends CategoryBaseItem {
  final CategoryDetailBloc categoryDetailBloc;
  final LandingPageItemViewType viewType;
  final int index;
  final String? title;
  final String? id;

  const CategoryButton(
      {required this.categoryDetailBloc,
      required this.viewType,
      required this.index,
      this.title,
      this.id,
      Key? key})
      : super(key: key);

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends CategoryBaseItemState<CategoryButton>
    with CategoryBaseItemScreen {
  CategoryButtonBloc callButtonBloc = CategoryButtonBloc();
  Color buttonBackgroundColor = AppColor.primaryColor;
  Color buttonTextColor = AppColor.white;
  double border = 2;

  @override
  CategoryDetailBloc categoryDetailBloc() {
    return widget.categoryDetailBloc;
  }

  @override
  int index() {
    return widget.index;
  }

  @override
  itemBloc() {
    return callButtonBloc;
  }

  @override
  String landingId() {
    return widget.id!;
  }

  @override
  String type() {
    return CategoryContentType.button;
  }

  @override
  LandingPageItemViewType viewType() {
    return widget.viewType;
  }

  @override
  void initState() {
    callButtonBloc.add(CategoryButtonInitEvent(landingId: landingId()));
    super.initState();
  }

  @override
  Widget body() {
    return BlocProvider.value(
      value: callButtonBloc,
      child: BlocConsumer<CategoryButtonBloc, CategoryButtonState>(
        listener: (context, state) {
          if (state is CategoryButtonInitial) {
            try {
              buttonBackgroundColor = Color(int.parse(
                  state.landingPageButtonResponse.backgroundColor!
                      .replaceAll('#', 'FF'),
                  radix: 16));
              buttonTextColor = Color(int.parse(
                  state.landingPageButtonResponse.textColor!
                      .replaceAll('#', 'FF'),
                  radix: 16));
            } catch (e) {
              log(e.toString());
            }
            try {
              border = double.parse(
                state.landingPageButtonResponse.border.toString(),
              );
            } catch (e) {
              border = 2;
            }
          }
        },
        builder: (context, state) {
          if (state is CategoryButtonInitial) {
            return Bouncing(
              child: ElevatedButton(
                onPressed: () {
                  if (state.landingPageButtonResponse.type == 0) {
                    categoryDetailBloc().add(CategoryButtonScrollToCTAEvent());
                  } else if (state.landingPageButtonResponse.type == 1) {
                    showBottomSheet(
                      context: context,
                      builder: (context) {
                        return CategoryCallAction(
                          categoryDetailBloc: CategoryDetailBloc(),
                          index: 0,
                          callActionBloc: CategoryCallActionBloc(),
                          viewType: LandingPageItemViewType.forButtonShow,
                          callActionInfo: LandingPageCallActionResponse(
                            title: state.landingPageButtonResponse.title,
                            actions: state.landingPageButtonResponse.actions,
                            actionInfor:
                                state.landingPageButtonResponse.actionInfor,
                          ),
                        );
                      },
                    );
                  } else if (state.landingPageButtonResponse.type == 2) {}
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    buttonBackgroundColor,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(border),
                    ),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.landingPageButtonResponse.value ?? '',
                        style: AppTextTheme.textPrimaryBold
                            .copyWith(color: buttonTextColor)),
                  ],
                ),
              ),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
