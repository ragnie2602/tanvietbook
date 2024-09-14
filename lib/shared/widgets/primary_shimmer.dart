import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/resources/colors.dart';
import 'container_shimmer.dart';

class PrimaryShimmer extends StatelessWidget {
  const PrimaryShimmer({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.neutral5,
      highlightColor: Colors.white,
      period: const Duration(milliseconds: 1500),
      direction: ShimmerDirection.ltr,
      child: child ?? const ContainerShimmer(),
    );
  }
}
