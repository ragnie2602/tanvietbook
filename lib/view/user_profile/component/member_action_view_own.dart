import 'package:flutter/material.dart';
import '../../../data/resources/resources.dart';
import '../../../shared/widgets/primary_drop_down_button.dart';

import '../../../model/member/member_detail_info.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/primary_icon_button.dart';
import '../../../shared/widgets/share_popup/share_popup.dart';

class MemberActionViewOwn extends StatelessWidget {
  const MemberActionViewOwn({
    Key? key,
    required this.onViewAsGuestPressed,
    required this.onShareButtonPressed,
    required this.memberInfo,
    required this.onEditButtonPressed,
    required this.onSettingsButtonPressed,
  }) : super(key: key);
  final MemberInfo memberInfo;
  final Function() onViewAsGuestPressed;
  final Function() onShareButtonPressed;
  final Function() onEditButtonPressed;
  final Function() onSettingsButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PrimaryButton(
          context: context,
          onPressed: onViewAsGuestPressed,
          icon: Icons.remove_red_eye_outlined,
          iconColor: AppColor.white,
          label: 'Xem chế độ khách',
          mainAxisSize: MainAxisSize.min,
        ),
        const Spacer(),
        PrimaryDropdownButton(
          object: memberInfo,
          items: const [
            MenuItems.qrcode,
            MenuItems.personal,
            // MenuItems.enterprise,
            MenuItems.register,
            MenuItems.invitationCode,
          ],
          iconData: Assets.icShare,
        ),
        const SizedBox(
          width: 8,
        ),
        PrimaryIconButton(
          context: context,
          onPressed: onEditButtonPressed,
          icon: Assets.icEdit,
          iconColor: AppColor.primaryColor,
          // borderColor: AppColor.primaryColor,
        ),
        const SizedBox(
          width: 8,
        ),
        PrimaryIconButton(
          context: context,
          onPressed: onSettingsButtonPressed,
          iconColor: AppColor.primaryColor,
          icon: Assets.icSetting,
          // borderColor: AppColor.primaryColor,
        )
      ],
    );
  }
}
