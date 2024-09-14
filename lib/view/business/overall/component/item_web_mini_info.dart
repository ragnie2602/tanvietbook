import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../data/resources/themes.dart';

class ItemWebMiniInfo extends StatelessWidget {
  final String text;
  const ItemWebMiniInfo({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset("assets/icons/ic_check.svg"),
        const SizedBox(width: 5),
        Text(
          text,
          style: AppTextTheme.textPrimary,
        ),
      ],
    );
  }
}
