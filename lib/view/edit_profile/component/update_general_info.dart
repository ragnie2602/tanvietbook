import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../model/member/member_detail_info.dart';
import '../../../shared/bloc/get_image/get_image_bloc.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/dialog_helper.dart';
import '../../../shared/widgets/image/primary_reorder_grid_image.dart';
import '../../../shared/widgets/primary_app_bar.dart';

import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/button/action_button.dart';
import '../../../shared/widgets/secondary_text_field.dart';
import '../bloc3/edit_profile_bloc.dart';

class EditGeneralInfo extends StatelessWidget {
  EditGeneralInfo({Key? key, required this.memberDetailInfo}) : super(key: key);

  final MemberInfo memberDetailInfo;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController quoteNameController = TextEditingController();

  final EditProfileBloc _editProfileBloc = EditProfileBloc();
  late final GetImageBloc _getImageBloc = GetImageBloc();

  void initTextController() {
    nameController.text = memberDetailInfo.fullName ?? '';
    nickNameController.text = memberDetailInfo.nickName ?? '';
    quoteNameController.text =
        Utils.convertHtmlToText(memberDetailInfo.favoriteQuote ?? '');
  }

  @override
  Widget build(BuildContext context) {
    bool isNicknameEnable = !(memberDetailInfo.nickNameHidden ?? false);
    bool isBioEnable = !(memberDetailInfo.favoriteQuoteHidden ?? false);
    bool isHighlightEnable = !(memberDetailInfo.hightlightHidden ?? false);

    initTextController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _editProfileBloc,
        ),
        BlocProvider(
          create: (context) => _getImageBloc,
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, _editProfileBloc.hasChangedPersonalInfo);
          return false;
        },
        child: Scaffold(
          backgroundColor: AppColor.primaryBackgroundColor,
          appBar: PrimaryAppBar(
            title: 'Chỉnh sửa thông tin chung',
            onBackPressed: () {
              Navigator.pop(context, _editProfileBloc.hasChangedPersonalInfo);
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SecondaryTextField(
                        isRequired: true,
                        controller: nameController,
                        label: 'Họ tên',
                        hintText: 'Nhập họ tên',
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        controller: nickNameController,
                        label: 'Biệt danh',
                        hintText: 'Nhập biệt danh',
                        isShowSwitch: true,
                        isSwitchChecked: isNicknameEnable,
                        onSwitchChanged: (value) {
                          isNicknameEnable = value;
                        },
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SecondaryTextField(
                        controller: quoteNameController,
                        label: 'Trích dẫn',
                        hintText: 'Nhập trích dẫn',
                        textInputAction: TextInputAction.newline,
                        minLines: 4,
                        isShowSwitch: true,
                        isSwitchChecked: isBioEnable,
                        onSwitchChanged: (value) {
                          isBioEnable = value;
                        },
                        textCapitalization: TextCapitalization.sentences,
                        onTap: () {
                          // globalKey.currentContext?.findRenderObject()?.showOnScreen();
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Logo của bạn",
                        style: AppTextTheme.textPrimary,
                      ),
                      const SizedBox(height: 10),
                      PrimaryReorderGridImage(
                          maxQuantity: 1,
                          initialData: memberDetailInfo.logo != null
                              ? [memberDetailInfo.logo!]
                              : [],
                          getImageBloc: _getImageBloc),
                      MultiBlocListener(
                        listeners: [
                          BlocListener<EditProfileBloc, EditProfileState>(
                            listener: (context, state) {
                              if (state is EditProfileLoadingState) {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => getLoadingDialog());
                              }
                              if (state
                                  is EditProfileUpdatePersonalInfoSuccessState) {
                                Navigator.pop(context);
                                Navigator.pop(context,
                                    _editProfileBloc.hasChangedPersonalInfo);
                              }
                              if (state
                                  is EditProfileUpdatePersonalInfoFailedState) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                          BlocListener<GetImageBloc, GetImageState>(
                            listener: (context, state) {
                              if (state
                                  is GetImageGetMultiImageUrlSuccessState) {
                                final String? logo = List<String>.from(state
                                            .imageData
                                            .where((element) =>
                                                element.type !=
                                                ImageDataType.addNew)
                                            .map((e) => e.data)
                                            .toList())
                                        .isNotEmpty
                                    ? List<String>.from(state.imageData
                                            .where((element) =>
                                                element.type !=
                                                ImageDataType.addNew)
                                            .map((e) => e.data)
                                            .toList())
                                        .first
                                    : null;

                                _editProfileBloc.add(
                                  EditProfileUpdatePersonalInfoEvent(
                                    memberInfo: MemberInfo(
                                        fullName: memberDetailInfo.fullName !=
                                                nameController.text.trim()
                                            ? nameController.text.trim()
                                            : null,
                                        nickName: memberDetailInfo.nickName !=
                                                nickNameController.text.trim()
                                            ? nickNameController.text.trim()
                                            : null,
                                        favoriteQuote: Utils.convertHtmlToText(
                                                    memberDetailInfo.bio ??
                                                        '') !=
                                                quoteNameController.text.trim()
                                            ? quoteNameController.text.trim()
                                            : null,
                                        // hightlight: highlightValue !=
                                        //         memberDetailInfo.hightlight
                                        //     ? highlightValue.toString()
                                        //     : null,
                                        logo: logo,
                                        nickNameHidden: !isNicknameEnable,
                                        favoriteQuoteHidden: !isBioEnable,
                                        hightlightHidden: !isHighlightEnable),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                        child: ActionButton(onSave: () {
                          ViewUtils.unFocusView();
                          _getImageBloc.add(GetImageGetMultiImageUrlEvent());
                        }, onCancel: () {
                          Navigator.pop(
                              context, _editProfileBloc.hasChangedPersonalInfo);
                        }),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
