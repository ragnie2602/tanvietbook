import 'package:flutter/material.dart';

import '../../data/resources/colors.dart';

class BackButtonCustom extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackButtonCustom({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed ??
            () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
        icon: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primaryColor.withOpacity(0.2),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.primaryColor,
              size: 20,
            )));
  }
}
