import 'package:flutter/material.dart';
import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';
import 'back_button.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool canPop;
  final double? elevation;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final TextStyle? style;

  const PrimaryAppBar(
      {Key? key, this.title, this.actions, this.leading, this.backgroundColor, this.canPop = true, this.onBackPressed, this.centerTitle = false, this.elevation = 0.5, this.style})
      : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColor.bgColor,
      title: Text(title ?? '', style: style ?? AppTextTheme.textPrimaryBoldMedium),
      elevation: elevation,
      leading: leading ?? (canPop ? const BackButtonCustom() : null),
      actions: actions,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
