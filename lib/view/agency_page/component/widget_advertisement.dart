import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../shared/widgets/primary_button.dart';

class WidgetAdvertisement extends StatelessWidget {
  final String imagePath;
  final String buttonString;
  final dynamic onPressed;

  const WidgetAdvertisement(
      {super.key,
      required this.imagePath,
      required this.buttonString,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height / 3),
      width: MediaQuery.of(context).size.width,
      color: AppColor.bgColor,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath,
              width: MediaQuery.of(context).size.width - 44,
              height: MediaQuery.of(context).size.height * 5 / 21,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width - 88,
                child: PrimaryButton(
                    context: context,
                    onPressed: onPressed,
                    label: buttonString)),
          ]),
    );
  }
}
