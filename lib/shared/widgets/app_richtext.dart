import 'package:flutter/material.dart';

import '../../data/resources/colors.dart';

class AppRichText extends StatelessWidget {
  final double fontSize;
  final TextSpan? prefix;
  final TextSpan? suffix;
  const AppRichText({
    super.key,
    this.fontSize = 20,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        prefix ?? const TextSpan(),
        TextSpan(
          text: 'TÂN VIỆT BOOKS ',
          style: TextStyle(
              color: AppColor.secondaryColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              fontFamily: 'Lato'),
        ),
        suffix ?? const TextSpan(),
      ]),
    );
  }
}
