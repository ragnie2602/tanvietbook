import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/resources/resources.dart';
import '../../model/member/member_detail_info.dart';
import '../../view/edit_profile/component/update_general_info.dart';
import '../../view/user_profile/component/configuration_display_dialog.dart';
import '../../view/user_profile/component/member_action_view_other.dart';
import '../../view/user_profile/component/member_action_view_own.dart';
import '../../view/user_profile/component/user_bio.dart';
import '../../view/user_profile/user_profile.dart';
import '../etx/view_extensions.dart';
import '../utils/utils.dart';
import 'bouncing.dart';
import 'container/primary_container.dart';
import 'image/primary_image.dart';
import 'primary_icon_button.dart';
import '../../view/qrcode/my_qrcode.dart';

import '../../data/constants.dart';
import '../../view/edit_profile/bloc3/edit_profile_bloc.dart';
import '../../view/user_profile/bloc/user_info_bloc.dart';
import '../bloc/get_image/get_image_bloc.dart';
import '../utils/view_utils.dart';

class ProfileImage extends StatelessWidget {
  final UserInfoBloc? bloc;
  final ViewType viewType;
  final bool isEdit;
  final String coverImageUrl;
  final String avatarImageUrl;
  final String? username;
  final String? fullName;
  final String? nickName;
  final bool? nickNameHidden;

  final MemberInfo memberInfo;
  final UserInfoBloc userInfoBloc;
  final EditProfileBloc editProfileBloc;
  final GetImageBloc getImageBloc;

  const ProfileImage({
    Key? key,
    this.isEdit = false,
    this.bloc,
    required this.coverImageUrl,
    required this.avatarImageUrl,
    this.fullName,
    this.nickName,
    required this.viewType,
    this.nickNameHidden,
    this.username,
    required this.getImageBloc,
    required this.editProfileBloc,
    required this.memberInfo,
    required this.userInfoBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double coverImageHeight = screenWidth * 9 / 16 * 0.75;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getImageBloc,
        ),
        BlocProvider(
          create: (context) => editProfileBloc,
        ),
      ],
      child: Stack(children: [
        SizedBox(
          height: coverImageHeight,
          child: Stack(
            children: [
              SizedBox(
                height: coverImageHeight,
                width: context.screenWidth,
                child: BlocBuilder<GetImageBloc, GetImageState>(
                  buildWhen: (pre, current) {
                    return (current is GetImagePickImageSuccessState &&
                        current.type == ImageType.cover);
                  },
                  builder: (context, state) {
                    return (state is GetImagePickImageSuccessState)
                        ? Image(
                            image: FileImage(File(state.imagePath)),
                            fit: BoxFit.cover,
                          )
                        : PrimaryNetworkImage(
                            imageUrl: coverImageUrl,
                            placeHolder: Image.asset(
                              Assets.imCoverPlaceholder,
                            ),
                          );
                  },
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: viewType == ViewType.viewOwn
                    ///// camera background image
                    ? MultiBlocListener(
                        listeners: [
                          BlocListener<GetImageBloc, GetImageState>(
                            listener: (context, state) {
                              if (state is GetImagePickImageSuccessState) {
                                getImageBloc.add(GetImageGetImageUrlEvent(
                                    imagePath: state.imagePath,
                                    imageType: state.type));
                              }
                              if (state is GetImageGetImageUrlSuccessState &&
                                  state.type == ImageType.avatar) {
                                editProfileBloc.add(
                                    EditProfileUpdatePersonalInfoEvent(
                                        memberInfo: MemberInfo(
                                            avatar: state.imageUrl)));
                              }
                              if (state is GetImageGetImageUrlSuccessState &&
                                  state.type == ImageType.cover) {
                                editProfileBloc.add(
                                    EditProfileUpdatePersonalInfoEvent(
                                        memberInfo: MemberInfo(
                                            coverImage: state.imageUrl)));
                              }
                              if (state is GetImageGetImageUrlErrorState) {
                                toastWarning(
                                    'Tải ảnh lên không thành công. Vui lòng thử lại sau!');
                              }
                            },
                          ),
                          BlocListener<EditProfileBloc, EditProfileState>(
                            listener: (context, state) {
                              if (state
                                  is EditProfileUpdateUserAvatarUrlSuccessState) {
                                context.read<UserInfoBloc>().add(
                                    UserInfoUpdateUserAvatarUrlSuccessEvent(
                                        avatarUrl: state.avatarUrl));
                              }
                            },
                          )
                        ],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: PrimaryIconButton(
                            context: context,
                            isCircle: true,
                            isMiniumSize: false,
                            icon: Assets.icCamera,
                            iconColor: Colors.white,
                            backgroundColor: AppColor.primaryColor,
                            // borderColor: AppColor.primaryColor,
                            onPressed: () {
                              getImageBloc.add(GetImagePickerEvent(
                                  shouldCrop: true, type: ImageType.cover));
                            },
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: coverImageHeight - 99),
          child: Stack(
            children: [
              PrimaryContainer(
                margin: const EdgeInsets.only(top: 66, left: 16, right: 16),
                elevation: 10,
                width: double.infinity,
                borderRadius: BorderRadius.circular(10),
                child: isEdit
                    ? const SizedBox()
                    : PrimaryContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 148),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fullName ?? '',
                                    style: AppTextTheme.textPrimaryBoldLarge
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            overflow: TextOverflow.ellipsis),
                                    maxLines: 3,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    nickName != null && nickName!.isNotEmpty
                                        ? '($nickName)'
                                        : '',
                                    style: (nickNameHidden ?? false)
                                        ? AppTextTheme.textLowPriority.copyWith(
                                            overflow: TextOverflow.ellipsis)
                                        : AppTextTheme.bodyRegular.copyWith(
                                            overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                UserBio(
                                  bio: memberInfo.favoriteQuote,
                                  bioHidden:
                                      memberInfo.favoriteQuoteHidden ?? false,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                viewType == ViewType.viewOwn
                                    ? MemberActionViewOwn(
                                        memberInfo: memberInfo,
                                        onViewAsGuestPressed: () async {
                                          await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => UserProfile(
                                                viewType: ViewType.viewMember,
                                                memberUserName:
                                                    memberInfo.login,
                                                isViewAsGuest: true,
                                              ),
                                            ),
                                          );
                                        },
                                        onShareButtonPressed: () {},
                                        onEditButtonPressed: () async {
                                          await Navigator.of(context)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (_) => EditGeneralInfo(
                                                memberDetailInfo: memberInfo,
                                              ),
                                            ),
                                          )
                                              .then(
                                            (hasChangedInfo) {
                                              if (hasChangedInfo) {
                                                userInfoBloc.add(
                                                    UserInfoGetPersonalInfoEvent(
                                                        viewType:
                                                            ViewType.viewOwn));
                                                editProfileBloc
                                                        .hasChangedPersonalInfo =
                                                    false;
                                              }
                                            },
                                          );
                                        },
                                        onSettingsButtonPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                getConfigurationDisplayDialog(
                                                    context,
                                                    bloc: userInfoBloc),
                                          );
                                        },
                                      )
                                    : MemberActionViewOther(
                                        memberInfo: memberInfo,
                                        contactResponse:
                                            userInfoBloc.contactResponse?.data,
                                        onSaveContact: () =>
                                            onSaveContact(memberInfo),
                                        onRegister: () {},
                                      ),
                              ],
                            )
                          ],
                        ),
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.white, width: 4),
                  borderRadius: BorderRadius.circular(70),
                ),
                height: 140,
                width: 140,
                margin: const EdgeInsets.only(left: 32),
                child: BlocConsumer<GetImageBloc, GetImageState>(
                  listener: (context, state) {},
                  buildWhen: (pre, current) {
                    return (current is GetImagePickImageSuccessState &&
                        current.type == ImageType.avatar);
                  },
                  builder: (context, state) {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: AppColor.white,
                          backgroundImage: (state
                                  is GetImagePickImageSuccessState)
                              ? FileImage(File(state.imagePath))
                              : NetworkImage(avatarImageUrl) as ImageProvider,
                          child: viewType == ViewType.viewOwn
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Material(
                                    color: AppColor.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        getImageBloc.add(GetImagePickerEvent(
                                            shouldCrop: true,
                                            type: ImageType.avatar));
                                      },
                                      radius: 30,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(70),
                                        bottomRight: Radius.circular(70),
                                      ),
                                      highlightColor: AppColor.primaryColor,
                                      child: Ink(
                                        height: 70,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color:
                                              AppColor.black.withOpacity(0.5),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(70),
                                            bottomRight: Radius.circular(70),
                                          ),
                                        ),
                                        child: Container(
                                          // height: 34,
                                          // width: 34,
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                            Assets.icCamera,
                                            // fit: BoxFit.scaleDown,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                        viewType == ViewType.viewOwn
                            ? const SizedBox()
                            : Align(
                                alignment: Alignment.bottomRight,
                                child: Bouncing(
                                  onPressed: () {},
                                  child: GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (_) => MyQrCode(
                                          username: username ?? '',
                                          fullName: fullName ?? '',
                                          avatarUrl: avatarImageUrl,
                                        ),
                                      );
                                    },
                                    child: const CircleAvatar(
                                      radius: 18,
                                      backgroundColor: AppColor.primaryColor,
                                      child: Icon(
                                        Icons.qr_code,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  onSaveContact(MemberInfo memberInfo) async {
    if (await FlutterContacts.requestPermission()) {
      Uint8List? bytes;
      try {
        bytes = (await NetworkAssetBundle(Uri.parse(memberInfo.avatar ?? ''))
                .load(memberInfo.avatar ?? ''))
            .buffer
            .asUint8List();
        // ignore: empty_catches
      } catch (e) {}
      final newContact = Contact(
        photo: bytes,
        displayName: memberInfo.fullName ?? '',
        name: Name(
            nickname: memberInfo.nickName ?? '',
            first: memberInfo.fullName ?? ''),
        websites: [
          Website('https://trueconnect.vn/profile/${memberInfo.login}')
        ],
        // phones: [Phone('0902021489')],
        phones: [
          if (userInfoBloc.contactResponse?.data
                  ?.firstWhere((element) => element.type == 'PhoneNumber')
                  .hidden ==
              false)
            Phone(userInfoBloc.contactResponse?.data
                    ?.firstWhere((element) => element.type == 'PhoneNumber')
                    .value ??
                '')
        ],
        addresses: [
          Address(
            Utils.formatAddress(
              memberInfo.address,
              memberInfo.commune,
              memberInfo.district,
              memberInfo.city,
            ),
          )
        ],
      );
      await newContact.insert();
      toastSuccess('Lưu thành công.');
    } else {
      toastWarning('Vui lòng cấp quyền lưu vào danh bạ.');
    }
  }
}
