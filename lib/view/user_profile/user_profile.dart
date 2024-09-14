import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/repository/local/local_data_access.dart';
import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';
import '../../di/di.dart';
import '../../model/member/member_detail_info.dart';
import '../../shared/bloc/get_image/get_image_bloc.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/app_richtext.dart';
import '../../shared/widgets/back_button.dart';
import '../../shared/widgets/dialog_helper.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/profile_image.dart';
import '../edit_profile/bloc3/edit_profile_bloc.dart';
import '../edit_profile/component/update_personal_info.dart';
import 'bloc/user_info_bloc.dart';
import 'component/additional_path_info.dart';
import 'component/contact_info.dart';
import 'component/highlight_info.dart';
import 'component/organization_info.dart';
import 'component/personal_info.dart';
import 'component/user_profile_shimmer.dart';

// ignore: must_be_immutable
class UserProfile extends StatefulWidget {
  final ViewType viewType;
  final String? memberUserName;
  final String? memberFullName;
  final String appLinkUsernameReceived;
  final bool isViewAsGuest;

  const UserProfile({
    Key? key,
    this.viewType = ViewType.viewOwn,
    this.memberUserName,
    this.appLinkUsernameReceived = '',
    this.isViewAsGuest = false,
    this.memberFullName,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final EditProfileBloc _editProfileBloc = EditProfileBloc();

  final GetImageBloc _getImageBloc = GetImageBloc();

  late UserInfoBloc _userInfoBloc;

  @override
  void initState() {
    super.initState();
    if (widget.viewType == ViewType.viewOwn &&
        widget.appLinkUsernameReceived.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => UserProfile(
              viewType: ViewType.viewMember,
              memberUserName: widget.appLinkUsernameReceived,
            ),
          ),
        );
      });
    }
    if (widget.viewType == ViewType.viewOwn) {
      // read the instance of parent provider to push this via navigator.push() or use in somewhere in widget tree
      _userInfoBloc = context.read<UserInfoBloc>();
    } else {
      // or init new instance to use when view other user
      _userInfoBloc = UserInfoBloc();
    }

    _userInfoBloc.add(UserInfoGetPersonalInfoEvent(
        viewType: widget.viewType, memberUserName: widget.memberUserName));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _userInfoBloc,
      child: Scaffold(
        backgroundColor: const Color(0xffE7EBED),
        appBar: widget.viewType != ViewType.viewOwn
            ? AppBar(
                backgroundColor: widget.isViewAsGuest
                    ? const Color(0xFFE6F7FF)
                    : AppColor.primaryBackgroundColor,
                automaticallyImplyLeading: false,
                elevation: 1,
                centerTitle: false,
                leading: const BackButtonCustom(),
                title: widget.isViewAsGuest
                    ? const Row(
                        children: [
                          Text(
                            'Đang xem ở chế độ khách',
                            style: AppTextTheme.bodyRegular,
                          ),
                          Spacer(),
                          Icon(
                            Icons.info,
                            color: AppColor.blue,
                          ),
                        ],
                      )
                    : Text(
                        widget.memberFullName ?? '',
                        style: AppTextTheme.titleMedium,
                      ),
              )
            : (widget.appLinkUsernameReceived.isNotEmpty &&
                    getIt.get<LocalDataAccess>().getAccessToken().isEmpty)
                ? AppBar(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SvgPicture.asset(
                        'assets/icons/ic_logo.svg',
                        fit: BoxFit.contain,
                        height: 28,
                        width: 28,
                      ),
                    ),
                    title: const AppRichText(),
                    titleSpacing: 10,
                    elevation: 1,
                    backgroundColor: AppColor.white,
                    centerTitle: false,
                    actions: [
                      Center(
                        child: Wrap(
                          children: [
                            PrimaryButton(
                                context: context,
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoute.login);
                                },
                                label: 'Đăng nhập'),
                            const SizedBox(width: 16)
                          ],
                        ),
                      )
                    ],
                  )
                : null,
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<UserInfoBloc, UserInfoState>(
              listenWhen: (pre, current) {
                return current is UserInfoSuccessState ||
                    current is UserInfoLoadingState ||
                    (current is UserInfoGetAdditionalPathSuccessState &&
                        pre is UserInfoLoadingState) ||
                    (current is UserInfoGetContactSuccessState &&
                        pre is UserInfoLoadingState);
              },
              listener: (context, state) {
                log('message $state');
                if (state is UserInfoSuccessState) {
                  if (state.isUpdateAll == true) {
                    _userInfoBloc
                      ..add(UserInfoGetContactInfoEvent(
                          viewType: widget.viewType))
                      ..add(UserInfoGetOrganizationInfoEvent(
                          viewType: widget.viewType))
                      ..add(UserInfoGetAdditionalPathInfoEvent(
                          viewType: widget.viewType));

                    if (state.isPopLoadingDialog == true) {
                      Navigator.pop(context);
                    }
                  } else {
                    Navigator.pop(context);
                  }
                } else if (state is UserInfoLoadingState) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => getLoadingDialog());
                } else if (state is UserInfoGetContactSuccessState ||
                    state is UserInfoGetAdditionalPathSuccessState) {
                  Navigator.pop(context);
                }
              },
              buildWhen: (pre, current) {
                return current is UserInfoSuccessState;
              },
              builder: (context, state) {
                log('builder: $state');
                if (state is UserInfoSuccessState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileImage(
                        bloc: _userInfoBloc,
                        viewType: widget.viewType,
                        username: state.memberInfo.login,
                        editProfileBloc: _editProfileBloc,
                        getImageBloc: _getImageBloc,
                        avatarImageUrl: state.memberInfo.avatar ?? '',
                        coverImageUrl: state.memberInfo.coverImage ?? '',
                        fullName: state.memberInfo.fullName,
                        nickName: state.memberInfo.nickName,
                        nickNameHidden: state.memberInfo.nickNameHidden,
                        memberInfo: state.memberInfo,
                        userInfoBloc: _userInfoBloc,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: bindingBaseInfoToView(
                              memberInfo: state.memberInfo, context: context),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const UserProfileShimmer();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> bindingBaseInfoToView(
      {required MemberInfo memberInfo, required BuildContext context}) {
    final List<Widget> widgets = [];

    memberInfo.baseInfor?.map((baseInfoItem) {
      switch (baseInfoItem.type) {
        case BaseInfoType.personalInformation:
          widgets.add(
            PersonalInfo(
              baseInfoResponse: baseInfoItem,
              viewType: widget.viewType,
              dob: memberInfo.dob,
              dobHidden: memberInfo.dobHidden ?? false,
              gender: memberInfo.gender,
              genderHidden: memberInfo.genderHidden ?? false,
              address: Utils.formatAddress(
                memberInfo.address,
                memberInfo.commune,
                memberInfo.district,
                memberInfo.city,
              ),
              addressHidden: memberInfo.addressHidden ?? false,
              positionHidden: false,
              companyHidden: false,
              onEditPressed: () async {
                await Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (_) => EditPersonalInfo(
                      memberDetailInfo: memberInfo,
                    ),
                  ),
                )
                    .then(
                  (hasChangedInfo) {
                    if (hasChangedInfo) {
                      _userInfoBloc.add(UserInfoGetPersonalInfoEvent(
                          viewType: ViewType.viewOwn));
                      _editProfileBloc.hasChangedPersonalInfo = false;
                    }
                  },
                );
              },
              editProfileBloc: _editProfileBloc,
            ),
          );
          break;
        case BaseInfoType.highLight:
          widgets.add(
            HighLightInfo(
              baseInfoResponse: baseInfoItem,
              editProfileBloc: _editProfileBloc,
              viewType: widget.viewType,
            ),
          );
          break;

        case BaseInfoType.additionalPath:
          widgets.add(AdditionalLink(
            userInfoBloc: _userInfoBloc,
            baseInfoResponse: baseInfoItem,
            editProfileBloc: _editProfileBloc,
            viewType: widget.viewType,
          ));
          break;

        case BaseInfoType.organization:
          widgets.add(OrganizationInfo(
            viewType: widget.viewType,
            baseInfoResponse: baseInfoItem,
            editProfileBloc: _editProfileBloc,
            userInfoBloc: _userInfoBloc,
          ));
          break;

        case BaseInfoType.contact:
          widgets.add(ContactInfo(
            viewType: widget.viewType,
            baseInfoResponse: baseInfoItem,
            editProfileBloc: _editProfileBloc,
            userInfoBloc: _userInfoBloc,
          ));
          break;
      }
    }).toList();

    return widgets;
  }
}
