import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';

class TextFieldInfo extends StatelessWidget {
  const TextFieldInfo({
    Key? key,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
  }) : super(key: key);

  final String label;
  final String? prefixIcon;
  final String? suffixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      style: AppTextTheme.textPrimary,
      controller: controller,
      minLines: 1,
      maxLines: 100,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: AppTextTheme.textPrimary,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 0.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 1),
        ),
        prefixIcon: prefixIcon == null
            ? null
            : SvgPicture.asset(
                prefixIcon ?? '',
                height: 20,
                width: 16,
                fit: BoxFit.scaleDown,
              ),
        suffixIcon: suffixIcon != null ? SvgPicture.asset(suffixIcon!) : null,
      ),
    );
  }
}
