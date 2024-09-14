import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../base/base_page_sate.dart';
import '../user_profile/component/container_block.dart';
import 'cubit/affiliate_cubit.dart';

class AffiliateRegisterInfoPage extends StatefulWidget {
  const AffiliateRegisterInfoPage({super.key});

  @override
  State<AffiliateRegisterInfoPage> createState() =>
      _AffiliateRegisterInfoPageState();
}

class _AffiliateRegisterInfoPageState
    extends BasePageState<AffiliateRegisterInfoPage, AffiliateCubit> {
  @override
  bool get useBlocProviderValue => true;

  @override
  PreferredSizeWidget? get appBar => const PrimaryAppBar(
        title: 'Thông tin đăng ký',
      );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = context.arguments as AffiliateRegisterInfoPageArgs;
    setCubit = args.affiliateCubit;
    personalInfoValue = [
      {'value': cubit.collaboratorInfo?.username, 'enable': true},
      {'value': cubit.collaboratorInfo?.fullname, 'enable': true},
      {
        'value': Utils.formatDate(cubit.collaboratorInfo?.dateOfBirth ?? ''),
        'enable': true
      },
      {'value': cubit.collaboratorInfo?.mobile, 'enable': true},
      // {'value': cubit.collaboratorInfo?.email, 'enable': true},
      {'value': cubit.collaboratorInfo?.currentAddress, 'enable': true},
      {'value': cubit.collaboratorInfo?.permanentAddress, 'enable': true},
    ];
    advancedInfoValue = [
      {'value': cubit.collaboratorInfo?.taxCode, 'enable': true},
      {'value': cubit.collaboratorInfo?.citizenIdentityCard, 'enable': true},
      {
        'value': Utils.formatDate(cubit.collaboratorInfo?.dateOfIssue ?? ''),
        'enable': true
      },
      {'value': cubit.collaboratorInfo?.placeOfIssue, 'enable': true},
    ];
    bankInfoValue = [
      {'value': cubit.collaboratorInfo?.bankName, 'enable': true},
      {'value': cubit.collaboratorInfo?.accountName, 'enable': true},
      {'value': cubit.collaboratorInfo?.accountNumber, 'enable': true},
    ];
  }

  final List<String> personalInfoKey = [
    'Tên tài khoản',
    'Họ và tên',
    'Ngày sinh',
    'Số điện thoại',
    // 'Email',
    'Địa chỉ liên hệ',
    'Địa chỉ thường trú'
  ];
  final List<String> advancedInfoKey = [
    'Mã số thuế',
    'Số CCCD/ CMT',
    'Ngày cấp',
    'Nơi cấp',
    // 'Email',
  ];
  final List<String> bankInfoKey = [
    'Ngân hàng',
    'Chủ tài khoản',
    'Số tài khoản',
  ];
  late final List<Map<String, dynamic>> personalInfoValue;
  late final List<Map<String, dynamic>> advancedInfoValue;
  late final List<Map<String, dynamic>> bankInfoValue;

  @override
  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UserContainerBlock(
            title: 'Thông tin cá nhân',
            isExpandable: true,
            icon: SvgPicture.asset(
              'assets/icons/ic_id_card.svg',
              height: 18,
              width: 18,
              color: AppColor.secondaryColor,
            ),
            showConfigItemButton: false,
            showAddButton: false,
            showEditButton: false,
            showSwitchButton: false,
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
                              style: AppTextTheme.textPrimaryBold,
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
                              style: AppTextTheme.bodyMedium,
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          // UserContainerBlock(
          //   title: 'Thông tin nâng cao',
          //   isExpandable: true,
          //   icon: SvgPicture.asset(
          //     'assets/icons/ic_id_card.svg',
          //     height: 18,
          //     width: 18,
          //     color: AppColor.secondaryColor,
          //   ),
          //   showConfigItemButton: false,
          //   showAddButton: false,
          //   showEditButton: false,
          //   showSwitchButton: false,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 8),
          //     child: Table(
          //       columnWidths: const {
          //         0: FlexColumnWidth(1),
          //         1: FlexColumnWidth(2),
          //       },
          //       children: List.from(advancedInfoKey)
          //           .asMap()
          //           .entries
          //           .map((e) => TableRow(children: [
          //                 Padding(
          //                   padding: const EdgeInsets.symmetric(vertical: 8),
          //                   child: Text(
          //                     advancedInfoKey[e.key],
          //                     style: AppTextTheme.textPrimaryBold,
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.symmetric(vertical: 8),
          //                   child: Text(
          //                     (advancedInfoValue[e.key]['value'] == null ||
          //                             advancedInfoValue[e.key]['value']
          //                                     .toString() ==
          //                                 '')
          //                         ? 'Chưa cập nhật'
          //                         : advancedInfoValue[e.key]['value'],
          //                     style: AppTextTheme.bodyMedium,
          //                   ),
          //                 ),
          //               ]))
          //           .toList(),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          UserContainerBlock(
            title: 'Thông tin ngân hàng',
            isExpandable: true,
            icon: SvgPicture.asset(
              'assets/icons/ic_id_card.svg',
              height: 18,
              width: 18,
              color: AppColor.secondaryColor,
            ),
            showConfigItemButton: false,
            showAddButton: false,
            showEditButton: false,
            showSwitchButton: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: List.from(bankInfoKey)
                    .asMap()
                    .entries
                    .map((e) => TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              bankInfoKey[e.key],
                              style: AppTextTheme.textPrimaryBold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              (bankInfoValue[e.key]['value'] == null ||
                                      bankInfoValue[e.key]['value']
                                              .toString() ==
                                          '')
                                  ? 'Chưa cập nhật'
                                  : bankInfoValue[e.key]['value'],
                              style: AppTextTheme.bodyMedium,
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(
            height: 156,
          ),
        ],
      ),
    );
  }
}
