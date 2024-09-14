import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/container/primary_container.dart';

import '../../../data/resources/resources.dart';
import '../../../shared/widgets/primary_icon_button.dart';
import '../../../shared/widgets/primary_switch.dart';

class UserContainerBlock extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? subTitle;
  final bool isExpandable;
  final bool showAction;
  final bool showEditButton;
  final bool showAddButton;
  final bool showSwitchButton;
  final bool switchInitialValue;
  final bool showConfigItemButton;
  final bool initialExpanded;
  final EdgeInsets? contentPadding;
  final Function()? onAddButtonPressed;
  final Function()? onEditButtonPressed;
  final Function()? onConfigButtonPressed;
  final Function(bool)? onSwitchValueChanged;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final Color? borderColor;
  final Color? backgroundColor;
  final Widget child;

  const UserContainerBlock(
      {super.key,
      this.isExpandable = true,
      this.showAction = true,
      this.showAddButton = true,
      this.showEditButton = true,
      this.showSwitchButton = true,
      this.switchInitialValue = true,
      this.showConfigItemButton = true,
      this.onAddButtonPressed,
      this.onEditButtonPressed,
      this.onConfigButtonPressed,
      this.onSwitchValueChanged,
      required this.title,
      required this.icon,
      required this.child,
      this.contentPadding,
      this.subTitle,
      this.titleStyle,
      this.subTitleStyle,
      this.backgroundColor,
      this.borderColor,
      this.initialExpanded = true});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      elevation: 10,
      backgroundColor: AppColor.white,
      borderRadius: BorderRadius.circular(10),
      borderColor: borderColor,
      margin: const EdgeInsets.only(top: 16),
      padding: EdgeInsets.zero,
      child: isExpandable
          ? ExpandableNotifier(
              initialExpanded: initialExpanded,
              child: ScrollOnExpand(
                child: PrimaryContainer(
                  padding: EdgeInsets.zero,
                  backgroundColor:
                      backgroundColor ?? AppColor.primaryColor.withOpacity(.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderColor: borderColor ?? AppColor.primaryColor,
                  child: ExpandablePanel(
                    header: containerHeader(context),
                    collapsed: const SizedBox(),
                    expanded: PrimaryContainer(
                      width: double.infinity,
                      backgroundColor: AppColor.white,
                      padding: contentPadding ??
                          const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: child,
                    ),
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      iconColor: AppColor.white,
                    ),
                  ),
                ),
              ),
            )
          : Column(
              children: [
                containerHeader(context),
                Padding(
                  padding: contentPadding ??
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: child,
                )
              ],
            ),
    );
  }

  Widget containerHeader(BuildContext context) => PrimaryContainer(
        padding: const EdgeInsets.symmetric(vertical: 16),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        backgroundColor: !isExpandable
            ? backgroundColor ?? AppColor.primaryColor.withOpacity(0.5)
            : backgroundColor ?? AppColor.primaryColor.withOpacity(0.00001),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Row(
            children: [
              if (icon != null) icon!,
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: titleStyle ?? AppTextTheme.textPrimaryBoldMedium),
                  if (subTitle != null) const SizedBox(height: 8),
                  if (subTitle != null)
                    Text(subTitle ?? '',
                        style: subTitleStyle ??
                            AppTextTheme.textPrimaryBoldMedium),
                ],
              ),
              const Spacer(),
              !showAction
                  ? const SizedBox()
                  : Row(
                      children: [
                        if (showAddButton)
                          PrimaryIconButton(
                            context: context,
                            onPressed: () => onAddButtonPressed?.call(),
                            icon: Icons.add,
                            iconColor: AppColor.primaryColor,
                          ),
                        if (showAddButton) const SizedBox(width: 10),
                        if (showConfigItemButton)
                          PrimaryIconButton(
                            context: context,
                            onPressed: () => onConfigButtonPressed?.call(),
                            iconColor: AppColor.primaryColor,
                            icon: Assets.icSetting,
                          ),
                        if (showConfigItemButton) const SizedBox(width: 10),
                        if (showEditButton)
                          PrimaryIconButton(
                            context: context,
                            icon: Assets.icEdit,
                            iconColor: AppColor.primaryColor,
                            onPressed: () => onEditButtonPressed?.call(),
                          ),
                        if (showEditButton) const SizedBox(width: 8),
                        if (showSwitchButton)
                          PrimarySwitch(
                            onToggle: (value) =>
                                onSwitchValueChanged?.call(value),
                            initialValue: switchInitialValue,
                          ),
                      ],
                    )
            ],
          ),
        ),
      );
}
