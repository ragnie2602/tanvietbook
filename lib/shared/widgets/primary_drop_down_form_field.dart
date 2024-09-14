import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';

class PrimaryDropDownFormField extends StatefulWidget {
  final List<String> items;
  final Function(String?, int)? onChanged;
  final String? initialValue;
  final EdgeInsets? contentPadding;
  final BoxDecoration? decoration;
  final Widget? dropdownIcon;
  final bool enabled;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextEditingController controller;
  final Color? fillColor;
  final Color? borderColor;
  final bool? filled;
  final TextStyle? textStyle;

  final Widget Function(dynamic value)? child;

  const PrimaryDropDownFormField({
    Key? key,
    required this.items,
    this.contentPadding,
    this.decoration,
    this.dropdownIcon,
    this.enabled = true,
    this.onChanged,
    this.initialValue,
    this.hintText,
    this.hintTextStyle,
    this.child,
    required this.controller,
    this.fillColor,
    this.filled = false,
    this.borderColor,
    this.textStyle,
  }) : super(key: key);

  @override
  State<PrimaryDropDownFormField> createState() => _PrimaryDropDownFormFieldState();
}

class _PrimaryDropDownFormFieldState extends State<PrimaryDropDownFormField> {
  String? value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      child: DropdownButtonFormField2(
        value: value,
        style: widget.textStyle,
        items: widget.items.map<DropdownMenuItem<String>>((String localValue) {
          return DropdownMenuItem(
              value: localValue,
              child: widget.child == null
                  ? Text(localValue,
                      style: AppTextTheme.textPrimary
                          .copyWith(fontWeight: localValue == value ? FontWeight.w700 : FontWeight.normal))
                  : widget.child!.call(localValue));
        }).toList(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        iconStyleData: IconStyleData(icon: widget.dropdownIcon ?? const Icon(Icons.arrow_drop_down_sharp)),
        selectedItemBuilder: (context) => widget.items.map<DropdownMenuItem<String>>((String localValue) {
          return DropdownMenuItem(
              value: localValue,
              child: Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: widget.child == null
                      ? Text(localValue, style: widget.textStyle ?? AppTextTheme.textPrimary)
                      : widget.child!.call(localValue)));
        }).toList(),
        onChanged: widget.enabled
            ? (String? value) {
                setState(() {
                  this.value = value.toString();
                  widget.controller.text = value.toString();
                });
                widget.onChanged?.call(value, widget.items.indexOf(value!));
              }
            : null,
        isExpanded: true,
        dropdownStyleData: DropdownStyleData(
            width: 220, decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(4))),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: widget.contentPadding ?? const EdgeInsets.all(8),
          hintText: widget.hintText,
          hintStyle: widget.hintTextStyle ?? AppTextTheme.textPrimaryGray05,
          labelStyle: widget.textStyle ?? AppTextTheme.textPrimary,
          errorMaxLines: 2,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.gray04), borderRadius: BorderRadius.circular(2)),
          fillColor: widget.fillColor,
          enabledBorder: widget.borderColor != null
              ? OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor!))
              : null,
          focusedBorder: widget.borderColor != null
              ? OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor!))
              : null,
          filled: widget.filled,
          enabled: widget.enabled,
        ),
      ),
    );
  }
}
