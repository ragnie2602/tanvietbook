import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/routes.dart';
import '../../../../shared/widgets/container/primary_gesture_detector.dart';

import '../../../../data/resources/themes.dart';
import '../../../../model/business/overall/business_overall_response.dart';
import '../../../../shared/widgets/container/primary_container.dart';
import '../../../../shared/widgets/primary_button.dart';

class PostOverall extends StatelessWidget {
  final PostGeneral? postGeneral;
  final String subTabId;

  const PostOverall({Key? key, this.postGeneral, required this.subTabId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quản lí bài đăng',
          style: AppTextTheme.textPrimaryBoldMedium,
        ),
        const SizedBox(height: 12),
        Row(children: [
          _postStatistic("Tổng", postGeneral?.totalCount.toString() ?? ''),
          const SizedBox(width: 5),
          _postStatistic(
              "Hoạt động", postGeneral?.activeCount.toString() ?? ''),
          const SizedBox(width: 5),
          _postStatistic("Đang ẩn", postGeneral?.hidingCount.toString() ?? ''),
          const SizedBox(width: 5),
          _postStatistic(
              "Hết hàng", postGeneral?.soldOutCount.toString() ?? ''),
        ]),
        const SizedBox(height: 10),
        PrimaryContainer(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/im_new_post.svg',
                  height: 102,
                  width: 110,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "Hãy tạo mới bài đăng để website của bạn thật phong phú và thú vị hơn!",
                        style: AppTextTheme.textPrimary,
                      ),
                      const SizedBox(height: 10),
                      PrimaryButton(
                          context: context,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.businessUpdateProduct,
                              arguments: BusinessUpdateProductArgs(
                                  isAddNew: true, subTabId: subTabId),
                            );
                          },
                          label: 'Tạo mới bài đăng'),
                    ],
                  ),
                )
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        PrimaryGestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoute.businessProductManage,
                arguments: BusinessProductManageArgs(subTabId: subTabId));
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/ic_inbox.svg'),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Quản lí bài đăng',
                  style: AppTextTheme.textPrimary,
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_outlined)
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        PrimaryGestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoute.customerInterested);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/ic_team.svg'),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'Khách hàng quan tâm',
                  style: AppTextTheme.textPrimary,
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_outlined)
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _postStatistic(String title, String value) => Expanded(
        child: PrimaryContainer(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Text(
                title,
                style: AppTextTheme.textPrimary,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTextTheme.text70024,
              ),
            ],
          ),
        ),
      );
}
