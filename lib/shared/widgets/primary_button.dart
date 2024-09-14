import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';
import 'bouncing.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.context,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.textStyle = AppTextTheme.textButtonPrimary,
    this.icon,
    this.isLoading = false,
    this.isClickable = true,
    this.isCircle = false,
    this.elevation = 0.5,
    this.contentPadding = const EdgeInsets.all(10),
    this.mainAxisSize = MainAxisSize.max,
    this.alignment = Alignment.center,
    this.borderRadius,
  });

  final BuildContext context;
  final Function() onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final TextStyle textStyle;
  final dynamic icon;
  final bool isLoading;
  final bool isClickable;
  final bool isCircle;
  final EdgeInsets contentPadding;
  final double? elevation;
  final MainAxisSize mainAxisSize;
  final Alignment alignment;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      child: ElevatedButton(
        onPressed: () async {
          Future.delayed(const Duration(milliseconds: 100), () {
            onPressed.call();
          });
        },
        // color: backgroundColor ?? AppColor.primaryColor,
        // splashColor: (backgroundColor ?? AppColor.primaryColor).withOpacity(0.9),
        // elevation: 4,
        // // highlightElevation: 26,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        style: ButtonStyle(
          fixedSize: isCircle ? MaterialStateProperty.all(const Size(0, 0)) : null,
          backgroundColor: MaterialStateProperty.all(
            backgroundColor ?? AppColor.secondaryColor,
          ),
          alignment: alignment,
          minimumSize: MaterialStateProperty.all(Size.zero),
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
                    borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(3)),
                    side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
                  ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: mainAxisSize,
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
            (icon == null)
                ? Container()
                : (!isCircle)
                    ? SizedBox(width: label == '' ? 0 : 5)
                    : Container(),
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(label, style: textStyle),
          ],
        ),
      ),
    );
  }
}
