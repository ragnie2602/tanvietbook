import 'package:flutter/material.dart';

import '../../../data/constants.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';

class OrderStatusTextWidget extends StatelessWidget {
  const OrderStatusTextWidget({
    super.key,
    required this.status,
    required this.statusStr,
  });

  final int? status;
  final String? statusStr;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$statusStr',
      style: AppTextTheme.bodyStrong.copyWith(
          color: status == OrderStatus.canceled
              ? AppColor.errorColor
              : status == OrderStatus.delivered
                  ? AppColor.green
                  : status == OrderStatus.delivering
                      ? const Color.fromARGB(255, 0, 92, 141)
                      : status == OrderStatus.refunded
                          ? const Color.fromARGB(255, 82, 10, 0)
                          : status == OrderStatus.packaging
                              ? const Color.fromARGB(255, 193, 90, 0)
                              : AppColor.primaryColor),
    );
  }
}
