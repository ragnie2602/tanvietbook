import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../model/business/concern/concern_response/concern_response.dart';
import '../../../../shared/etx/view_extensions.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/container/primary_container.dart';
import '../../../../shared/widgets/dialog_helper.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/secondary_text_field.dart';
import '../../category_manage/category_detail/bloc/category_call_action_bloc/category_call_action_bloc.dart';

import '../../../../data/constants.dart';
import '../../../../data/resources/resources.dart';
import '../../../../shared/widgets/image/primary_image.dart';
import '../../../../shared/widgets/primary_drop_down_form_field.dart';

// ignore: must_be_immutable
class ConcernItem extends StatefulWidget {
  ConcernResponse concernResponse;
  final CategoryCallActionBloc callActionBloc;

  ConcernItem(
      {super.key, required this.concernResponse, required this.callActionBloc});

  @override
  State<ConcernItem> createState() => _ConcernItemState();
}

class _ConcernItemState extends State<ConcernItem> {
  bool onEdit = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late Color statusBorderColor;
    switch (widget.concernResponse.status ?? 0) {
      case 0:
        statusBorderColor = AppColor.sunsetOrange;
        break;
      case 1:
        statusBorderColor = AppColor.primaryColor;
        break;
      case 2:
        statusBorderColor = AppColor.neutral5;
        break;
      case 3:
        statusBorderColor = AppColor.blue;
        break;
      case 4:
        statusBorderColor = AppColor.secondaryColor;
        break;
      default:
    }
    (widget.concernResponse.status ?? 0) == 0
        ? AppColor.sunsetOrange
        : AppColor.secondaryColor;

    return PrimaryContainer(
      backgroundColor: AppColor.white,
      borderColor: AppColor.gray07,
      padding: const EdgeInsets.only(top: 10),
      child: ExpandableNotifier(
        initialExpanded: false,
        child: ScrollOnExpand(
          child: ExpandablePanel(
              header: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  PrimaryNetworkImage(
                      width: context.screenWidth * 64 / 375,
                      height: context.screenWidth * 64 / 375,
                      imageUrl: widget.concernResponse.concernImage != null
                          ? widget.concernResponse.concernImage!.first
                          : ''),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                          maxLines: 2,
                          text: TextSpan(children: [
                            const TextSpan(
                                text: '[', style: AppTextTheme.textPrimary),
                            TextSpan(
                                text: widget.concernResponse.type ==
                                        CategoryType.post
                                    ? 'Bài đăng'
                                    : widget.concernResponse.type ==
                                            CategoryType.landingPage
                                        ? 'Nội dung'
                                        : widget.concernResponse.type,
                                style: AppTextTheme.textPrimaryColor),
                            const TextSpan(
                                text: '] ', style: AppTextTheme.textPrimary),
                            TextSpan(
                              text: widget.concernResponse.concernName,
                              style: AppTextTheme.textPrimary
                                  .copyWith(overflow: TextOverflow.ellipsis),
                            ),
                          ])),
                      const SizedBox(height: 10),
                      PrimaryDropDownFormField(
                        controller: TextEditingController(),
                        borderColor: statusBorderColor,
                        filled: true,
                        fillColor: statusBorderColor.withOpacity(0.4),
                        textStyle: AppTextTheme.textPrimaryBold
                            .copyWith(color: statusBorderColor),
                        initialValue:
                            orderStatus[widget.concernResponse.status ?? 0],
                        items: orderStatus,
                        onChanged: (value, index) async {
                          widget.callActionBloc.concernResponse =
                              widget.concernResponse.copyWith(
                            status: index,
                          );
                          widget.callActionBloc
                              .add(CategoryCallActionCreateActionEvent());
                          await showDialog(
                                  context: context,
                                  builder: (_) => getLoadingDialog(),
                                  barrierDismissible: false)
                              .then((value) {
                            setState(() {
                              widget.concernResponse = widget.concernResponse
                                  .copyWith(status: index);
                            });
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ))
                ],
              ),
              collapsed: const SizedBox(),
              expanded: StatefulBuilder(
                builder: (context, setInnerState) {
                  return Column(
                    children: [
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: AppColor.gray07,
                      ),
                      const SizedBox(height: 10),
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          concernInfo(
                              'Tên khách hàng',
                              widget.concernResponse.fullName ?? '',
                              // keyboardType: TextInputType.,
                              textCapitalization: TextCapitalization.words,
                              onEdit,
                              _nameController),
                          concernInfo(
                              'Điện thoại',
                              widget.concernResponse.phonenumber ?? '',
                              keyboardType: TextInputType.phone,
                              onEdit,
                              _phoneController),
                          concernInfo(
                              'Email',
                              widget.concernResponse.email ?? '',
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              onEdit,
                              _emailController),
                          concernInfo(
                              'Địa chỉ',
                              widget.concernResponse.address ?? '',
                              onEdit,
                              _addressController),
                          concernInfo(
                              'Lời nhắn',
                              widget.concernResponse.note ?? '',
                              onEdit,
                              _noteController),
                          concernInfo(
                            'Ngày tạo',
                            Utils.formatDate(
                                widget.concernResponse.createdDate.toString(),
                                showTime: true),
                            onEdit,
                            TextEditingController(),
                            readOnly: true,
                          ),
                          concernInfo(
                            'Ngày cập nhật',
                            Utils.formatDate(
                                widget.concernResponse.lastModifiedDate ??
                                    widget.concernResponse.createdDate ??
                                    '',
                                showTime: true),
                            onEdit,
                            TextEditingController(),
                            readOnly: true,
                          ),
                        ],
                      ),
                      Container(
                        color: AppColor.lightBackground,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            onEdit
                                ? PrimaryButton(
                                    context: context,
                                    onPressed: () {
                                      setInnerState(() {
                                        onEdit = !onEdit;
                                      });
                                    },
                                    label: 'Huỷ',
                                    textStyle: AppTextTheme.textButtonSecondary,
                                    backgroundColor: AppColor.white,
                                    borderColor: AppColor.secondaryColor,
                                  )
                                : const SizedBox(),
                            const SizedBox(width: 10),
                            BlocListener<CategoryCallActionBloc,
                                CategoryCallActionState>(
                              listener: (context, state) {
                                if (state
                                    is CategoryCallActionCreateSuccessState) {
                                  if (state.concernResponse.id ==
                                      widget.concernResponse.id) {
                                    Navigator.pop(context);
                                    setInnerState(() {
                                      onEdit = false;
                                      widget.concernResponse =
                                          state.concernResponse;
                                      // widget.concernResponse.copyWith(
                                      //   fullName: _nameController.text,
                                      //   email: _emailController.text.trim(),
                                      //   phonenumber:
                                      //       _phoneController.text.trim(),
                                      //   note: _noteController.text.trim(),
                                      //   lastModifiedDate: Utils.formatDate(
                                      //       Utils.getDateTimeNowIso(),
                                      //       showTime: true),
                                      // );
                                    });
                                  }
                                }
                              },
                              child: PrimaryButton(
                                  context: context,
                                  backgroundColor: onEdit
                                      ? AppColor.success
                                      : AppColor.primaryColor,
                                  onPressed: () async {
                                    if (onEdit) {
                                      widget.callActionBloc.concernResponse =
                                          widget.concernResponse.copyWith(
                                        fullName: _nameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        address: _addressController.text.trim(),
                                        phonenumber:
                                            _phoneController.text.trim(),
                                        note: _noteController.text.trim(),
                                      );
                                      widget.callActionBloc.add(
                                          CategoryCallActionCreateActionEvent());
                                      await showDialog(
                                          context: context,
                                          builder: (_) => getLoadingDialog(),
                                          barrierDismissible: false);
                                    } else {
                                      setInnerState(() {
                                        onEdit = !onEdit;
                                      });
                                    }
                                  },
                                  label: onEdit ? 'Hoàn tất' : 'Chỉnh sửa'),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}

TableRow concernInfo(
  String title,
  String value,
  bool onEdit,
  TextEditingController controller, {
  bool readOnly = false,
  TextCapitalization textCapitalization = TextCapitalization.sentences,
  AppInputType? textInutType,
  final TextInputType? keyboardType,
}) {
  return TableRow(children: [
    Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: AppTextTheme.textPrimaryBold,
            ),
          ),
          Expanded(
            flex: 3,
            child: onEdit
                ? SecondaryTextField(
                    isDense: true,
                    controller: controller..text = value,
                    readOnly: readOnly,
                    textCapitalization: textCapitalization,
                    keyboardType: keyboardType,
                    textInputAction: TextInputAction.next,
                  )
                : Text(
                    value,
                    style: AppTextTheme.textPrimary,
                  ),
          )
        ],
      ),
    ),
  ]);
}
