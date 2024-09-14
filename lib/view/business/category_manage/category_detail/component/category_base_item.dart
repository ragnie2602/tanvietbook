import 'package:flutter/material.dart';
import '../../../../../data/constants.dart';
import '../bloc/category_detail_bloc.dart';
import 'edit_bottom_bar/edit_bottom_bar_overall.dart';

import '../../../../../data/resources/colors.dart';

abstract class CategoryBaseItem extends StatefulWidget {
  const CategoryBaseItem({Key? key}) : super(key: key);
}

abstract class CategoryBaseItemState<Page extends CategoryBaseItem>
    extends State<Page> {
  bool _isFocus = false;
  FocusNode focusNode = FocusNode();

  String type(); // category type

  String landingId();

  int index();

  Widget body();

  LandingPageItemViewType viewType();

  CategoryDetailBloc categoryDetailBloc();

  dynamic itemBloc();

  void onFocus(bool isFocus) async {
    setState(() {
      _isFocus = isFocus;
    });
  }
}

mixin CategoryBaseItemScreen<Page extends CategoryBaseItem>
    on CategoryBaseItemState<Page> {
  @override
  Widget build(BuildContext context) {
    if (viewType() == LandingPageItemViewType.forLandingPageEdit) {
      return Focus(
        onFocusChange: (value) {
          if (value) {
            onFocus(true);
          } else {
            onFocus(false);
          }
        },
        focusNode: focusNode,
        child: GestureDetector(
          onTap: () {
            focusNode.requestFocus();
            showBottomSheet(
              context: context,
              builder: (context) => EditBottomBar(
                landingId: landingId(),
                itemBloc: itemBloc(),
                categoryDetailBloc: categoryDetailBloc(),
                type: type(),
              ),
            );
            categoryDetailBloc()
                .add(CategoryDetailSetCurrentIndexFocus(currentIndex: index()));
          },
          child: AbsorbPointer(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: _isFocus
                      ? Border.all(color: AppColor.inform, width: 2)
                      : null),
              child: body(),
            ),
          ),
        ),
      );
    } else {
      return body();
    }
  }
}
