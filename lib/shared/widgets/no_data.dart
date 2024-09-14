import 'package:flutter/material.dart';

import '../../../data/resources/resources.dart';

class NoData extends StatelessWidget {
  final String message;
  const NoData({super.key, this.message = 'Không có dữ liệu'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppTextTheme.textLowPriority,
      ),
    );
  }
}
