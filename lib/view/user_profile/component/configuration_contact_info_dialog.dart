import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../model/member/contact_member_info.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/button/action_button.dart';
import '../bloc/user_info_bloc.dart';

Dialog getConfigurationContactInfoDialog(context,
    {required List<ContactInfoResponse> contactInfoResponse,
    required UserInfoBloc bloc}) {
  return Dialog(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      height: 500,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ConfigurationContactInfoDialogUI(
          contactInfoResponse: contactInfoResponse, bloc: bloc),
    ),
  );
}

class ConfigurationContactInfoDialogUI extends StatefulWidget {
  final UserInfoBloc bloc;
  final List<ContactInfoResponse> contactInfoResponse;
  const ConfigurationContactInfoDialogUI(
      {required this.contactInfoResponse, required this.bloc, Key? key})
      : super(key: key);

  @override
  State<ConfigurationContactInfoDialogUI> createState() =>
      _ConfigurationContactInfoDialogUIState();
}

class _ConfigurationContactInfoDialogUIState
    extends State<ConfigurationContactInfoDialogUI> {
  List<ContactInfoResponse> listContact = [];

  @override
  void initState() {
    listContact.addAll(widget.contactInfoResponse);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Cấu hình thông tin liên hệ\n',
            style: AppTextTheme.textPageTitle,
            children: [
              TextSpan(
                text:
                    'Giữ và kéo thả vị trí các thông tin để sắp xếp hợp lí hơn!',
                style: AppTextTheme.textPrimarySmall,
              )
            ],
          ),
        ),
        Expanded(
          child: ReorderableListView(
            shrinkWrap: true,
            proxyDecorator: proxyDecorator,
            children: widget.contactInfoResponse
                .map((contactItem) => Column(
                      key: Key(contactItem.id ?? ''),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 20, left: 16, right: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Image.network(
                                          Utils.getIconUrlByType(
                                              contactItem.type ?? ''),
                                          height: 24,
                                          width: 24),
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
                                              contactItem.title ??
                                                  'Chưa có tiêu đề',
                                              style: (contactItem.hidden ??
                                                      false)
                                                  ? AppTextTheme.textLowPriority
                                                  : AppTextTheme
                                                      .textPrimaryBold),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(contactItem.value ?? '',
                                              maxLines: 2,
                                              style: (contactItem.hidden ??
                                                      false)
                                                  ? AppTextTheme.textLowPriority
                                                  : AppTextTheme.textPrimary),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const ReorderableDragStartListener(
                                key: ValueKey(-2),
                                index: 1,
                                child: Icon(Icons.drag_indicator),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
                .toList(),
            onReorder: (int oldIndex, int newIndex) {
              setState(
                () {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  var item = widget.contactInfoResponse.removeAt(oldIndex);
                  widget.contactInfoResponse.insert(newIndex, item);
                },
              );
            },
          ),
        ),
        ActionButton(
          onSave: () {
            Function eq = const ListEquality().equals;
            if (eq(widget.contactInfoResponse, listContact) == false) {
              widget.bloc.add(
                UserInfoConfigurationContactEvent(
                  listContact: widget.contactInfoResponse
                      .map((e) => e.id ?? '')
                      .toList(),
                ),
              );
            }
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ],
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
