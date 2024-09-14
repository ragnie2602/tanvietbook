import 'package:flutter/material.dart';
import '../../../data/resources/themes.dart';
import '../dialog_helper.dart';

import '../../../data/resources/colors.dart';
import '../primary_button.dart';

class ActionButton extends StatelessWidget {
  final Function() onSave;
  final Function() onCancel;
  final Function()? onDelete;
  final String saveText;
  final String cancelText;
  final String deleteText;
  final String alertDeleteText;
  final String alertCancelText;
  final String confirmText;
  final bool showAlertDelete;
  final bool showAlertCancel;
  final bool showConfirm;

  const ActionButton({
    Key? key,
    required this.onSave,
    required this.onCancel,
    this.onDelete,
    this.saveText = 'Lưu thông tin',
    this.cancelText = 'Huỷ',
    this.deleteText = 'Xoá',
    this.alertDeleteText = 'Bạn có chắc muốn xoá thông tin này?',
    this.alertCancelText = 'Bạn có chắc muốn huỷ các thay đổi?',
    this.confirmText = 'Bạn có chắc chắn muốn thay đổi?',
    this.showAlertDelete = true,
    this.showAlertCancel = false,
    this.showConfirm = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        onDelete != null
            ? PrimaryButton(
                context: context,
                onPressed: () {
                  if (showAlertDelete) {
                    showDialog(
                      context: context,
                      builder: (_) => getAlertDialog(
                        context: context,
                        title: "Xác nhận",
                        message: alertDeleteText,
                        onPositivePressed: () {
                          onDelete?.call();
                        },
                      ),
                    );
                  } else {
                    onDelete?.call();
                  }
                },
                label: deleteText,
                backgroundColor: AppColor.secondaryColor,
              )
            : const SizedBox(),
        onDelete != null
            ? const SizedBox(
                width: 20,
              )
            : const SizedBox(),
        const Spacer(),
        PrimaryButton(
          context: context,
          onPressed: () {
            if (showAlertCancel) {
              showDialog(
                context: context,
                builder: (_) => getAlertDialog(
                  context: context,
                  title: "Xác nhận",
                  message: alertCancelText,
                  onPositivePressed: () {
                    onCancel.call();
                  },
                ),
              );
            } else {
              onCancel.call();
            }
          },
          label: cancelText,
          backgroundColor: AppColor.white,
          textStyle: AppTextTheme.textButtonSecondary,
          borderColor: AppColor.secondaryColor,
        ),
        const SizedBox(
          width: 20,
        ),
        PrimaryButton(
          context: context,
          onPressed: onSave,
          label: saveText,
          backgroundColor: AppColor.primaryColor,
        ),
      ],
    );
  }
}
