import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../primary_button.dart';
import '../primary_divider.dart';

class ActionButtonEditCategory extends StatelessWidget {
  final Function() onSave;
  final Function() onCancel;
  final bool popOnSave;
  const ActionButtonEditCategory(
      {Key? key,
      required this.onSave,
      required this.onCancel,
      this.popOnSave = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PrimaryDivider(),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  context: context,
                  label: 'Hủy',
                  backgroundColor: AppColor.white,
                  textStyle: AppTextTheme.textPrimary,
                  borderColor: AppColor.gray04,
                  onPressed: () {
                    Navigator.pop(context);
                    onCancel();
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: PrimaryButton(
                  context: context,
                  label: 'Lưu thông tin',
                  textStyle: AppTextTheme.textButtonPrimary,
                  onPressed: () {
                    onSave();
                    if (popOnSave) Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
