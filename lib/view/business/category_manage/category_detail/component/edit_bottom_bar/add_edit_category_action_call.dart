import 'package:flutter/material.dart';
import '../../../../../../data/constants.dart';
import '../../bloc/category_call_action_bloc/category_call_action_bloc.dart';
import '../../bloc/category_detail_bloc.dart';

import '../../../../../../data/resources/themes.dart';
import '../../../../../../shared/utils/view_utils.dart';
import '../../../../../../shared/widgets/button/action_button_edit_category.dart';
import '../../../../../../shared/widgets/primary_switch.dart';
import '../../../../../../shared/widgets/secondary_text_field.dart';
import '../../../../../../shared/widgets/share_popup/primary_bottom_sheet.dart';

class AddEditCategoryActionCall extends StatefulWidget {
  final LandingPageViewType viewType;
  final CategoryCallActionBloc categoryCallActionBloc;
  final int? position;
  final CategoryDetailBloc? categoryDetailBloc;
  final Function? onUpdateButtonAction;

  const AddEditCategoryActionCall(
      {Key? key,
      required this.categoryCallActionBloc,
      required this.viewType,
      this.categoryDetailBloc,
      this.position,
      this.onUpdateButtonAction})
      : super(key: key);

  @override
  State<AddEditCategoryActionCall> createState() =>
      _AddEditCategoryActionCallState();
}

class _AddEditCategoryActionCallState extends State<AddEditCategoryActionCall> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController actionInforController = TextEditingController();

  @override
  void initState() {
    titleController.text =
        widget.categoryCallActionBloc.callActionInfo.title ?? '';
    actionInforController.text =
        widget.categoryCallActionBloc.callActionInfo.actionInfor ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryBottomSheet(
      title: 'Chỉnh sửa nội dung lời kêu gọi',
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SecondaryTextField(
                    controller: titleController,
                    label: 'Tiêu đề lời kêu gọi',
                    isRequired: true),
                const SizedBox(height: 20),
                Text('Thông tin',
                    style: AppTextTheme.textPrimaryBold
                        .copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: LandingPageCallActionOptions.list.length,
              itemBuilder: (context, index) => Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      LandingPageCallActionOptions.list[index],
                      style: AppTextTheme.textPrimary,
                    ),
                  ),
                  PrimarySwitch(
                    initialValue: widget.categoryCallActionBloc.showList[index],
                    onToggle: (value) {
                      widget.categoryCallActionBloc.showList[index] = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SecondaryTextField(
                    controller: actionInforController,
                    label: 'Nội dung nút hành động',
                    isRequired: true),
              ],
            ),
          ),
          ActionButtonEditCategory(
            onCancel: () {},
            onSave: () {
              if (widget.categoryCallActionBloc.showList[1] == false &&
                  widget.categoryCallActionBloc.showList[2] == false) {
                toastWarning(
                    "Nội dung lời kêu gọi cần hiển thị ít nhất 1 trong 2: Email và Số điện thoại");
                return;
              }
              List<int> list = widget.categoryCallActionBloc.showList
                  .map((e) => e ? 1 : 0)
                  .toList();
              List<String> listAction = [];
              for (int i = 0; i < list.length; i++) {
                if (list[i] == 1) {
                  listAction.add(i.toString());
                }
              }
              if (widget.viewType == LandingPageViewType.edit) {
                widget.categoryCallActionBloc.add(CategoryCallActionUpdateEvent(
                    title: titleController.text,
                    actionInfor: actionInforController.text));
              } else if (widget.viewType ==
                  LandingPageViewType.editForButtonShow) {
                widget.onUpdateButtonAction!(titleController.text, listAction,
                    actionInforController.text);
              } else {
                widget.categoryDetailBloc?.add(
                  CategoryCallActionAddEvent(
                    position: widget.position!,
                    listAction: listAction,
                    title: titleController.text,
                    actionInfor: actionInforController.text,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
