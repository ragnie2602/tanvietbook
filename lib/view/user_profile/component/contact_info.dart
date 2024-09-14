import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/constants.dart';
import '../../../data/resources/resources.dart';
import '../../../model/member/contact_member_info.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/image/primary_image.dart';
import '../../edit_profile/bloc3/edit_profile_bloc.dart';
import 'configuration_contact_info_dialog.dart';
import 'container_block.dart';

import '../../../model/member/base_info_response.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/primary_icon_button.dart';
import '../../edit_profile/component/update_contact_info.dart';
import '../bloc/user_info_bloc.dart';

class ContactInfo extends StatelessWidget {
  final bool isEdit;
  final UserInfoBloc userInfoBloc;
  final BaseInfoResponse baseInfoResponse;
  final EditProfileBloc editProfileBloc;
  final ViewType viewType;

  const ContactInfo({
    Key? key,
    this.isEdit = false,
    required this.userInfoBloc,
    required this.baseInfoResponse,
    required this.editProfileBloc,
    this.viewType = ViewType.viewMember,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      buildWhen: (pre, current) => current is UserInfoGetContactSuccessState,
      builder: (context, state) {
        if (state is UserInfoGetContactSuccessState) {
          return UserContainerBlock(
            title: 'Thông tin liên hệ',
            isExpandable: viewType != ViewType.viewOwn,
            icon: const Icon(Icons.quick_contacts_dialer_rounded,
                color: AppColor.secondaryColor),
            showAction: viewType == ViewType.viewOwn,
            showEditButton: false,
            onAddButtonPressed: () => _onAddNewContactItem(context),
            onSwitchValueChanged: (value) {
              editProfileBloc.add(EditProfileUpdateBaseInfoEvent(
                baseInfo: BaseInfoResponse(
                  id: baseInfoResponse.id,
                  hidden: !value,
                ),
              ));
            },
            onConfigButtonPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => getConfigurationContactInfoDialog(
                      context,
                      contactInfoResponse: state.contactInfoResponse,
                      bloc: userInfoBloc));
            },
            switchInitialValue: !(baseInfoResponse.hidden ?? false),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                  children: state.contactInfoResponse.map((contactItem) {
                List<String>? bankAccountInfo;
                if (contactItem.type == 'BankAccount') {
                  bankAccountInfo = contactItem.value?.split('\$')
                    ?..removeWhere((element) => element.isEmpty);
                }

                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                UriType uriType = UriType.website;
                                switch (contactItem.type) {
                                  case 'email':
                                    uriType = UriType.email;
                                    break;
                                  case 'phone':
                                    uriType = UriType.phone;
                                    break;
                                }
                                Utils.launchUri(
                                    contactItem.value ?? '', uriType);
                              },
                              onLongPress: () {
                                Clipboard.setData(ClipboardData(
                                    text: contactItem.value ?? ''));
                                toastSuccess('Sao chép thành công');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimaryNetworkImage(
                                    imageUrl: contactItem.type == 'BankAccount'
                                        ? Utils.getBankIconUrlByType(
                                            bankAccountInfo![0])
                                        : Utils.getIconUrlByType(
                                            contactItem.type ?? ''),
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          contactItem.type == 'BankAccount'
                                              ? '${bankAccountInfo![0]} - ${bankAccountInfo[1]}'
                                              : "${contactItem.title}",
                                          style: (contactItem.hidden ?? false)
                                              ? AppTextTheme.textLowPriority
                                              : AppTextTheme.textPrimaryBold,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                            contactItem.type == 'BankAccount'
                                                ? bankAccountInfo![2]
                                                : contactItem.value ?? '',
                                            maxLines: 2,
                                            style: (contactItem.hidden ?? false)
                                                ? AppTextTheme.textLowPriority
                                                : AppTextTheme.textPrimary),
                                        const Divider(
                                          thickness: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          viewType == ViewType.viewOwn
                              ? PrimaryIconButton(
                                  context: context,
                                  icon: Assets.icEdit,
                                  iconColor: AppColor.primaryColor,
                                  elevation: 0,
                                  borderColor: null,
                                  backgroundColor: AppColor.white,
                                  onPressed: () =>
                                      _onEditContactItem(context, contactItem),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 1,
                    //   color: AppColor.neutral5,
                    //   margin: const EdgeInsets.only(top: 20),
                    // ),
                  ],
                );
              }).toList()),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  _onEditContactItem(
      BuildContext context, ContactInfoResponse contactItem) async {
    final contactBaseId = userInfoBloc.memberInfo!.baseInfor!
        .firstWhere(
            (element) => element.type.toString() == BaseInfoType.contact)
        .id
        .toString();

    await showDialog(
        context: context,
        builder: (context) => UpdateContactInfo(
              isAddNew: false,
              contactInfoResponse: contactItem,
              contactBaseId: contactBaseId,
            )).then((hasChangeContactInfo) {
      if (hasChangeContactInfo != null && hasChangeContactInfo) {
        userInfoBloc
            .add(UserInfoGetContactInfoEvent(viewType: ViewType.viewOwn));
      }
    });
  }

  _onAddNewContactItem(BuildContext context) async {
    String contactBaseId = '';
    try {
      contactBaseId = userInfoBloc.memberInfo!.baseInfor!
          .firstWhere(
              (element) => element.type.toString() == BaseInfoType.contact)
          .id
          .toString();
      // ignore: empty_catches
    } catch (e) {}

    await showDialog(
            context: context,
            builder: (context) =>
                UpdateContactInfo(isAddNew: true, contactBaseId: contactBaseId))
        .then((hasChangeContactInfo) {
      if (hasChangeContactInfo != null && hasChangeContactInfo) {
        userInfoBloc
            .add(UserInfoGetContactInfoEvent(viewType: ViewType.viewOwn));
      }
    });
  }
}
