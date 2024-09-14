import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../view/business/bloc/business_bloc.dart';

import '../../../data/resources/resources.dart';
import '../../utils/utils.dart';
import '../primary_button.dart';
import '../primary_search_text_field.dart';

class TextFieldSearchWithFilter extends StatefulWidget {
  final String? initialFilterValue;
  final Widget? filterWidget;
  final Function(dynamic value)? onDispose;
  const TextFieldSearchWithFilter(
      {super.key, this.initialFilterValue, this.filterWidget, this.onDispose});

  @override
  State<TextFieldSearchWithFilter> createState() =>
      _TextFieldSearchWithFilterState();
}

class _TextFieldSearchWithFilterState extends State<TextFieldSearchWithFilter> {
  void _onFilterPressed() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => FractionallySizedBox(
              heightFactor: 0.8,
              child: widget.filterWidget,
            )).then((value) {
      if (value == null) return null;

      if (value is BusinessManageFilterData) {
        log(value.currentCategoryName.toString());
        final List<String> filterList = [];
        if (value.currentCategoryName != null) {
          filterList.addAll(value.currentCategoryName ?? []);
        }
        if (value.isSoldOut) {
          filterList.add('Hết hàng');
        }
        if (value.isHidden) {
          filterList.add('Đang ẩn');
        }
        if (value.rangeFrom != null && value.rangeTo != null) {
          filterList.add(
              '${Utils.formatMoney(value.rangeFrom!)}-${Utils.formatMoney(value.rangeTo!)}');
        }
        if (filterList.length != filterValue.length) {
          setState(() {
            filterValue.clear();
            filterValue.addAll(filterList);
          });
        } else {
          for (int i = 0; i < filterList.length; i++) {
            if (filterList[i] != filterValue[i]) {
              setState(() {
                filterValue.clear();
                filterValue.addAll(filterList);
              });
              break;
            }
          }
        }
      }

      return widget.onDispose?.call(true);
    });
  }

  final filterValue = <String>[];

  @override
  void initState() {
    if (widget.initialFilterValue != null) {
      filterValue.add(widget.initialFilterValue!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimarySearchTextField(
            controller: TextEditingController(),
            onChanged: (keyword) {},
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.search),
                const SizedBox(width: 8),
                PrimaryButton(
                  context: context,
                  onPressed: _onFilterPressed,
                  label: 'Lọc',
                  icon: Assets.icFilter,
                  iconColor: AppColor.white,
                ),
              ],
            ),
          ),
          filterValue.isNotEmpty
              ? Wrap(
                  spacing: 8,
                  children: List.from(filterValue.map(
                    (e) => Chip(
                      deleteIconColor: AppColor.gray05,
                      onDeleted: () {
                        setState(() {
                          filterValue.remove(e);
                        });
                        widget.onDispose?.call(true);
                      },
                      label: Text(
                        e,
                        style: AppTextTheme.textPrimary
                            .copyWith(color: const Color(0xFF52C41A)),
                      ),
                      deleteIcon: const Icon(Icons.clear_rounded),
                      backgroundColor: const Color(0xFFF6FFED),
                      side: const BorderSide(color: Color(0xFFB7EB8F)),
                    ),
                  )),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
