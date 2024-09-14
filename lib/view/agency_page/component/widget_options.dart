import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/resources/resources.dart';

class WidgetOption extends StatelessWidget {
  final String path;
  final String widgetName;
  final int align;

  const WidgetOption(
      {super.key,
      required this.path,
      required this.widgetName,
      required this.align});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align == -1
          ? CrossAxisAlignment.start
          : align == 0
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.end,
      children: [
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3))
              ],
              color: AppColor.bgItemColor,
            ),
            height: 50,
            width: 50,
            child: path.substring(path.length - 3) == "png"
                ? Image.asset(
                    path,
                    height: 30,
                    width: 30,
                    fit: BoxFit.none,
                  )
                : SvgPicture.asset(
                    path,
                    height: 30,
                    width: 30,
                    fit: BoxFit.none,
                  ),
          ),
          onTap: () {},
        ),
        const SizedBox(
          height: 26,
        ),
        Text(widgetName, style: AppTextTheme.bodyRegular),
        const SizedBox(
          height: 9,
        )
      ],
    );
  }
}
