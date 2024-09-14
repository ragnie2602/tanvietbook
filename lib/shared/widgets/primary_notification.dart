import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/resources/resources.dart';
import '../etx/view_extensions.dart';
import 'primary_button.dart';

class PrimaryNotification extends StatelessWidget {
  final Function()? approve;
  final Function()? cancel;
  final String text;

  const PrimaryNotification({super.key, this.approve, this.cancel, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.transparent,
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          color: AppColor.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          spreadRadius: 0)
                    ],
                    color: AppColor.white),
                padding: const EdgeInsets.all(16),
                width: context.screenWidth * 308 / 377,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SvgPicture.asset(Assets.icNotification2),
                    const SizedBox(width: 4),
                    Text('THÔNG BÁO', style: AppTextTheme.subTitle2.copyWith(color: AppColor.green01))
                  ]),
                  const SizedBox(height: 16),
                  Text(text, style: AppTextTheme.subTitle2, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  Row(children: [
                    if (cancel != null)
                      Expanded(
                          child: PrimaryButton(
                              backgroundColor: AppColor.neutral5,
                              context: context,
                              mainAxisSize: MainAxisSize.min,
                              onPressed: cancel!,
                              label: 'Hủy bỏ')),
                    if (approve != null && cancel != null) const SizedBox(width: 16),
                    if (approve != null)
                      Expanded(
                          child: PrimaryButton(
                              backgroundColor: AppColor.green01,
                              context: context,
                              mainAxisSize: MainAxisSize.min,
                              onPressed: approve!,
                              label: 'Đồng ý')),
                  ])
                ]))));
  }
}
