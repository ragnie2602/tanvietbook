import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';

class PrimaryGestureDetector extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  final Color? splashColor;
  final Color? highlightColor;
  const PrimaryGestureDetector(
      {Key? key,
      this.onTap,
      required this.child,
      this.splashColor = Colors.transparent,
      this.highlightColor = AppColor.gray09})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}
