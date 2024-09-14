import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import '../../../config/routes.dart';
import '../../../shared/widgets/button/action_button.dart';
import '../../../shared/widgets/dialog_helper.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../bloc3/edit_profile_bloc.dart';
import '../../user_profile/bloc/user_info_bloc.dart';

import '../../../data/resources/resources.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/container/primary_container.dart';
import '../../../shared/widgets/quill/primary_editor.dart';

class UserUpdateHighlightInfo extends StatelessWidget {
  const UserUpdateHighlightInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as UserUpdateHighlightInfoArgs;
    final EditProfileBloc editProfileBloc = EditProfileBloc();

    final controller = QuillController(
        document:
            Utils.parseQuillDocument(args.userInfoBloc.memberInfo?.hightlight),
        selection: const TextSelection.collapsed(offset: 0));
    bool isHighlightEnable =
        !(args.userInfoBloc.memberInfo?.hightlightHidden ?? false);

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserInfoBloc>.value(
          value: args.userInfoBloc,
        ),
        BlocProvider(
          create: (context) => editProfileBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: const PrimaryAppBar(
          title: 'Chỉnh sửa thông tin nổi bật',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  PrimaryContainer(
                      backgroundColor: AppColor.white,
                      padding: const EdgeInsets.all(12),
                      borderColor: AppColor.neutral5,
                      child: PrimaryEditor(controller: controller)),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocListener<EditProfileBloc, EditProfileState>(
                    listener: (context, state) {
                      if (state is EditProfileUpdateHighlightInfoSuccessState) {
                        Navigator.pop(context);

                        Navigator.pop(context);
                        args.userInfoBloc.memberInfo =
                            args.userInfoBloc.memberInfo?.copyWith(
                          hightlight: jsonEncode(
                              controller.document.toDelta().toJson()),
                          hightlightHidden: !isHighlightEnable,
                        );
                        args.userInfoBloc
                            .add(UserInfoRebuildHighlightInfoEvent());
                      }
                    },
                    child: ActionButton(onSave: () {
                      final newValue = jsonEncode(
                          {'ops': controller.document.toDelta().toJson()});
                      log(' new $newValue');
                      if (newValue !=
                          args.userInfoBloc.memberInfo?.hightlight) {
                        editProfileBloc.add(EditProfileUpdateHighlightInfoEvent(
                          highlightInfo: newValue,
                        ));

                        showDialog(
                            context: context,
                            builder: (_) => getLoadingDialog(),
                            barrierDismissible: false);
                      } else {
                        Navigator.pop(context);
                      }
                    }, onCancel: () {
                      Navigator.pop(context);
                    }),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
