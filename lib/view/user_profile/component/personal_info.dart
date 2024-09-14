import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/constants.dart';
import '../../../model/member/base_info_response.dart';
import '../../edit_profile/bloc3/edit_profile_bloc.dart';
import 'container_block.dart';

import '../../../data/resources/resources.dart';
import '../../../shared/utils/utils.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({
    super.key,
    this.dob,
    this.gender,
    this.address,
    this.position,
    this.company,
    this.onEditPressed,
    this.viewType = ViewType.viewMember,
    required this.dobHidden,
    required this.genderHidden,
    required this.addressHidden,
    required this.positionHidden,
    required this.companyHidden,
    required this.baseInfoResponse,
    required this.editProfileBloc,
  });

  final String? dob;
  final bool dobHidden;
  final String? gender;
  final bool genderHidden;
  final String? address;
  final bool addressHidden;
  final String? position;
  final bool positionHidden;
  final String? company;
  final bool companyHidden;
  final ViewType? viewType;
  final Function()? onEditPressed;
  final BaseInfoResponse baseInfoResponse;
  final EditProfileBloc editProfileBloc;

  @override
  Widget build(BuildContext context) {
    final List<String> personalInfoKey = [
      'Ngày sinh',
      'Giới tính',
      'Địa chỉ',
      // 'Vị trí',
      // 'Công ty'
    ];
    final List<Map<String, dynamic>> personalInfoValue = [
      {'value': Utils.formatDate(dob ?? ''), 'enable': !dobHidden},
      {'value': gender, 'enable': !genderHidden},
      {'value': address, 'enable': !addressHidden},
      // {'value': position, 'enable': !positionHidden},
      // {'value': company, 'enable': !companyHidden},
    ];
    return Column(
      children: [
        UserContainerBlock(
          title: baseInfoResponse.title ?? 'Thông tin cá nhân',
          isExpandable: viewType != ViewType.viewOwn,
          icon: SvgPicture.asset(
            'assets/icons/ic_id_card.svg',
            height: 18,
            width: 18,
            color: AppColor.secondaryColor,
          ),
          showAction: viewType == ViewType.viewOwn,
          showConfigItemButton: false,
          showAddButton: false,
          onEditButtonPressed: () => onEditPressed?.call(),
          onSwitchValueChanged: (value) {
            editProfileBloc.add(EditProfileUpdateBaseInfoEvent(
              baseInfo: BaseInfoResponse(
                id: baseInfoResponse.id,
                hidden: !value,
              ),
            ));
          },
          switchInitialValue: !(baseInfoResponse.hidden ?? false),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: List.from(personalInfoKey)
                  .asMap()
                  .entries
                  .map((e) => TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            personalInfoKey[e.key],
                            style: personalInfoValue[e.key]['enable']
                                ? AppTextTheme.textPrimaryBold
                                : AppTextTheme.textLowPriority,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            (personalInfoValue[e.key]['value'] == null ||
                                    personalInfoValue[e.key]['value']
                                            .toString() ==
                                        '')
                                ? 'Chưa cập nhật'
                                : personalInfoValue[e.key]['value'],
                            style: personalInfoValue[e.key]['enable']
                                ? AppTextTheme.bodyMedium
                                : AppTextTheme.textLowPriority,
                          ),
                        ),
                      ]))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
