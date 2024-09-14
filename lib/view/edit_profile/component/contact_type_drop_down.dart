import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../data/resources/resources.dart';
import '../../../model/member/contact_default_type_response.dart';
import '../../../shared/etx/view_extensions.dart';
import '../../../shared/widgets/primary_search_text_field.dart';

class ContactTypeDropDown extends StatefulWidget {
  final List<ContactDefaultTypeResponse> items;
  final Function(ContactDefaultTypeResponse contactDefaultTypeResponse)?
      onChanged;
  final ContactDefaultTypeResponse? initialValue;
  final BoxDecoration? decoration;
  final String? hintText;
  final TextEditingController controller;
  final bool readOnly;

  final Widget Function(dynamic value)? child;

  const ContactTypeDropDown({
    Key? key,
    required this.items,
    this.decoration,
    this.onChanged,
    this.initialValue,
    this.hintText,
    this.child,
    required this.controller,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<ContactTypeDropDown> createState() => _ContactTypeDropDownState();
}

class _ContactTypeDropDownState extends State<ContactTypeDropDown> {
  late ContactDefaultTypeResponse? value;
  final searchController = TextEditingController();

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<ContactDefaultTypeResponse>(
        // dropdownMaxHeight: context.screenHeight * 0.5,
        // dropdownDecoration: BoxDecoration(
        //   color: AppColor.white,
        //   borderRadius: BorderRadius.circular(2),
        // ),
        value: value,
        items: widget.items.map<DropdownMenuItem<ContactDefaultTypeResponse>>(
            (ContactDefaultTypeResponse value) {
          return DropdownMenuItem(
            value: value,
            child: Row(
              children: [
                Image.network(
                  value.iconUrl ?? '',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(value.label ?? '', style: AppTextTheme.bodyStrong),
              ],
            ),
          );
        }).toList(),
        onChanged: widget.readOnly
            ? null
            : (value) {
                setState(() {
                  this.value = value!;
                  widget.controller.text = value.type ?? '';
                });
                widget.onChanged?.call(value!);
              },
        isExpanded: true,
        // iconSize: 24,
        // offset: const Offset(-12, -8),
        // itemPadding:
        //     const EdgeInsets.only(top: 8, bottom: 8, right: 12, left: 12),
        // buttonDecoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(2),
        //   border: Border.all(color: AppColor.neutral5),
        // ),
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(right: 12, left: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: AppColor.neutral5),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
            maxHeight: context.screenHeight * 0.5,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
            )),
        dropdownSearchData: DropdownSearchData(
          searchController: searchController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: PrimarySearchTextField(
              controller: searchController,
              onChanged: (p0) {},
              debounce: 0,
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return (item.value?.label ?? '')
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchController.clear();
          }
        },
        hint: widget.hintText != null
            ? Text(
                widget.hintText!,
                style: AppTextTheme.bodyMedium,
              )
            : null,
      ),
    );
  }
}
