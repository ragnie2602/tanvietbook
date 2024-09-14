import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../../../../../data/constants.dart';
import '../../../../../../data/resources/resources.dart';
import '../../../../../../shared/widgets/share_popup/primary_bottom_sheet.dart';
import '../../bloc/category_button_bloc/category_button_bloc.dart';
import '../../bloc/category_detail_bloc.dart';

import '../../../../../../shared/utils/utils.dart';
import '../../../../../../shared/widgets/bouncing.dart';
import '../../../../../../shared/widgets/button/action_button_edit_category.dart';
import '../../../../../../shared/widgets/primary_button.dart';
import '../../../../../../shared/widgets/secondary_text_field.dart';

class AddEditCategoryButton extends StatefulWidget {
  final LandingPageViewType viewType;
  final CategoryButtonBloc categoryButtonBloc;
  final int? position;
  final CategoryDetailBloc? categoryDetailBloc;

  const AddEditCategoryButton(
      {Key? key,
      required this.viewType,
      required this.categoryButtonBloc,
      this.position,
      this.categoryDetailBloc})
      : super(key: key);

  @override
  State<AddEditCategoryButton> createState() => _AddEditCategoryButtonState();
}

class _AddEditCategoryButtonState extends State<AddEditCategoryButton> {
  TextEditingController titleController = TextEditingController();
  Color buttonBackgroundColor = AppColor.primaryColor;
  Color buttonTextColor = AppColor.white;
  double valueSlider = 0.1;
  final EdgeInsets contentPadding = const EdgeInsets.all(8);

  @override
  void initState() {
    titleController.text = widget.categoryButtonBloc.buttonValue.value ?? '';
    try {
      buttonBackgroundColor = Color(int.parse(
          widget.categoryButtonBloc.buttonValue.backgroundColor!
              .replaceAll('#', 'FF'),
          radix: 16));
      buttonTextColor = Color(int.parse(
          widget.categoryButtonBloc.buttonValue.textColor!
              .replaceAll('#', 'FF'),
          radix: 16));
    } catch (e) {
      log(e.toString());
    }
    try {
      valueSlider = double.parse(
              widget.categoryButtonBloc.buttonValue.border.toString()) /
          20;
    } catch (e) {
      log(e.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryBottomSheet(
      title: 'Sửa giao diện nút bấm',
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Xem trước",
                    style: AppTextTheme.textPrimaryBold
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                Bouncing(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        buttonBackgroundColor,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(valueSlider * 20),
                        ),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          titleController.text,
                          style: AppTextTheme.textPrimaryBold
                              .copyWith(color: buttonTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                    height: 0, color: AppColor.gray06, thickness: 0.5),
                const SizedBox(height: 20),
                SecondaryTextField(
                  label: 'Tiêu đề nút bấm',
                  isRequired: true,
                  controller: titleController,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                Text("Bo góc",
                    style: AppTextTheme.textPrimaryBold
                        .copyWith(fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: valueSlider,
                        onChanged: (value) {
                          setState(() {
                            valueSlider = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      (valueSlider * 20).toStringAsFixed(0),
                      style: AppTextTheme.textPrimaryBold
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Màu nền',
                    style: AppTextTheme.textPrimaryBold
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: InkWell(
                        onTap: () {
                          showColorPicker(0);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: buttonBackgroundColor,
                            border: Border.all(color: AppColor.black),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border.all(color: AppColor.black),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          buttonBackgroundColor.value
                              .toRadixString(16)
                              .toUpperCase(),
                          style: AppTextTheme.textPrimaryBold
                              .copyWith(color: AppColor.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Màu chữ',
                    style: AppTextTheme.textPrimaryBold
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: InkWell(
                        onTap: () {
                          showColorPicker(1);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: buttonTextColor,
                            border: Border.all(color: AppColor.black),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border.all(color: AppColor.black),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          buttonTextColor.value.toRadixString(16).toUpperCase(),
                          style: AppTextTheme.textPrimaryBold
                              .copyWith(color: AppColor.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  context: context,
                  label: 'Để mặc định',
                  icon: 'assets/icons/ic_refresh.svg',
                  backgroundColor: AppColor.white,
                  textStyle: AppTextTheme.textPrimary,
                  borderColor: AppColor.gray04,
                  onPressed: () {
                    setState(() {
                      buttonBackgroundColor = AppColor.primaryColor;
                      buttonTextColor = AppColor.white;
                      valueSlider = 0.1;
                    });
                  },
                ),
              ],
            ),
          ),
          ActionButtonEditCategory(
            onCancel: () {},
            onSave: () {
              if (widget.viewType == LandingPageViewType.edit) {
                widget.categoryButtonBloc.buttonValuePresent.value =
                    titleController.text;
                widget.categoryButtonBloc.buttonValuePresent.backgroundColor =
                    Utils.intToHexadecimal(buttonBackgroundColor.value);
                widget.categoryButtonBloc.buttonValuePresent.textColor =
                    Utils.intToHexadecimal(buttonTextColor.value);
                widget.categoryButtonBloc.buttonValuePresent.border =
                    int.parse((valueSlider * 20).toStringAsFixed(0));
                widget.categoryButtonBloc.add(CategoryButtonUpdateEvent());
              } else {
                widget.categoryDetailBloc?.add(
                  CategoryButtonAddEvent(
                    position: widget.position!,
                    value: titleController.text,
                    backgroundColor:
                        Utils.intToHexadecimal(buttonBackgroundColor.value),
                    textColor: Utils.intToHexadecimal(buttonTextColor.value),
                    border: int.parse((valueSlider * 20).toStringAsFixed(0)),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  showColorPicker(int type) {
    Color currentColor = type == 1 ? buttonTextColor : buttonBackgroundColor;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              onColorChanged: (color) {
                currentColor = color;
              },
              pickerColor: currentColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Chọn màu'),
              onPressed: () {
                setState(() {
                  if (type == 1) {
                    buttonTextColor = currentColor;
                  } else {
                    buttonBackgroundColor = currentColor;
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
