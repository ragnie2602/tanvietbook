import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bouncing.dart';

import '../../data/resources/colors.dart';

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({
    super.key,
    required this.context,
    required this.onPressed,
    this.backgroundColor = AppColor.white,
    this.iconColor = Colors.black,
    this.borderColor = AppColor.lightBackground,
    this.icon,
    this.width,
    this.height,
    this.elevation = 0.5,
    this.isClickable = true,
    this.isCircle = false,
    this.contentPadding = const EdgeInsets.all(8),
    this.isMiniumSize = true,
  });

  final BuildContext context;
  final Function() onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final dynamic icon;
  final bool isClickable;
  final bool isCircle;
  final double? width;
  final double? height;
  final double? elevation;
  final EdgeInsets contentPadding;
  final bool isMiniumSize;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      child: ElevatedButton(
        onPressed: () async {
          Future.delayed(const Duration(milliseconds: 100), () {
            onPressed.call();
          });
        },
        style: ButtonStyle(
          fixedSize: isCircle ? MaterialStateProperty.all(const Size(0, 0)) : null,
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          minimumSize: isMiniumSize ? MaterialStateProperty.all(Size.zero) : null,
          padding: MaterialStateProperty.all(contentPadding),
          surfaceTintColor: MaterialStateProperty.all(backgroundColor),
          elevation: MaterialStateProperty.all(elevation),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStateProperty.all(
            isCircle
                ? CircleBorder(
                    side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
                  )
                : RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                    side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
                  ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? Container()
                : icon is String
                    ? SvgPicture.asset(icon, height: 18, width: 18, color: iconColor)
                    : Icon(
                        icon,
                        size: 18,
                        color: iconColor,
                      ),
          ],
        ),
      ),
    );
  }
}
