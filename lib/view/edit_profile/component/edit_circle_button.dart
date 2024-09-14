import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/widgets/bouncing.dart';

import '../../../data/resources/colors.dart';

class EditCircleButton extends StatelessWidget {
  const EditCircleButton({Key? key, required this.onEditPressed})
      : super(key: key);

  final Function() onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      child: GestureDetector(
        onTap: onEditPressed,
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
            child: SvgPicture.asset(
              'assets/icons/ic_edit.svg',
            )),
      ),
    );
  }
}
