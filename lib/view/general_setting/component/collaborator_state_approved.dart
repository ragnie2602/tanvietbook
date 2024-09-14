import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes.dart';
import '../../../data/resources/resources.dart';
import 'affiliate_register.dart';

class CollaboratorStateApproved extends StatelessWidget {
  const CollaboratorStateApproved({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegiterInfoItem(
          icon: Assets.imRegisterInfo,
          title: 'Thông tin đăng ký',
          detail:
              'Đây là những thông tin bạn cung cấp cho chúng tôi lúc đăng ký',
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoute.affiliateRegisterInfoPage,
              arguments: AffiliateRegisterInfoPageArgs(
                affiliateCubit: context.read(),
              ),
            );
          },
        ),
        const Divider(color: AppColor.neutral5),
        const SizedBox(height: 10),
        RegiterInfoItem(
          icon: Assets.imMemberInfo,
          title: 'Thông tin cộng tác viên',
          detail: 'Đây là những thông tin liên quan đến đội nhóm của bạn',
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoute.affiliateComissionInfoPage,
              arguments: AffiliateComissionInfoPageArgs(
                affiliateCubit: context.read(),
              ),
            );
          },
        ),
        const Divider(
          color: AppColor.neutral5,
        ),
        const SizedBox(height: 10),
        RegiterInfoItem(
          icon: Assets.imAffiliateHistory,
          title: 'Thông tin hoa hồng ',
          detail: 'Đây là những thông tin liên quan đến hoa hồng của bạn',
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoute.affiliateComissionHistoryPage,
              arguments: AffiliateComissionHistoryPageArgs(
                affiliateCubit: context.read(),
              ),
            );
          },
        ),
      ],
    );
  }
}
