import 'package:flutter/cupertino.dart';
import '../../data/resources/themes.dart';

import '../../../data/constants.dart';
import '../../../data/resources/colors.dart';
import 'secondary_text_field.dart';

class CustomerInfoField extends StatelessWidget {
  const CustomerInfoField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.isRequired = false,
      required this.label,
      this.validator,
      this.inputType,
      this.selectionField,
      this.keyboardType,
      this.data,
      this.textCapitalization = TextCapitalization.none,
      this.textInputAction,
      this.context,
      this.readOnly = false,
      this.onTap,
      this.formKey})
      : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String label;
  final bool isRequired;
  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;
  final List<String>? selectionField;
  final AppInputType? inputType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final List<String>? data;
  final TextInputType? keyboardType;
  final bool readOnly;
  final BuildContext? context;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                label,
                style: AppTextTheme.textPrimaryColor.copyWith(fontSize: 16),
              ),
              isRequired == true
                  ? const Text(" *",
                      style: TextStyle(color: AppColor.errorColor))
                  : Container(),
            ],
          ),
          SecondaryTextField(
            hintText: hintText,
            controller: controller,
            validator: validator,
            textCapitalization: textCapitalization,
            textInputAction: textInputAction,
            formKey: formKey,
            inputType: inputType,
            keyboardType: keyboardType,
            data: data,
            context: this.context,
            readOnly: readOnly,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
