import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/resources/resources.dart';
import 'primary_image.dart';

class PrimaryCircleImage extends StatelessWidget {
  final String? imageUrl;
  final String? svgAsset;
  final String? pngAsset;
  final Widget? child;
  final Widget? placeholder;
  final double radius;
  final Color? backgroundColor;
  const PrimaryCircleImage(
      {super.key,
      this.imageUrl,
      this.child,
      this.radius = 20,
      this.backgroundColor,
      this.svgAsset,
      this.pngAsset,
      this.placeholder});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: radius * 2,
        height: radius * 2,
        color: backgroundColor ?? AppColor.primaryBackgroundColor,
        child: imageUrl != null
            ? PrimaryNetworkImage(
                imageUrl: imageUrl,
                placeHolder: placeholder,
              )
            : svgAsset != null
                ? SvgPicture.asset(
                    svgAsset!,
                    height: 20,
                    width: 20,
                  )
                : Image.asset(
                    pngAsset!,
                    height: 20,
                    width: 20,
                  ),
      ),
    );
  }
}
