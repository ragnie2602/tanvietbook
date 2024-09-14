import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import '../../../config/routes.dart';
import '../../../data/resources/resources.dart';
import '../../../shared/etx/dart_extensions.dart';
import '../../../shared/utils/utils.dart';
import 'container_block.dart';

import '../../../data/constants.dart';
import '../../../model/member/base_info_response.dart';
import '../../../shared/widgets/quill/primary_editor.dart';
import '../../edit_profile/bloc3/edit_profile_bloc.dart';
import '../bloc/user_info_bloc.dart';

class HighLightInfo extends StatelessWidget {
  final BaseInfoResponse baseInfoResponse;
  final EditProfileBloc editProfileBloc;
  final ViewType viewType;

  const HighLightInfo({
    Key? key,
    required this.viewType,
    required this.baseInfoResponse,
    required this.editProfileBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
        buildWhen: (previous, current) =>
            current is UserInfoGetHighlightSuccessState,
        builder: (context, state) {
          if (state is UserInfoGetHighlightSuccessState &&
                  !state.highlightInfo.isQuillValueNullOrEmpty() &&
                  viewType != ViewType.viewOwn ||
              state is UserInfoGetHighlightSuccessState &&
                  viewType == ViewType.viewOwn) {
            state;
            var controller = QuillController(
                document: Utils.parseQuillDocument(state.highlightInfo),
                selection: const TextSelection.collapsed(offset: 0));

            return UserContainerBlock(
              title: 'Thông tin nổi bật',
              isExpandable: viewType != ViewType.viewOwn,
              icon: const Icon(
                Icons.flourescent_sharp,
                color: AppColor.secondaryColor,
              ),
              showAction: viewType == ViewType.viewOwn,
              showConfigItemButton: false,
              showAddButton: false,
              onEditButtonPressed: () => _onUpdateHighlight(context),
              onSwitchValueChanged: (value) {
                editProfileBloc.add(EditProfileUpdateBaseInfoEvent(
                  baseInfo: BaseInfoResponse(
                    id: baseInfoResponse.id,
                    hidden: !value,
                  ),
                ));
              },
              switchInitialValue: !(baseInfoResponse.hidden ?? false),
              child: (!state.highlightInfo.isQuillValueNullOrEmpty())
                  ? PrimaryEditor(
                      controller: controller,
                      readOnly: true,
                    )
                  : const Text(
                      'Chưa cập nhật thông tin nổi bật',
                      style: AppTextTheme.textLowPriority,
                    ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  _onUpdateHighlight(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.userUpdateHighlight,
            arguments: UserUpdateHighlightInfoArgs(
                userInfoBloc: context.read<UserInfoBloc>()))
        .then((value) => null);
  }
}
