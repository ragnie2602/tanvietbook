import 'package:flutter/material.dart';
import '../../../data/resources/colors.dart';

class PrimaryContainer extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final ImageProvider? backgroundImage;
  const PrimaryContainer(
      {Key? key,
      this.child,
      this.backgroundColor = AppColor.white,
      this.borderColor,
      this.borderRadius,
      this.padding,
      this.width,
      this.height,
      this.margin,
      this.backgroundImage,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(8),
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(2),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
        image: backgroundImage != null
            ? DecorationImage(image: backgroundImage!, fit: BoxFit.cover)
            : null,
        boxShadow: elevation != null
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0.0, elevation!), //(x,y)
                  blurRadius: 20,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
