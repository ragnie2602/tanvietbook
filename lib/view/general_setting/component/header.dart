// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/routes.dart';
import '../../../data/resources/resources.dart';
import '../../../model/member/member_detail_info.dart';
import '../../../shared/widgets/bouncing.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/container/primary_gesture_detector.dart';
import '../../../shared/widgets/image/primary_circle_image.dart';

class InfoHeader extends StatelessWidget {
  MemberInfo info;

  InfoHeader(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      backgroundColor: AppColor.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: PrimaryCircleImage(
                  imageUrl: info.avatar ?? '',
                  radius: 30,
                )),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      info.fullName.toString(),
                      maxLines: 1,
                      style: AppTextTheme.bodyStrong
                          .copyWith(overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '@${info.login}',
                      style: AppTextTheme.bodyRegular,
                    )
                  ],
                )),
          ),
          Bouncing(
            child: PrimaryGestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoute.scannerPage);
              },
              child: SvgPicture.asset(Assets.icScannerGroup),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Image.asset(Assets.imSeller),
        ],
      ),
    );
  }
}
