import 'package:flutter/material.dart';
import '../../../data/resources/resources.dart';

import '../../../model/member/contact_member_info.dart';
import '../../../model/member/member_detail_info.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/primary_drop_down_button.dart';
import '../../../shared/widgets/share_popup/share_popup.dart';

class MemberActionViewOther extends StatelessWidget {
  final MemberInfo? memberInfo;
  final List<ContactInfoResponse>? contactResponse;
  const MemberActionViewOther(
      {Key? key,
      required this.onSaveContact,
      required this.onRegister,
      this.memberInfo,
      this.contactResponse})
      : super(key: key);

  final Function() onSaveContact;
  final Function() onRegister;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryButton(
              context: context,
              mainAxisSize: MainAxisSize.min,
              icon: Assets.icDownload,
              backgroundColor: AppColor.secondaryColor,
              onPressed: onSaveContact,
              label: 'Lưu danh thiếp'),
          Row(
            children: [
              PrimaryDropdownButton(
                iconData: Icons.share_outlined,
                backgroundColor: AppColor.primaryColor,
                iconColor: AppColor.white,
                items: const [
                  // MenuItems.qrcode,
                  MenuItems.personal,
                  MenuItems.enterprise,
                  // MenuItems.register,
                  // MenuItems.invitationCode,
                ],
                object: memberInfo,
              ),
              const SizedBox(width: 10),
              PrimaryDropdownButton(
                backgroundColor: AppColor.primaryColor,
                iconColor: AppColor.white,
                iconData: Icons.more_vert,
                items: const [
                  MenuItems.call,
                  MenuItems.sendSms,
                  // MenuItems.saveToDevice,
                  MenuItems.saveToOnlinePhoneBook,
                ],
                object: {
                  "memberInfo": memberInfo,
                  "contactResponse": contactResponse
                },
              ),
            ],
          )
        ],
      ),
      Positioned(
        left: 20,
        // height: 100,
        // width: 100,
        child: CustomPaint(
          painter: CrossButtonPainter(),
          child: Container(),
        ),
      ),
    ]);
  }
}
