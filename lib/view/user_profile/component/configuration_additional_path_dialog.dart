import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../model/member/additional_path_response.dart';
import '../../../shared/widgets/button/action_button.dart';
import '../../../shared/widgets/image/primary_image.dart';
import '../bloc/user_info_bloc.dart';

Dialog getConfigurationAdditionalPathDialog(
  context, {
  required List<AdditionalPathInfoResponse> additionalPathInfoResponse,
  required UserInfoBloc bloc,
}) {
  return Dialog(
    child: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        height: 500,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ConfigurationAdditionalPathDialogUI(
            additionalPathInfoResponse: additionalPathInfoResponse, bloc: bloc),
      ),
    ),
  );
}

class ConfigurationAdditionalPathDialogUI extends StatefulWidget {
  final List<AdditionalPathInfoResponse> additionalPathInfoResponse;
  final UserInfoBloc bloc;
  const ConfigurationAdditionalPathDialogUI(
      {required this.bloc, required this.additionalPathInfoResponse, Key? key})
      : super(key: key);

  @override
  State<ConfigurationAdditionalPathDialogUI> createState() =>
      _ConfigurationAdditionalPathDialogUIState();
}

class _ConfigurationAdditionalPathDialogUIState
    extends State<ConfigurationAdditionalPathDialogUI> {
  List<AdditionalPathInfoResponse> listAdditionalPath = [];

  @override
  void initState() {
    listAdditionalPath.addAll(widget.additionalPathInfoResponse);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Cấu hình liên kết bổ sung\n',
            style: AppTextTheme.textPageTitle,
            children: [
              TextSpan(
                  text:
                      'Giữ và kéo thả vị trí các thông tin để sắp xếp hợp lí hơn!\n',
                  style: AppTextTheme.textPrimarySmall),
            ],
          ),
        ),
        Expanded(
          child: ReorderableListView(
            shrinkWrap: true,
            proxyDecorator: proxyDecorator,
            children: widget.additionalPathInfoResponse
                .map(
                  (additionalPathItem) => Container(
                    key: Key(additionalPathItem.id!),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.gray09),
                        borderRadius: BorderRadius.circular(2)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: additionalPathItem.image != null
                              ? Opacity(
                                  opacity: (additionalPathItem.hidden != null &&
                                          additionalPathItem.hidden == true)
                                      ? .5
                                      : 1,
                                  child: PrimaryNetworkImage(
                                    imageUrl: additionalPathItem.image ?? '',
                                    width: 40,
                                    height: 40,
                                  ),
                                )
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                additionalPathItem.title ?? '',
                                style: additionalPathItem.hidden != null &&
                                        additionalPathItem.hidden == true
                                    ? AppTextTheme.textPrimary.copyWith(
                                        color: AppColor.neutral5,
                                        overflow: TextOverflow.ellipsis)
                                    : AppTextTheme.textPrimary.copyWith(
                                        overflow: TextOverflow.ellipsis),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                additionalPathItem.value ?? '',
                                style: additionalPathItem.hidden != null &&
                                        additionalPathItem.hidden == true
                                    ? AppTextTheme.textPrimarySmall.copyWith(
                                        color: AppColor.neutral5,
                                        overflow: TextOverflow.ellipsis)
                                    : AppTextTheme.textPrimarySmall.copyWith(
                                        overflow: TextOverflow.ellipsis),
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
                )
                .toList(),
            onReorder: (int oldIndex, int newIndex) {
              setState(
                () {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  log("o: $oldIndex, n: $newIndex");
                  var item =
                      widget.additionalPathInfoResponse.removeAt(oldIndex);
                  widget.additionalPathInfoResponse.insert(newIndex, item);
                },
              );
            },
          ),
        ),
        ActionButton(
          onSave: () {
            Function eq = const ListEquality().equals;
            if (eq(widget.additionalPathInfoResponse, listAdditionalPath) ==
                false) {
              widget.bloc.add(
                UserInfoConfigurationAdditionalPathEvent(
                  listAdditionalPath: widget.additionalPathInfoResponse
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
