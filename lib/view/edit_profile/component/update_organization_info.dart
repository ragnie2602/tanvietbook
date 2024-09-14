import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/member/organization_info_response.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/button/action_button.dart';
import '../../../shared/widgets/dialog_helper.dart';
import '../../../shared/widgets/secondary_text_field.dart';

import '../../../data/resources/colors.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../bloc3/edit_profile_bloc.dart';

class EditOrganizationInfo extends StatelessWidget {
  // final UserInfoBloc userInfoBloc;
  final OrganizationInfoResponse organizationInfo;

  EditOrganizationInfo({
    Key? key,
    // required this.userInfoBloc,
    required this.organizationInfo,
  }) : super(key: key);

  // enterprise
  final TextEditingController positionEnterpriseController =
      TextEditingController();
  final TextEditingController departmentEnterpriseController =
      TextEditingController();
  final TextEditingController companyEnterpriseController =
      TextEditingController();
  final TextEditingController companyEnterpriseLinkController =
      TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController taxCodeController = TextEditingController();
  final TextEditingController addressEnterpriseController =
      TextEditingController();
  final TextEditingController hotLineController = TextEditingController();
  final TextEditingController hotLineInfoController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController websiteLinkController = TextEditingController();
  final TextEditingController fanPageController = TextEditingController();
  final TextEditingController fanPageLinkController = TextEditingController();
  final EditProfileBloc editProfileBloc = EditProfileBloc();

  @override
  Widget build(BuildContext context) {
    bool isPositionHidden = false;
    bool isDepartmentHidden = false;
    bool isOrganizationHidden = false;
    bool isMajorHidden = false;
    bool isTaxCodeHidden = false;
    bool isAddressHidden = false;
    bool isHotlineHidden = false;
    bool isWebsiteHidden = false;
    bool isFanPageHidden = false;

    /// get all organization info
    // userInfoBloc
    //     .add(UserInfoGetOrganizationInfoEvent(viewType: ViewType.viewOwn));

    // init controller
    positionEnterpriseController.text = organizationInfo.position ?? '';
    departmentEnterpriseController.text = organizationInfo.department ?? '';
    companyEnterpriseController.text = organizationInfo.organization ?? '';
    // companyEnterpriseLinkController.text = organizationInfo.websiteInfor ?? '';
    majorController.text = organizationInfo.major ?? '';
    taxCodeController.text = organizationInfo.taxCode ?? '';
    addressEnterpriseController.text = organizationInfo.address ?? '';
    hotLineController.text = organizationInfo.hotline ?? '';
    hotLineInfoController.text = organizationInfo.hotlineInfor ?? '';
    websiteController.text = organizationInfo.website ?? '';
    websiteLinkController.text = organizationInfo.websiteInfor ?? '';
    fanPageController.text = organizationInfo.fanpage ?? '';
    fanPageLinkController.text = organizationInfo.fanpageInfor ?? '';

    isPositionHidden = organizationInfo.positionHidden ?? false;
    isDepartmentHidden = organizationInfo.departmentHidden ?? false;
    isOrganizationHidden = organizationInfo.organizationHidden ?? false;
    isMajorHidden = organizationInfo.majorHidden ?? false;
    isTaxCodeHidden = organizationInfo.taxCodeHidden ?? false;
    isAddressHidden = organizationInfo.addressHidden ?? false;
    isHotlineHidden = organizationInfo.hotlineHidden ?? false;
    isWebsiteHidden = organizationInfo.websiteHidden ?? false;
    isFanPageHidden = organizationInfo.fanpageHidden ?? false;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, editProfileBloc.hasChangedOrganizationInfo);
        return false;
      },
      child: BlocProvider(
        create: (context) => editProfileBloc,
        child: Scaffold(
          backgroundColor: AppColor.primaryBackgroundColor,
          appBar: PrimaryAppBar(
            title: 'Chỉnh sửa thông tin tổ chức',
            onBackPressed: () {
              Navigator.pop(
                  context, editProfileBloc.hasChangedOrganizationInfo);
            },
          ),
          body: GestureDetector(
            onTap: () {
              ViewUtils.unFocusView();
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Row(
                      //   children: const [
                      //     Icon(
                      //       Icons.badge_outlined,
                      //       color: AppColor.secondaryColor,
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       'Thông tin tổ chức',
                      //       style: AppTextTheme.textPrimaryBoldMedium,
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      SecondaryTextField(
                        controller: positionEnterpriseController,
                        label: 'Chức vụ',
                        hintText: 'Nhập chức vụ',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        isSwitchChecked: !isPositionHidden,
                        isShowSwitch: true,
                        onSwitchChanged: (value) {
                          isPositionHidden = !value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        controller: departmentEnterpriseController,
                        label: 'Phòng ban',
                        hintText: 'Nhập phòng ban',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        isSwitchChecked: !isDepartmentHidden,
                        isShowSwitch: true,
                        onSwitchChanged: (value) {
                          isDepartmentHidden = !value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        controller: companyEnterpriseController,
                        label: 'Công ty (Tổ chức)',
                        hintText: 'Nhập tên Công ty (Tổ chức)',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        isSwitchChecked: !isOrganizationHidden,
                        isShowSwitch: true,
                        onSwitchChanged: (value) {
                          isOrganizationHidden = !value;
                        },
                      ),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      // SecondaryTextField(
                      //   prefixIcon: const Icon(Icons.link),
                      //   controller: companyEnterpriseLinkController,
                      //   hintText: 'Nhập đường liên kết của tổ chức',
                      //   textInputAction: TextInputAction.next,
                      //   textCapitalization:
                      //       TextCapitalization.sentences,
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        controller: majorController,
                        label: 'Lĩnh vực (Ngành nghề)',
                        hintText: 'Nhập lĩnh vực (ngành nghề)',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        isSwitchChecked: !isMajorHidden,
                        isShowSwitch: true,
                        onSwitchChanged: (value) {
                          isMajorHidden = !value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        controller: taxCodeController,
                        label: 'Mã số thuế',
                        hintText: 'Nhập mã số thuế',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        isSwitchChecked: !isTaxCodeHidden,
                        isShowSwitch: true,
                        onSwitchChanged: (value) {
                          isTaxCodeHidden = !value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        controller: addressEnterpriseController,
                        label: 'Địa chỉ',
                        hintText: 'Nhập Địa chỉ',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        isSwitchChecked: !isAddressHidden,
                        isShowSwitch: true,
                        onSwitchChanged: (value) {
                          isAddressHidden = !value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        controller: hotLineController,
                        label: 'Hotline',
                        hintText: 'Nhập tiêu đồ hotline',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        isSwitchChecked: !isHotlineHidden,
                        isShowSwitch: true,
                        onSwitchChanged: (value) {
                          isHotlineHidden = !value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        prefixIcon: const Icon(Icons.link),
                        controller: hotLineInfoController,
                        hintText: 'Nhập hotline',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        controller: websiteController,
                        label: 'Website',
                        hintText: 'Nhập website',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        isSwitchChecked: !isWebsiteHidden,
                        isShowSwitch: true,
                        onSwitchChanged: (value) {
                          isWebsiteHidden = !value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        prefixIcon: const Icon(Icons.link),
                        controller: websiteLinkController,
                        hintText: 'Nhập đường liên kết website',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        controller: fanPageController,
                        label: 'Fanpage',
                        hintText: 'Nhập fanpage',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                        isSwitchChecked: !isFanPageHidden,
                        isShowSwitch: true,
                        onSwitchChanged: (value) {
                          isFanPageHidden = !value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        prefixIcon: const Icon(Icons.link),
                        controller: fanPageLinkController,
                        hintText: 'Nhập đường liên kết fanpage',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocListener<EditProfileBloc, EditProfileState>(
                        listener: (context, state) {
                          if (state is EditProfileLoadingState) {
                            showDialog(
                                context: context,
                                builder: (builder) => getLoadingDialog());
                          }
                          if (state
                              is EditProfileUpdateOrganizationInfoSuccessState) {
                            Navigator.pop(context);
                            Navigator.of(context).pop(
                                editProfileBloc.hasChangedOrganizationInfo);
                          }
                        },
                        child: ActionButton(onSave: () {
                          editProfileBloc
                              .add(EditProfileUpdateOrganizationInfoEvent(
                                  organizationInfo: OrganizationInfoResponse(
                            id: organizationInfo.id,
                            organizationBaseId:
                                organizationInfo.organizationBaseId,
                            position:
                                positionEnterpriseController.text.trim() !=
                                        organizationInfo.position
                                    ? positionEnterpriseController.text.trim()
                                    : null,
                            positionHidden: isPositionHidden !=
                                    organizationInfo.positionHidden
                                ? isPositionHidden
                                : null,
                            department:
                                departmentEnterpriseController.text.trim() !=
                                        organizationInfo.department
                                    ? departmentEnterpriseController.text.trim()
                                    : null,
                            departmentHidden: isDepartmentHidden !=
                                    organizationInfo.departmentHidden
                                ? isDepartmentHidden
                                : null,
                            major: majorController.text.trim() !=
                                    organizationInfo.major
                                ? majorController.text.trim()
                                : null,
                            majorHidden:
                                isMajorHidden != organizationInfo.majorHidden
                                    ? isMajorHidden
                                    : null,
                            organization:
                                companyEnterpriseController.text.trim() !=
                                        organizationInfo.organization
                                    ? companyEnterpriseController.text.trim()
                                    : null,
                            organizationHidden: isOrganizationHidden !=
                                    organizationInfo.organizationHidden
                                ? isOrganizationHidden
                                : null,
                            taxCode: taxCodeController.text.trim() !=
                                    organizationInfo.taxCode
                                ? taxCodeController.text.trim()
                                : null,
                            taxCodeHidden: isTaxCodeHidden !=
                                    organizationInfo.taxCodeHidden
                                ? isTaxCodeHidden
                                : null,
                            address: addressEnterpriseController.text.trim() !=
                                    organizationInfo.address
                                ? addressEnterpriseController.text.trim()
                                : null,
                            addressHidden: isAddressHidden !=
                                    organizationInfo.addressHidden
                                ? isAddressHidden
                                : null,
                            hotline: hotLineController.text.trim() !=
                                    organizationInfo.hotline
                                ? hotLineController.text.trim()
                                : null,
                            hotlineHidden: isHotlineHidden !=
                                    organizationInfo.hotlineHidden
                                ? isHotlineHidden
                                : null,
                            hotlineInfor: hotLineInfoController.text.trim() !=
                                    organizationInfo.hotlineInfor
                                ? hotLineInfoController.text.trim()
                                : null,
                            website: websiteController.text.trim() !=
                                    organizationInfo.website
                                ? websiteController.text.trim()
                                : null,
                            websiteHidden: isWebsiteHidden !=
                                    organizationInfo.websiteHidden
                                ? isWebsiteHidden
                                : null,
                            websiteInfor: websiteLinkController.text.trim() !=
                                    organizationInfo.websiteInfor
                                ? websiteLinkController.text.trim()
                                : null,
                            fanpage: fanPageController.text.trim() !=
                                    organizationInfo.fanpage
                                ? fanPageController.text.trim()
                                : null,
                            fanpageHidden: isFanPageHidden !=
                                    organizationInfo.fanpageHidden
                                ? isFanPageHidden
                                : null,
                            fanpageInfor: fanPageLinkController.text.trim() !=
                                    organizationInfo.fanpageInfor
                                ? fanPageLinkController.text.trim()
                                : null,
                          )));
                        }, onCancel: () {
                          Navigator.pop(context,
                              editProfileBloc.hasChangedOrganizationInfo);
                        }),
                      ),
                    ],
                    // );
                    // } else {
                    //   return PrimaryShimmer(
                    //     child: Column(
                    //       children: const [
                    //         ContainerShimmer(),
                    //         SizedBox(height: 10),
                    //         ContainerShimmer(),
                    //         SizedBox(height: 10),
                    //         ContainerShimmer(),
                    //         SizedBox(height: 10),
                    //       ],
                    //     ),
                    //   );
                    // }
                    // },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
