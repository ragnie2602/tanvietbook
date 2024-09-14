import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/resources/resources.dart';

class PrimaryNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Widget? placeHolder;
  const PrimaryNetworkImage(
      {Key? key,
      required this.imageUrl,
      this.height,
      this.width,
      this.fit = BoxFit.cover,
      this.placeHolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) =>
          placeHolder ?? Image.asset(Assets.imPlaceholder),
      errorWidget: (context, url, value) =>
          placeHolder ?? Image.asset(Assets.imPlaceholder),
      height: height,
      fit: fit,
      width: width,
      imageUrl: imageUrl ?? '',
    );
  }
}
