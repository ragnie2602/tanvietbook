import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../data/constants.dart';
import '../../../data/resources/resources.dart';
import '../../../model/member/additional_path_response.dart';
import '../../../shared/etx/view_extensions.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/image/primary_image.dart';
import '../../../shared/widgets/primary_icon_button.dart';
import '../../edit_profile/component/update_additional_path_info.dart';
import '../bloc/user_info_bloc.dart';
import 'configuration_additional_path_dialog.dart';
import 'container_block.dart';

import '../../../model/member/base_info_response.dart';
import '../../../shared/widgets/container_shimmer.dart';
import '../../../shared/widgets/primary_shimmer.dart';
import '../../edit_profile/bloc3/edit_profile_bloc.dart';

class AdditionalLink extends StatelessWidget {
  final UserInfoBloc userInfoBloc;
  final ViewType viewType;
  final BaseInfoResponse baseInfoResponse;
  final EditProfileBloc editProfileBloc;

  const AdditionalLink({
    Key? key,
    required this.viewType,
    required this.userInfoBloc,
    required this.baseInfoResponse,
    required this.editProfileBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      buildWhen: (pre, current) =>
          current is UserInfoGetAdditionalPathSuccessState,
      builder: (context, state) {
        return state is UserInfoGetAdditionalPathSuccessState
            ? UserContainerBlock(
                title: 'Liên kết bổ sung',
                isExpandable: viewType != ViewType.viewOwn,
                icon: const Icon(
                  Icons.attachment,
                  color: AppColor.secondaryColor,
                ),
                showAction: viewType == ViewType.viewOwn,
                showEditButton: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                onAddButtonPressed: () => _onAddNewAdditionalLinkItem(context),
                onSwitchValueChanged: (value) {
                  editProfileBloc.add(EditProfileUpdateBaseInfoEvent(
                    baseInfo: BaseInfoResponse(
                      id: baseInfoResponse.id,
                      hidden: !value,
                    ),
                  ));
                },
                switchInitialValue: !(baseInfoResponse.hidden ?? false),
                onConfigButtonPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => getConfigurationAdditionalPathDialog(
                        context,
                        additionalPathInfoResponse:
                            state.additionalPathInfoResponse,
                        bloc: userInfoBloc),
                  );
                },
                child: ListView.separated(
                  itemCount: state.additionalPathInfoResponse.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final additionalPathItem =
                        state.additionalPathInfoResponse[index];
                    String? ytbId = Utils.convertUrlToYoutubeVideoId(
                        additionalPathItem.value ?? '');
                    String? thumbnailUrl;
                    if (ytbId != null) {
                      thumbnailUrl = Utils.getThumbnail(videoId: ytbId);
                    }
                    return InkWell(
                      onTap: () async {
                        await Utils.launchUri(
                            additionalPathItem.value ?? '', UriType.website);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: additionalPathItem.image != null &&
                                              additionalPathItem
                                                  .image!.isNotEmpty ||
                                          additionalPathItem.icon != null &&
                                              additionalPathItem
                                                  .icon!.isNotEmpty
                                      ? additionalPathItem.image!.isEmpty
                                          ? PrimaryNetworkImage(
                                              imageUrl: additionalPathItem.icon,
                                              width: 40,
                                              height: 40,
                                            )
                                          : PrimaryNetworkImage(
                                              imageUrl:
                                                  additionalPathItem.image,
                                              width: 40,
                                              height: 40,
                                            )
                                      // Image.network(
                                      //     additionalPathItem.image,

                                      //     fit: BoxFit.cover,
                                      //     opacity: (additionalPathItem
                                      //                     .hidden !=
                                      //                 null &&
                                      //             additionalPathItem.hidden)
                                      //         ? const AlwaysStoppedAnimation(
                                      //             .5)
                                      //         : const AlwaysStoppedAnimation(
                                      //             1.0),
                                      //   )
                                      : SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: SvgPicture.asset(
                                              fit: BoxFit.scaleDown,
                                              'assets/icons/ic_website.svg'),
                                        ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        additionalPathItem.title ?? '',
                                        style: additionalPathItem.hidden !=
                                                    null &&
                                                additionalPathItem.hidden!
                                            ? AppTextTheme.textPrimary.copyWith(
                                                color: AppColor.neutral5,
                                                overflow: TextOverflow.ellipsis)
                                            : AppTextTheme.bodyRegular.copyWith(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        additionalPathItem.value ?? '',
                                        style: additionalPathItem.hidden !=
                                                    null &&
                                                additionalPathItem.hidden!
                                            ? AppTextTheme.textPrimarySmall
                                                .copyWith(
                                                    color: AppColor.neutral5,
                                                    overflow:
                                                        TextOverflow.ellipsis)
                                            : AppTextTheme.textPrimarySmall
                                                .copyWith(
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                ),
                                // const SizedBox(
                                //   width: 60,
                                // ),
                                viewType == ViewType.viewOwn
                                    ? PrimaryIconButton(
                                        context: context,
                                        onPressed: () =>
                                            _onUpdateAdditionalLinkItem(
                                                context, additionalPathItem),
                                        icon: Assets.icEdit,
                                        borderColor: null,
                                        backgroundColor: AppColor.white,
                                        elevation: 0,
                                        iconColor: AppColor.primaryColor,
                                      )
                                    : SvgPicture.asset(Assets.icExternalLink),
                              ],
                            ),
                            if (thumbnailUrl != null)
                              const SizedBox(height: 10),
                            if (thumbnailUrl != null)
                              Stack(
                                children: [
                                  PrimaryNetworkImage(
                                      width: double.infinity,
                                      height:
                                          (context.screenWidth - 48) * 9 / 16,
                                      imageUrl: thumbnailUrl),
                                  const Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Icon(
                                      FontAwesomeIcons.youtube,
                                      color: Color(0xFFFF0000),
                                      size: 40,
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      color: AppColor.primaryColor,
                    );
                  },
                ),
              )
            : const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Liên kết bổ sung',
                    style: AppTextTheme.textPrimaryBoldMedium,
                  ),
                  PrimaryShimmer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      ContainerShimmer(width: double.infinity, height: 30),
                      SizedBox(height: 10),
                      ContainerShimmer(width: double.infinity, height: 30),
                    ],
                  )),
                ],
              );
      },
    );
  }

  _onAddNewAdditionalLinkItem(BuildContext context) async {
    String additionalPathBaseId = '';
    try {
      additionalPathBaseId = userInfoBloc.memberInfo!.baseInfor!
          .firstWhere((element) =>
              element.type.toString() == BaseInfoType.additionalPath)
          .id
          .toString();
      // ignore: empty_catches
    } catch (e) {}

    await showDialog(
            context: context,
            builder: (context) => UpdateAdditionalPathInfo(
                isAddNew: true, additionalPathBaseId: additionalPathBaseId))
        .then((hasChangedAdditionalPathInfo) {
      if (hasChangedAdditionalPathInfo != null &&
          hasChangedAdditionalPathInfo) {
        userInfoBloc.add(
            UserInfoGetAdditionalPathInfoEvent(viewType: ViewType.viewOwn));
      }
    });
  }

  _onUpdateAdditionalLinkItem(BuildContext context,
      AdditionalPathInfoResponse additionalPathItem) async {
    String additionalPathBaseId = '';
    try {
      additionalPathBaseId = userInfoBloc.memberInfo!.baseInfor!
          .firstWhere((element) =>
              element.type.toString() == BaseInfoType.additionalPath)
          .id
          .toString();
      // ignore: empty_catches
    } catch (e) {}

    await showDialog(
        context: context,
        builder: (context) => UpdateAdditionalPathInfo(
              additionalPathBaseId: additionalPathBaseId,
              additionalPathInfoResponse: additionalPathItem,
            )).then((hasChangedAdditionalPathInfo) {
      if (hasChangedAdditionalPathInfo != null &&
          hasChangedAdditionalPathInfo) {
        userInfoBloc.add(
            UserInfoGetAdditionalPathInfoEvent(viewType: ViewType.viewOwn));
      }
    });
  }
}
