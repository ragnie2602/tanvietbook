import 'package:flutter/material.dart';

import '../../data/resources/colors.dart';

class PrimaryDivider extends StatelessWidget {
  final Color? color;
  final double? thickness;
  const PrimaryDivider({Key? key, this.color, this.thickness})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness ?? 0.5,
      color: color ?? AppColor.primaryBackgroundColor,
    );
  }
}
