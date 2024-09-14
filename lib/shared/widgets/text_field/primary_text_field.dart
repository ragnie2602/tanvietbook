import 'package:flutter/material.dart';

import '../../../data/resources/resources.dart';

class PrimaryTextField extends StatelessWidget {
  final double? borderRadius;
  final BorderSide? borderSide;
  final TextEditingController? controller;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextInputType? keyboardType;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final EdgeInsets? padding;
  final TextStyle? style;

  const PrimaryTextField(
      {super.key,
      this.borderRadius,
      this.borderSide,
      this.controller,
      this.enabledBorder,
      this.focusedBorder,
      this.keyboardType,
      this.maxLines,
      this.onChanged,
      this.onTap,
      this.padding,
      this.style});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 2), borderSide: borderSide ?? const BorderSide(color: Color(0xFFD9D9D9), width: 1)),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 2), borderSide: borderSide ?? const BorderSide(color: Color(0xFFD9D9D9), width: 1)),
            isDense: true),
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
        onTap: onTap,
        style: style ?? AppTextTheme.bodyRegular);
  }
}
