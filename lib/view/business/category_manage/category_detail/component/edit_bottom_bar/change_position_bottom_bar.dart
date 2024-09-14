import 'package:flutter/material.dart';

import '../../../../../../data/constants.dart';
import '../../../../../../data/resources/colors.dart';
import '../../../../../../shared/widgets/button/action_button_edit_category.dart';
import '../../../../../../shared/widgets/primary_button.dart';
import '../../bloc/category_detail_bloc.dart';

class ChangePositionBottomBar extends StatelessWidget {
  final CategoryDetailBloc bloc;
  const ChangePositionBottomBar({Key? key, required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(color: AppColor.gray06, height: 0),
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: PrimaryButton(
                    context: context,
                    onPressed: () {
                      bloc.add(CategoryDetailChangePositionEvent(
                          type: ChangePositionType.down));
                    },
                    label: '',
                    borderColor: AppColor.primaryColor,
                    backgroundColor: Colors.white,
                    icon: "assets/icons/ic_down.svg"),
              ),
              Expanded(
                flex: 1,
                child: PrimaryButton(
                    context: context,
                    onPressed: () {
                      bloc.add(CategoryDetailChangePositionEvent(
                          type: ChangePositionType.up));
                    },
                    label: '',
                    borderColor: AppColor.primaryColor,
                    backgroundColor: Colors.white,
                    icon: "assets/icons/ic_up.svg"),
              ),
              Expanded(
                flex: 1,
                child: PrimaryButton(
                    context: context,
                    onPressed: () {
                      bloc.add(CategoryDetailChangePositionEvent(
                          type: ChangePositionType.upToTop));
                    },
                    label: '',
                    borderColor: AppColor.primaryColor,
                    backgroundColor: Colors.white,
                    icon: "assets/icons/ic_up_to_top.svg"),
              ),
              Expanded(
                flex: 1,
                child: PrimaryButton(
                    context: context,
                    onPressed: () {
                      bloc.add(CategoryDetailChangePositionEvent(
                          type: ChangePositionType.downToBottom));
                    },
                    label: '',
                    borderColor: AppColor.primaryColor,
                    backgroundColor: Colors.white,
                    icon: "assets/icons/ic_down_to_bottom.svg"),
              )
            ],
          ),
        ),
        ActionButtonEditCategory(
          onCancel: () {
            bloc.add(CategorySaveCancelChangePositionEvent(isSave: false));
          },
          onSave: () {
            bloc.add(CategorySaveCancelChangePositionEvent(isSave: true));
          },
        )
      ],
    );
  }
}
