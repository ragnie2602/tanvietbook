import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/resources/resources.dart';
import '../../../shared/widgets/container/primary_container.dart';

class CollaboratorStateNew extends StatelessWidget {
  const CollaboratorStateNew({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: const EdgeInsets.all(16),
      backgroundColor: AppColor.primaryBackgroundContainer,
      borderColor: AppColor.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cộng tác viên',
            style: AppTextTheme.bodyStrong,
          ),
          const SizedBox(height: 16),
          const Text(
            'Trở thành Cộng tác viên để tăng thêm thu nhập, tích lũy kinh nghiệm phát triển bản thân, thu nhập không giới hạn!',
            style: AppTextTheme.bodyRegular,
          ),
          const SizedBox(height: 10),
          Center(
            child: SvgPicture.asset(
              Assets.icPendingCollaborator,
              height: 120,
            ),
          ),

          const SizedBox(height: 10),
          Center(
            child: Text(
              'Đang chờ phê duyệt',
              style: AppTextTheme.bodyStrong.copyWith(fontSize: 20),
            ),
          ),
          const SizedBox(height: 16),
          // PrimaryButton(
          //   context: context,
          //   onPressed: () =>
          //       _onRegisterCollaboratorPressed.call(context),
          //   label: 'Đăng kí ngay ',
          // )
        ],
      ),
    );
  }
}
