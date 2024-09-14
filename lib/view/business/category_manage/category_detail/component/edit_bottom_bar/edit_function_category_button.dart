import 'package:flutter/material.dart';

import '../../../../../../data/constants.dart';
import '../../../../../../data/resources/colors.dart';
import '../../../../../../data/resources/themes.dart';
import '../../../../../../model/business/landing_page/landing_page_call_action_response.dart';
import '../../../../../../shared/widgets/button/action_button_edit_category.dart';
import '../../../../../../shared/widgets/primary_button.dart';
import '../../../../../../shared/widgets/secondary_text_field.dart';
import '../../../../../../shared/widgets/share_popup/primary_bottom_sheet.dart';
import '../../bloc/category_button_bloc/category_button_bloc.dart';
import '../../bloc/category_call_action_bloc/category_call_action_bloc.dart';
import '../../bloc/category_detail_bloc.dart';
import '../category_call_action.dart';
import 'add_edit_category_action_call.dart';

class EditFunctionCategoryButton extends StatefulWidget {
  final CategoryButtonBloc categoryButtonBloc;
  const EditFunctionCategoryButton({Key? key, required this.categoryButtonBloc})
      : super(key: key);

  @override
  State<EditFunctionCategoryButton> createState() =>
      _EditFunctionCategoryButtonState();
}

class _EditFunctionCategoryButtonState
    extends State<EditFunctionCategoryButton> {
  late String currentFunction;
  TextEditingController linkController = TextEditingController();

  @override
  void initState() {
    currentFunction = LandingPageButtonFunction
        .list[widget.categoryButtonBloc.buttonValue.type ?? 0];
    linkController.text = widget.categoryButtonBloc.buttonValue.link ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryBottomSheet(
      title: 'Chức năng của nút bấm',
      child: ListView(shrinkWrap: true, children: [
        ListTile(
          title: Text(LandingPageButtonFunction.list[0],
              style: AppTextTheme.textPrimary),
          onTap: () {
            setState(() {
              currentFunction = LandingPageButtonFunction.list[0];
            });
          },
          leading: Radio<String>(
            value: LandingPageButtonFunction.list[0],
            groupValue: currentFunction,
            onChanged: (String? value) {
              setState(() {
                currentFunction = value ?? LandingPageButtonFunction.list[0];
              });
            },
          ),
        ),
        ListTile(
          title: Text(LandingPageButtonFunction.list[1],
              style: AppTextTheme.textPrimary),
          onTap: () {
            setState(() {
              currentFunction = LandingPageButtonFunction.list[1];
            });
          },
          leading: Radio<String>(
            value: LandingPageButtonFunction.list[1],
            groupValue: currentFunction,
            onChanged: (String? value) {
              setState(() {
                currentFunction = value ?? LandingPageButtonFunction.list[0];
              });
            },
          ),
        ),
        if (currentFunction == LandingPageButtonFunction.list[1])
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(
                    context: context,
                    onPressed: () {
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return AbsorbPointer(
                            absorbing: true,
                            child: CategoryCallAction(
                              categoryDetailBloc: CategoryDetailBloc(),
                              index: 0,
                              callActionBloc: CategoryCallActionBloc(),
                              viewType: LandingPageItemViewType.forButtonShow,
                              callActionInfo: LandingPageCallActionResponse(
                                title:
                                    widget.categoryButtonBloc.buttonValue.title,
                                actions: widget
                                    .categoryButtonBloc.buttonValue.actions,
                                actionInfor: widget
                                    .categoryButtonBloc.buttonValue.actionInfor,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    label: "Xem hộp thông tin"),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: PrimaryButton(
                    context: context,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          final List<bool> showList = [
                            false,
                            false,
                            false,
                            false,
                            false,
                            false
                          ];
                          for (int i = 0;
                              i <
                                  widget.categoryButtonBloc.buttonValue.actions!
                                      .length;
                              i++) {
                            showList[int.parse(widget.categoryButtonBloc
                                .buttonValue.actions![i])] = true;
                          }
                          return AddEditCategoryActionCall(
                              categoryCallActionBloc: CategoryCallActionBloc()
                                ..callActionInfo =
                                    LandingPageCallActionResponse(
                                  title: widget
                                      .categoryButtonBloc.buttonValue.title,
                                  actions: widget
                                      .categoryButtonBloc.buttonValue.actions,
                                  actionInfor: widget.categoryButtonBloc
                                      .buttonValue.actionInfor,
                                )
                                ..showList = showList,
                              viewType: LandingPageViewType.editForButtonShow,
                              onUpdateButtonAction:
                                  (title, actions, actionInfor) {
                                widget.categoryButtonBloc.buttonValuePresent
                                    .title = title;
                                widget.categoryButtonBloc.buttonValuePresent
                                    .actions = actions;
                                widget.categoryButtonBloc.buttonValuePresent
                                    .actionInfor = actionInfor;
                                widget.categoryButtonBloc
                                    .add(CategoryButtonUpdateEvent());
                              }

                              // categoryDetailBloc: CategoryDetailBloc(),
                              // position: 0,
                              );
                        },
                      );
                    },
                    label: "Sửa hộp thông tin",
                    backgroundColor: AppColor.white,
                    borderColor: AppColor.primaryColor,
                    textStyle: AppTextTheme.textPrimaryColor),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ListTile(
          title: Text(LandingPageButtonFunction.list[2],
              style: AppTextTheme.textPrimary),
          onTap: () {
            setState(() {
              currentFunction = LandingPageButtonFunction.list[2];
            });
          },
          leading: Radio<String>(
            value: LandingPageButtonFunction.list[2],
            groupValue: currentFunction,
            onChanged: (String? value) {
              setState(() {
                currentFunction = value ?? LandingPageButtonFunction.list[0];
              });
            },
          ),
        ),
        if (currentFunction == LandingPageButtonFunction.list[2])
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SecondaryTextField(
              label: "Liên kết",
              hintText: "Nhập link video",
              controller: linkController,
            ),
          ),
        const SizedBox(height: 10),
        ActionButtonEditCategory(
          onCancel: () {},
          onSave: () {
            if (currentFunction == LandingPageButtonFunction.list[0]) {
              widget.categoryButtonBloc.buttonValuePresent.type = 0;
            } else if (currentFunction == LandingPageButtonFunction.list[1]) {
              widget.categoryButtonBloc.buttonValuePresent.type = 1;
            } else if (currentFunction == LandingPageButtonFunction.list[2]) {
              widget.categoryButtonBloc.buttonValuePresent.type = 2;
              widget.categoryButtonBloc.buttonValuePresent.link =
                  linkController.text;
            }
            widget.categoryButtonBloc.add(CategoryButtonUpdateEvent());
          },
        )
      ]),
    );
  }
}
