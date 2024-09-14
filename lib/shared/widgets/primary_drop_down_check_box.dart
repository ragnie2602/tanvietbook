import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../model/business/category/business_category_response.dart';

import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';

class PrimaryDropDownCheckBox<T> extends StatefulWidget {
  final List<T> items;
  final List<T> initialItems;
  final dynamic Function(List<T> value) onChanged;
  final BoxDecoration? decoration;
  final String? hintText;
  final TextEditingController controller;
  final Color? fillColor;
  final Color? borderColor;
  final bool? filled;

  const PrimaryDropDownCheckBox({
    Key? key,
    required this.items,
    this.initialItems = const [],
    this.decoration,
    required this.onChanged,
    this.hintText,
    required this.controller,
    this.fillColor,
    this.filled = false,
    this.borderColor,
  }) : super(key: key);

  @override
  State<PrimaryDropDownCheckBox> createState() =>
      _PrimaryDropDownCheckBoxState<T>();
}

class _PrimaryDropDownCheckBoxState<T>
    extends State<PrimaryDropDownCheckBox<T>> {
  Object? value;

  List<T> selectedItems = [];

  @override
  void initState() {
    selectedItems.addAll(widget.initialItems.map((e) => e));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      // buttonHighlightColor: AppColor.btPrimary,
      // buttonSplashColor: AppColor.primaryColor,
      // dropdownDecoration: BoxDecoration(
      //   color: AppColor.white,
      //   borderRadius: BorderRadius.circular(2),
      // ),
      // offset: const Offset(-8, -10),

      value: selectedItems.isEmpty ? null : selectedItems.first,
      items: widget.items.map<DropdownMenuItem<Object>>((dynamic value) {
        return DropdownMenuItem(
          value: value,
          enabled: false,
          child: StatefulBuilder(
            builder: (context, menuSetState) {
              final isSelected = selectedItems.contains(value);
              return InkWell(
                onTap: () {
                  isSelected
                      ? selectedItems.remove(value)
                      : selectedItems.add(value as T);
                  //This rebuilds the StatefulWidget to update the button's text
                  setState(() {});

                  //This rebuilds the dropdownMenu Widget to update the check mark
                  menuSetState(() {});
                  log(selectedItems.runtimeType.toString());
                  log(widget.onChanged.runtimeType.toString());
                  (widget.onChanged).call(selectedItems);
                },
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isSelected
                          ? const Icon(
                              Icons.check_box,
                              color: AppColor.primaryColor,
                            )
                          : const Icon(Icons.check_box_outline_blank),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          value is BusinessCategoryResponse
                              ? (value.categoryName ?? '')
                              : '',
                          style: AppTextTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
      selectedItemBuilder: (context) {
        return widget.items.map(
          (item) {
            return Text(
              (selectedItems is List<BusinessCategoryResponse>
                      ? selectedItems
                          .map((e) =>
                              (e as BusinessCategoryResponse).categoryName ??
                              '')
                          .toList()
                      : [])
                  .join(', '),
              style: AppTextTheme.textPrimary,
              maxLines: 3,
            );
          },
        ).toList();
      },

      onChanged: (value) {},
      isExpanded: true,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
        hintText: widget.hintText,
        hintStyle: AppTextTheme.textPrimaryGray05,
        labelStyle: AppTextTheme.textPrimary,
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.gray04),
          borderRadius: BorderRadius.circular(2),
        ),
        fillColor: widget.fillColor,
        enabledBorder: widget.borderColor != null
            ? OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor!))
            : null,
        focusedBorder: widget.borderColor != null
            ? OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor!))
            : null,
        filled: widget.filled,
      ),
    );
  }
}
