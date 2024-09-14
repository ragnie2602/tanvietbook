import 'package:flutter/material.dart';
import '../../../../data/resources/themes.dart';
import '../../../../shared/widgets/secondary_text_field.dart';
import '../../bloc/business_update_bloc.dart';

import '../../../../model/business/detail/business_detail_response.dart';

// ignore: must_be_immutable
class BusinessUpdateContactInfo extends StatelessWidget {
  final BusinessUpdateBloc businessUpdateBloc;

  final Function(Function() updateBusinessDetail) businessUpdateCallBack;
  final BusinessDetailResponse businessDetailResponse;

  BusinessUpdateContactInfo({
    Key? key,
    required this.businessUpdateCallBack,
    required this.businessDetailResponse,
    required this.businessUpdateBloc,
  }) : super(key: key);

  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _zaloController = TextEditingController();
  final _messengerController = TextEditingController();

  late List<bool> enableItem;

  void updateBusinessDetail() {
    businessUpdateBloc.businessDetailResponse =
        businessUpdateBloc.businessDetailResponse.copyWith(
      phoneNumber: _phoneController.text,
      phoneNumberEnable: enableItem[0],
      email: _emailController.text,
      emailEnable: enableItem[1],
      zalo: _zaloController.text,
      zaloEnable: enableItem[2],
      messenger: _messengerController.text,
      messengerEnable: enableItem[3],
    );
  }

  @override
  Widget build(BuildContext context) {
    businessUpdateCallBack.call(updateBusinessDetail);

    final List<TextEditingController> controllers = [
      _phoneController..text = businessDetailResponse.phoneNumber ?? '',
      _emailController..text = businessDetailResponse.email ?? '',
      _zaloController..text = businessDetailResponse.zalo ?? '',
      _messengerController..text = businessDetailResponse.messenger ?? ''
    ];

    enableItem = [
      businessDetailResponse.phoneNumberEnable ?? true,
      businessDetailResponse.emailEnable ?? true,
      businessDetailResponse.zaloEnable ?? true,
      businessDetailResponse.messengerEnable ?? true
    ];

    final List<String> icons = [
      'assets/icons/ic_phone.svg',
      'assets/icons/ic_mail.svg',
      'assets/icons/ic_zalo.svg',
      'assets/icons/ic_messenger.svg',
    ];

    final List<String> labelItems = [
      'Số điện thoại',
      'Email',
      'Số điện thoại Zalo',
      'Đường dẫn Messenger',
    ];

    final List<String> hintTexts = [
      'Nhập số điện thoại',
      'Nhập email',
      'Nhập số điện thoại Zalo',
      'Nhập link Messenger',
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Thông tin liên hệ',
        style: AppTextTheme.textPrimaryBoldMedium,
      ),
      for (int i = 0; i < 4; i++)
        Column(
          children: [
            const SizedBox(height: 20),
            SecondaryTextField(
              labelIcon: icons[i],
              controller: controllers[i],
              hintText: hintTexts[i],
              textInputAction: TextInputAction.next,
              label: labelItems[i],
              isShowSwitch: true,
              onSwitchChanged: (value) {
                enableItem[i] = value;
              },
              isSwitchChecked: enableItem[i],
            ),
          ],
        ),
    ]);
  }
}
