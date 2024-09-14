import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../data/resources/colors.dart';

class Loading extends StatelessWidget {
  const Loading(
      {Key? key, this.backgroundColor, this.size = 50, this.spinnerColor, this.spinnerSize = 50, this.message})
      : super(key: key);

  final Color? backgroundColor;
  final Color? spinnerColor;
  final double size;
  final double spinnerSize;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppColor.white,
        child: Lottie.asset('assets/animations/loading.json', width: 100, height: 100, fit: BoxFit.scaleDown),
      ),
    );
  }
}
