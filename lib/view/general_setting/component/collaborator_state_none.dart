import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes.dart';
import '../../../data/resources/resources.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/primary_button.dart';

class CollaboratorStateNone extends StatelessWidget {
  const CollaboratorStateNone({super.key});

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
          const SizedBox(height: 16),
          PrimaryButton(
            context: context,
            onPressed: () => _onRegisterCollaboratorPressed.call(context),
            label: 'Đăng kí ngay ',
          )
        ],
      ),
    );
  }

  _onRegisterCollaboratorPressed(BuildContext context) async {
    Navigator.of(context).pushNamed(AppRoute.affiliateRegisterPage,
        arguments: AffiliateRegisterPageArgs(
            affiliateCubit: context.read(),
            ssoCubit: context.read(),
            agencyCubit: context.read()));
  }
}
