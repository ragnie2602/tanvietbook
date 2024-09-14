import 'dart:async';

import 'package:flutter/material.dart';
import '../../data/resources/colors.dart';

class PrimarySearchTextField extends StatefulWidget {
  const PrimarySearchTextField({
    Key? key,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText = 'Nhập thông tin tìm kiếm',
    this.border,
    this.debounce = 1000,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  final String? label;
  final String? hintText;
  final OutlineInputBorder? border;
  final dynamic prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final Function(String?) onChanged;
  final int debounce;

  @override
  State<PrimarySearchTextField> createState() => _PrimarySearchTextFieldState();
}

class _PrimarySearchTextFieldState extends State<PrimarySearchTextField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: _onSearchChanged,
      decoration: InputDecoration(
        isDense: true,
        enabledBorder: widget.border ??
            const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.neutral5)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor)),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ?? const Icon(Icons.search),
      ),
    );
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
        Duration(milliseconds: widget.debounce), () => widget.onChanged(value));
  }
}
