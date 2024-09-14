import 'package:flutter/material.dart';
import '../../../data/constants.dart';
import '../../../data/repository/remote/phonebook_repository.dart';
import '../../../di/di.dart';
import '../../../model/member/contact_member_info.dart';

import '../../../config/config.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../model/api/base_response.dart';
import '../../../model/member/member_detail_info.dart';
import '../../../view/qrcode/my_qrcode.dart';
import '../../utils/utils.dart';
import '../../utils/view_utils.dart';
import 'menu_item.dart';

class MenuItems {
  final List<MenuItem> items;

  const MenuItems({required this.items});

  static const qrcode = MenuItem(text: 'Mã QR', icon: Icons.qr_code_2_outlined);
  static const personal =
      MenuItem(text: 'Cá nhân', icon: Icons.person_2_outlined);
  static const enterprise =
      MenuItem(text: 'Doanh nghiệp', icon: Icons.business);
  static const register = MenuItem(text: 'Đăng ký', icon: Icons.person_add_alt);
  static const invitationCode =
      MenuItem(text: 'Mã giới thiệu', icon: Icons.code);

  static const call = MenuItem(text: 'Gọi điện', icon: Icons.call);
  static const sendSms = MenuItem(text: 'Nhắn tin', icon: Icons.sms);
  static const saveToDevice =
      MenuItem(text: 'Lưu vào thiết bị của bạn', icon: Icons.save_alt);
  static const saveToOnlinePhoneBook =
      MenuItem(text: 'Lưu vào danh bạ Online', icon: Icons.save);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: AppColor.primaryColor, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: AppTextTheme.textPrimary,
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item,
      {dynamic object}) async {
    switch (item) {
      case MenuItems.qrcode:
        object as MemberInfo;
        showDialog(
            context: context,
            builder: (_) => MyQrCode(
                  username: object.login ?? '',
                  fullName: object.fullName ?? '',
                  avatarUrl: object.avatar ?? '',
                ));
        break;
      case MenuItems.enterprise:
        object as MemberInfo;
        Utils.share(
            content:
                '${Environment.profileDomain}/profile/${object.login ?? ''}/store/view/',
            context: context,
            subject: 'Chia sẻ doanh nghiệp');
        break;
      case MenuItems.personal:
        object as MemberInfo;
        Utils.share(
            content:
                '${Environment.profileDomain}/profile/${object.login ?? ''}',
            context: context,
            subject: 'Chia sẻ trang cá nhân');
        break;
      case MenuItems.register:
        object as MemberInfo;
        Utils.share(
            content:
                '${SSOConfig.issuer}/Account/Register?s=${AppConfig.agencyName}&r=${object.login ?? ''}',
            context: context,
            subject: 'Đăng kí tài khoản TrueConnect');
        break;

      case MenuItems.invitationCode:
        object as MemberInfo;
        Utils.share(
            content:
                'Xin vui lòng nhập mã giới thiệu "${object.login ?? ''}" để đăng ký tài khoản khi quét mã QR nhận được.',
            context: context,
            subject: 'Mã giới thiệu của ${object.login ?? ''}');
        break;

      case MenuItems.call:
        object as Map<String, dynamic>;
        try {
          List<ContactInfoResponse> contactResponse = object["contactResponse"];
          var contact = contactResponse.firstWhere((element) =>
              element.type == "PhoneNumber" && element.useAsBase == true);
          Utils.launchUri(
            contact.value ?? '',
            UriType.phone,
          );
        } catch (e) {
          toastWarning("Không tìm thấy số điện thoại mặc định của người dùng!");
        }

        break;
      case MenuItems.sendSms:
        object as Map<String, dynamic>;
        try {
          List<ContactInfoResponse> contactResponse = object["contactResponse"];
          var contact = contactResponse.firstWhere((element) =>
              element.type == "PhoneNumber" && element.useAsBase == true);
          Utils.launchUri(
            contact.value ?? '',
            UriType.sms,
          );
        } catch (e) {
          toastWarning("Không tìm thấy số điện thoại mặc định của người dùng!");
        }

        break;
      case MenuItems.saveToDevice:
        break;
      case MenuItems.saveToOnlinePhoneBook:
        object as Map<String, dynamic>;
        MemberInfo memberInfo = object["memberInfo"];
        var phoneBookRepository = getIt.get<PhonebookRepository>();
        var response = await phoneBookRepository.addPhoneBook(
            memberId: memberInfo.id ?? '', username: memberInfo.login);
        if (response.status == ResponseStatus.success) {
          toastSuccess('Lưu danh bạ thành công');
        }
        break;
    }
  }
}
