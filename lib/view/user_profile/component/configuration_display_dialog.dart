import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/constants.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../model/member/base_info_response.dart';
import '../../../shared/widgets/button/action_button.dart';
import '../bloc/user_info_bloc.dart';

Dialog getConfigurationDisplayDialog(context, {required UserInfoBloc bloc}) {
  return Dialog(
    child: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        height: 500,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ConfigurationDisplayDialogUI(bloc: bloc),
      ),
    ),
  );
}

class ConfigurationDisplayDialogUI extends StatefulWidget {
  final UserInfoBloc bloc;
  const ConfigurationDisplayDialogUI({required this.bloc, Key? key})
      : super(key: key);

  @override
  State<ConfigurationDisplayDialogUI> createState() =>
      _ConfigurationDisplayDialogUIState();
}

class _ConfigurationDisplayDialogUIState
    extends State<ConfigurationDisplayDialogUI> {
  List<BaseInfoResponse> listBaseInfoResponse = [];

  @override
  void initState() {
    listBaseInfoResponse.addAll(widget.bloc.memberInfo?.baseInfor ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      proxyDecorator: proxyDecorator,
      header: RichText(
        text: const TextSpan(
          text: 'Cấu hình giao diện\n',
          style: AppTextTheme.textPageTitle,
          children: [
            TextSpan(
                text:
                    'Giữ và kéo thả vị trí các thông tin để sắp xếp hợp lí hơn!',
                style: AppTextTheme.textPrimarySmall)
          ],
        ),
      ),
      footer: ActionButton(
        onSave: () {
          Function eq = const ListEquality().equals;
          if (eq(listBaseInfoResponse, widget.bloc.memberInfo?.baseInfor) ==
              false) {
            widget.bloc.add(
              UserInfoConfigurationDisplayEvent(
                listDisplayItem:
                    listBaseInfoResponse.map((e) => e.id ?? '').toList(),
              ),
            );
          }
          Navigator.pop(context);
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
      children: <Widget>[
        const SizedBox(
          height: 12,
          key: ValueKey(-1),
        ),
        for (int index = 0; index < listBaseInfoResponse.length; index++)
          Container(
            key: ValueKey(index),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(width: 1, color: AppColor.gray09),
                borderRadius: BorderRadius.circular(2)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset({
                      BaseInfoType.personalInformation:
                          "assets/icons/ic_personal_information.svg",
                      BaseInfoType.contact:
                          "assets/icons/ic_contact_information.svg",
                      BaseInfoType.additionalPath:
                          "assets/icons/ic_link_information.svg",
                      BaseInfoType.organization:
                          "assets/icons/ic_organization_information.svg",
                      BaseInfoType.highLight:
                          "assets/icons/ic_highlight_information.svg",
                    }[listBaseInfoResponse[index].type] ??
                    BaseInfoType.personalInformation),
                const SizedBox(width: 10),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '${listBaseInfoResponse[index].title}\n',
                      style: AppTextTheme.textPrimary,
                      children: [
                        TextSpan(
                          text: {
                            BaseInfoType.personalInformation:
                                BaseInfoIntroduction.personalInformation,
                            BaseInfoType.contact: BaseInfoIntroduction.contact,
                            BaseInfoType.additionalPath:
                                BaseInfoIntroduction.additionalPath,
                            BaseInfoType.organization:
                                BaseInfoIntroduction.organization,
                            BaseInfoType.highLight:
                                BaseInfoIntroduction.highLight,
                          }[listBaseInfoResponse[index].type],
                          style: AppTextTheme.textPrimarySmall,
                        )
                      ],
                    ),
                  ),
                ),
                ReorderableDragStartListener(
                  key: const ValueKey(5),
                  index: index,
                  child: const Icon(Icons.drag_indicator),
                ),
              ],
            ),
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        oldIndex--;
        if (newIndex > 0) newIndex--;
        setState(
          () {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            var item = listBaseInfoResponse.removeAt(oldIndex);
            listBaseInfoResponse.insert(newIndex, item);
          },
        );
      },
    );
  }
}

Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      return Material(
        color: AppColor.primaryColor,
        shadowColor: AppColor.primaryColor,
        child: child,
      );
    },
    child: child,
  );
}
