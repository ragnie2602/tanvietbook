import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/resources/resources.dart';
import 'bouncing.dart';
import 'share_popup/menu_item.dart';
import 'share_popup/share_popup.dart';

class PrimaryDropdownButton extends StatelessWidget {
  final List<MenuItem> items;
  final dynamic object;
  final dynamic iconData;
  final Color? iconColor;
  final bool? isExpanded;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? child;

  const PrimaryDropdownButton(
      {Key? key,
      required this.items,
      this.object,
      required this.iconData,
      this.child,
      this.iconColor,
      this.isExpanded,
      this.backgroundColor,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Bouncing(
          child: Material(
            elevation: 0.5,
            borderRadius: BorderRadius.circular(2),
            color: backgroundColor ?? AppColor.lightBackground,
            child: Container(
              // decoration: BoxDecoration(
              //     border: Border.all(color: AppColor.primaryColor)),
              padding: const EdgeInsets.all(8),
              child: iconData is String
                  ? SvgPicture.asset(
                      Assets.icShare,
                      color: iconColor ?? AppColor.primaryColor,
                      height: 18,
                      width: 18,
                    )
                  : Icon(
                      iconData,
                      size: 18,
                      color: iconColor ?? AppColor.primaryColor,
                    ),
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
            width: 220,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
            )),
        items: [
          ...MenuItems(items: items).items.map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              )
        ],
        isExpanded: isExpanded ?? false,
        onChanged: (value) =>
            MenuItems.onChanged(context, value as MenuItem, object: object),
      ),
    );
  }
}
