import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/resources/resources.dart';
import '../../../model/member/organization_info_response.dart';
import '../../../shared/etx/dart_extensions.dart';
import '../../../shared/widgets/container_shimmer.dart';
import '../../../shared/widgets/primary_shimmer.dart';
import 'container_block.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/constants.dart';
import '../../../model/member/base_info_response.dart';
import '../../edit_profile/bloc3/edit_profile_bloc.dart';
import '../../edit_profile/component/update_organization_info.dart';
import '../bloc/user_info_bloc.dart';

class OrganizationInfo extends StatelessWidget {
  final UserInfoBloc userInfoBloc;
  final BaseInfoResponse baseInfoResponse;
  final EditProfileBloc editProfileBloc;
  final ViewType viewType;

  const OrganizationInfo({
    Key? key,
    required this.userInfoBloc,
    required this.baseInfoResponse,
    required this.editProfileBloc,
    this.viewType = ViewType.viewOwn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> organizationInfoIconValue = List.of([
      'ic_organization.svg',
      'ic_organization.svg',
      'ic_organization.svg',
      'ic_major.svg',
      'ic_tax_code.svg',
      'ic_address.svg',
      'ic_hotline.svg',
      'ic_website.svg',
      'ic_fanpage.svg',
    ]).toList();

    return BlocBuilder<UserInfoBloc, UserInfoState>(
      buildWhen: (previous, current) =>
          current is UserInfoGetOrganizationSuccessState,
      builder: (context, state) {
        if (state is UserInfoGetOrganizationSuccessState &&
                state.organizationInfoResponse != null &&
                viewType != ViewType.viewOwn ||
            viewType == ViewType.viewOwn) {
          final List<String?> organizationInfoKey = [];
          final List<String?> organizationInfoValue = [];
          final List<bool?> organizationHiddenInfoValue = [];
          if (state is UserInfoGetOrganizationSuccessState &&
              state.organizationInfoResponse != null) {
            state.organizationInfoResponse as OrganizationInfoResponse;
            organizationInfoKey.addAll(List.of([
              'Chức vụ',
              'Phòng ban',
              'Tổ chức',
              'Lĩnh vực',
              'Mã số thuế',
              'Địa chỉ',
              state.organizationInfoResponse!.hotline.isNullOrEmpty
                  ? 'Số điện thoại'
                  : state.organizationInfoResponse?.hotline,
              state.organizationInfoResponse!.fanpage.isNullOrEmpty
                  ? 'Fanpage'
                  : state.organizationInfoResponse?.fanpage,
            ]).toList());

            organizationInfoValue.addAll(List.of([
              state.organizationInfoResponse?.position,
              state.organizationInfoResponse?.department,
              state.organizationInfoResponse?.organization,
              state.organizationInfoResponse?.major,
              state.organizationInfoResponse?.taxCode,
              state.organizationInfoResponse?.address,
              state.organizationInfoResponse?.hotlineInfor,
              state.organizationInfoResponse?.websiteInfor,
              state.organizationInfoResponse?.fanpageInfor,
            ]).toList());

            organizationHiddenInfoValue.addAll(List.of([
              state.organizationInfoResponse?.positionHidden,
              state.organizationInfoResponse?.departmentHidden,
              state.organizationInfoResponse?.organizationHidden,
              state.organizationInfoResponse?.majorHidden,
              state.organizationInfoResponse?.taxCodeHidden,
              state.organizationInfoResponse?.addressHidden,
              state.organizationInfoResponse?.hotlineHidden,
              state.organizationInfoResponse?.websiteHidden,
              state.organizationInfoResponse?.fanpageHidden,
            ]).toList());
          }

          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              UserContainerBlock(
                  title: 'Thông tin tổ chức',
                  isExpandable: viewType != ViewType.viewOwn,
                  icon: const Icon(
                    Icons.contact_mail,
                    size: 18,
                    color: AppColor.secondaryColor,
                  ),
                  showAction: viewType == ViewType.viewOwn,
                  showAddButton: false,
                  showConfigItemButton: false,
                  onEditButtonPressed: () async {
                    await Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (_) => EditOrganizationInfo(
                          organizationInfo:
                              (state as UserInfoGetOrganizationSuccessState)
                                      .organizationInfoResponse ??
                                  OrganizationInfoResponse(
                                      organizationBaseId:
                                          userInfoBloc.getBaseInfoIdByType(
                                              BaseInfoType.organization)),
                        ),
                      ),
                    )
                        .then(
                      (hasChangedOrganizationInfo) {
                        if (hasChangedOrganizationInfo) {
                          userInfoBloc.add(UserInfoGetOrganizationInfoEvent(
                              viewType: viewType));
                        }
                      },
                    );
                  },
                  onSwitchValueChanged: (value) {
                    editProfileBloc.add(EditProfileUpdateBaseInfoEvent(
                      baseInfo: BaseInfoResponse(
                        id: baseInfoResponse.id,
                        hidden: !value,
                      ),
                    ));
                    // showDialog(
                    //     context: context,
                    //     builder: (context) =>
                    //         getLoadingDialog());
                  },
                  switchInitialValue: !(baseInfoResponse.hidden ?? false),
                  child: Builder(builder: (context) {
                    if (state is UserInfoGetOrganizationSuccessState &&
                        state.organizationInfoResponse != null) {
                      return Column(
                        children: List.from(organizationInfoKey)
                            .map((e) => viewType != ViewType.viewOwn &&
                                    (organizationHiddenInfoValue[
                                            organizationInfoKey.indexOf(e)]! ||
                                        organizationInfoValue[
                                                organizationInfoKey
                                                    .indexOf(e)] ==
                                            null ||
                                        (organizationInfoValue[
                                                organizationInfoKey
                                                    .indexOf(e)] is String &&
                                            organizationInfoValue[
                                                    organizationInfoKey
                                                        .indexOf(e)]!
                                                .isEmpty))
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    child: InkWell(
                                      onTap: () async {
                                        if (await canLaunchUrl(Uri.parse(
                                            organizationInfoValue[
                                                    organizationInfoKey
                                                        .indexOf(e)] ??
                                                ''))) {
                                          await launchUrl(
                                              Uri.parse(organizationInfoValue[
                                                      organizationInfoKey
                                                          .indexOf(e)] ??
                                                  ''),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        }
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/${organizationInfoIconValue[organizationInfoKey.indexOf(e)]}'),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Text(
                                              e,
                                              style: organizationHiddenInfoValue[
                                                              organizationInfoKey
                                                                  .indexOf(
                                                                      e)] !=
                                                          null &&
                                                      organizationHiddenInfoValue[
                                                          organizationInfoKey
                                                              .indexOf(e)]!
                                                  ? AppTextTheme.textLowPriority
                                                  : AppTextTheme
                                                      .textPrimaryBold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              organizationInfoValue[
                                                          organizationInfoKey
                                                              .indexOf(e)]
                                                      .isNullOrEmpty
                                                  ? 'Chưa cập nhật'
                                                  : organizationInfoValue[
                                                      organizationInfoKey
                                                          .indexOf(e)]!,
                                              maxLines: 2,
                                              style: organizationHiddenInfoValue[
                                                              organizationInfoKey
                                                                  .indexOf(
                                                                      e)] !=
                                                          null &&
                                                      organizationHiddenInfoValue[
                                                          organizationInfoKey
                                                              .indexOf(e)]!
                                                  ? AppTextTheme.textLowPriority
                                                  : AppTextTheme.bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                            .toList(),
                      );
                    } else if (state is UserInfoGetOrganizationSuccessState &&
                        state.organizationInfoResponse == null) {
                      return const Text(
                        'Chưa cập nhật thông tin tổ chức',
                        style: AppTextTheme.textLowPriority,
                      );
                    } else if (state is UserInfoGetOrganizationFailedState) {
                      return const SizedBox();
                    } else {
                      // initial loading
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryShimmer(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ContainerShimmer(width: 150, height: 15),
                              SizedBox(height: 10),
                              ContainerShimmer(width: 250, height: 15),
                              SizedBox(height: 10),
                              ContainerShimmer(width: 300, height: 15),
                              SizedBox(
                                height: 10,
                              ),
                              ContainerShimmer(width: 300, height: 15),
                            ],
                          )),
                        ],
                      );
                    }
                  })),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
