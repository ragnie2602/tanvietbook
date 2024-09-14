import 'package:flutter/material.dart';
import '../../data/resources/colors.dart';

import 'button_list_item.dart';

class ExpansionButton extends StatelessWidget {
  const ExpansionButton({
    Key? key,
    required this.title,
    required this.subItem,
    required this.onCollabSubItemPressed,
    this.backgroundColor,
  }) : super(key: key);

  final String title;
  final Color? backgroundColor;
  final List<String> subItem;
  final List<Function> onCollabSubItemPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: backgroundColor ?? AppColor.bgField,
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 12),
            title: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
            children: [
              Column(
                children: subItem
                    .map(
                      (subItemText) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: ButtonListItem(
                          title: subItemText,
                          onPress: onCollabSubItemPressed[
                              subItem.indexOf(subItemText)],
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
