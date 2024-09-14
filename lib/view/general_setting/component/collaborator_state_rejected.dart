import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes.dart';
import '../../../data/resources/resources.dart';
import '../../../model/member/collaborator/collaborator_response.dart';
import 'affiliate_register.dart';

class CollaboratorStateRejected extends StatelessWidget {
  final CollaboratorResponse? collaboratorResponse;

  const CollaboratorStateRejected(
      {super.key, required this.collaboratorResponse});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Bị từ chối',
            style:
                AppTextTheme.titleMedium.copyWith(color: AppColor.errorColor),
          ),
        ),
        const SizedBox(height: 20),
        RegiterInfoItem(
          icon: Assets.imRegisterInfo,
          title: 'Thông tin đăng ký',
          detail:
              'Đây là những thông tin bạn cung cấp cho chúng tôi lúc đăng ký',
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoute.affiliateRegisterPage,
              arguments: AffiliateRegisterPageArgs(
                affiliateCubit: context.read(),
                ssoCubit: context.read(),
                agencyCubit: context.read(),
                collaboratorResponse: collaboratorResponse,
              ),
            );
          },
        ),
        const Divider(
          color: AppColor.neutral5,
        ),
      ],
    );
  }
}
