import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/constants.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../model/member/additional_path_response.dart';
import '../../../model/member/contact_default_type_response.dart';
import '../../../shared/bloc/get_image/get_image_bloc.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/button/action_button.dart';
import '../../../shared/widgets/dialog_helper.dart';
import '../../../shared/widgets/image/primary_reorder_grid_image.dart';
import '../../../shared/widgets/primary_switch.dart';
import '../../../shared/widgets/secondary_text_field.dart';
import '../bloc3/edit_profile_bloc.dart';
import 'contact_type_drop_down.dart';

class UpdateAdditionalPathInfo extends StatefulWidget {
  final bool isAddNew;
  final String additionalPathBaseId;

  /// if you need to update this additionalPath item, you must pass the additionalPath info object to here.
  final AdditionalPathInfoResponse? additionalPathInfoResponse;

  const UpdateAdditionalPathInfo(
      {Key? key,
      this.isAddNew = false,
      required this.additionalPathBaseId,
      this.additionalPathInfoResponse})
      : super(key: key);

  @override
  State<UpdateAdditionalPathInfo> createState() =>
      _UpdateAdditionalPathInfoState();
}

class _UpdateAdditionalPathInfoState extends State<UpdateAdditionalPathInfo> {
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();
  final _titleFormKey = GlobalKey<FormState>();
  final _detailFormKey = GlobalKey<FormState>();

  final EditProfileBloc _editProfileBloc = EditProfileBloc();
  final GetImageBloc _getImageBloc = GetImageBloc();

  late bool isEnable;
  late bool initialSwitchValue;

  ContactDefaultTypeResponse? selectedContactType;
  String? imageUrl;
  @override
  void initState() {
    isEnable = true;
    initialSwitchValue = widget.additionalPathInfoResponse != null
        ? widget.additionalPathInfoResponse?.hidden == false
            ? true
            : false
        : true;
    _titleController.text = widget.additionalPathInfoResponse != null
        ? widget.additionalPathInfoResponse?.title ?? ''
        : '';
    _detailController.text = widget.additionalPathInfoResponse != null
        ? widget.additionalPathInfoResponse?.value ?? ''
        : '';
    imageUrl = widget.additionalPathInfoResponse?.image;

    if (widget.isAddNew) {
      _editProfileBloc.add(const EditProfileGetContactTypeEvent(isType: true));
    } else {
      try {
        selectedContactType = _editProfileBloc.contactItems.firstWhere(
          (element) => element.type == widget.additionalPathInfoResponse?.type,
        );
      } catch (e) {
        selectedContactType = null;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _editProfileBloc.hasChangedAdditionalPathInfo);
        return false;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _editProfileBloc,
          ),
          BlocProvider(
            create: (context) => _getImageBloc,
          ),
        ],
        child: GestureDetector(
          onTap: () {
            ViewUtils.unFocusView();
          },
          child: Dialog(
              child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
              minHeight: 50,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          widget.isAddNew
                              ? 'Thêm mới liên kết bổ sung'
                              : 'Cập nhật liên kết bổ sung',
                          style: AppTextTheme.textPrimaryBoldMedium,
                        ),
                        const Spacer(),
                        PrimarySwitch(
                          initialValue: initialSwitchValue,
                          onToggle: (value) {
                            isEnable = value;
                          },
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColor.gray09,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SecondaryTextField(
                          controller: _titleController,
                          hintText: 'Nhập tiêu đề *',
                          isRequired: true,
                          validator: Utils.textEmptyValidator,
                          textInputAction: TextInputAction.next,
                          formKey: _titleFormKey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SecondaryTextField(
                          isRequired: true,
                          controller: _detailController,
                          hintText: 'Nhập đường liên kết *',
                          prefixIcon: const Icon(Icons.link),
                          validator: Utils.textEmptyValidator,
                          maxLines: 3,
                          textInputAction: TextInputAction.done,
                          formKey: _detailFormKey,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ContactTypeDropDown(
                          hintText: 'Chọn loại icon',
                          onChanged: (value) {
                            selectedContactType = value;
                          },
                          controller: TextEditingController(),
                          items: _editProfileBloc.contactItems,
                          initialValue: selectedContactType,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocConsumer<GetImageBloc, GetImageState>(
                          listener: (context, state) {
                            if (state is GetImageGetImageUrlSuccessState) {
                              _editProfileBloc.add(
                                  EditProfileAddAdditionalPathInfoEvent(
                                      additionalPathInfoResponse:
                                          AdditionalPathInfoResponse(
                                id: widget.additionalPathInfoResponse?.id,
                                pathBaseId: widget.additionalPathBaseId,
                                title: _titleController.text.trim(),
                                value: _detailController.text.trim(),
                                image: state.imageUrl,
                                type: selectedContactType?.type,
                                icon: selectedContactType?.iconUrl,
                                hidden: (widget.additionalPathInfoResponse !=
                                            null &&
                                        widget.additionalPathInfoResponse
                                                ?.hidden !=
                                            !isEnable)
                                    ? !isEnable
                                    : null,
                              )));
                            }
                            if (state is GetImageGetImageUrlErrorState) {
                              Navigator.pop(context);
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is GetImageGetImageUrlErrorState ||
                              current is GetImageGetImageUrlSuccessState,
                          builder: (context, state) {
                            return PrimaryReorderGridImage(
                              initialData: (widget.additionalPathInfoResponse
                                              ?.image ==
                                          null ||
                                      widget.additionalPathInfoResponse!.image!
                                          .isEmpty)
                                  ? []
                                  : [widget.additionalPathInfoResponse!.image!],
                              getImageBloc: _getImageBloc,
                              maxQuantity: 1,
                              childAspectRatio: 1,
                              fit: BoxFit.cover,
                              onDataChanged: (imageData) {
                                log('data changed: $imageData');
                                if (imageData[0].type == ImageDataType.addNew) {
                                  imageUrl = '';
                                }
                              },
                            );
                          },
                        ),
                        BlocListener<EditProfileBloc, EditProfileState>(
                          listener: (context, state) {
                            if (state
                                is EditProfileUpdateAdditionalPathInfoSuccessState) {
                              Navigator.pop(context);
                              Navigator.pop(
                                  context,
                                  _editProfileBloc
                                      .hasChangedAdditionalPathInfo);
                            }
                            if (state is EditProfileLoadingState) {}
                            if (state
                                is EditProfileUpdatePersonalInfoFailedState) {
                              Navigator.pop(context);
                            }
                          },
                          child: const SizedBox(
                            height: 30,
                          ),
                        ),
                        ActionButton(
                          saveText: widget.additionalPathInfoResponse != null
                              ? 'Cập nhật'
                              : 'Thêm mới',
                          onSave: () {
                            bool c1 = _titleFormKey.currentState!.validate();
                            bool c2 = _detailFormKey.currentState!.validate();
                            if (c1 && c2) {
                              if (_getImageBloc.imageData.isEmpty ||
                                  _getImageBloc.imageData.first.type ==
                                      ImageDataType.addNew ||
                                  _getImageBloc.imageData.first.type ==
                                      ImageDataType.uri) {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => getLoadingDialog());
                                _editProfileBloc
                                    .add(EditProfileAddAdditionalPathInfoEvent(
                                  additionalPathInfoResponse:
                                      AdditionalPathInfoResponse(
                                    id: widget.additionalPathInfoResponse?.id,
                                    pathBaseId: widget.additionalPathBaseId,
                                    title: _titleController.text.trim(),
                                    value: _detailController.text.trim(),
                                    type: selectedContactType?.type,
                                    icon: selectedContactType?.iconUrl,
                                    hidden: (widget.additionalPathInfoResponse !=
                                                null &&
                                            widget.additionalPathInfoResponse
                                                    ?.hidden !=
                                                !isEnable)
                                        ? !isEnable
                                        : null,
                                    image: imageUrl,
                                  ),
                                ));
                              } else {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => getLoadingDialog());
                                _getImageBloc.add(GetImageGetImageUrlEvent(
                                    imagePath:
                                        _getImageBloc.imageData.first.data,
                                    imageType: ImageType.none));
                              }
                            }
                          },
                          onCancel: () {
                            Navigator.pop(context,
                                _editProfileBloc.hasChangedAdditionalPathInfo);
                          },
                          onDelete: widget.isAddNew
                              ? null
                              : () {
                                  _editProfileBloc.add(
                                      EditProfileDeleteAdditionalPathInfoEvent(
                                    additionalPathId:
                                        widget.additionalPathInfoResponse?.id ??
                                            '',
                                    additionalPathBaseId:
                                        widget.additionalPathBaseId,
                                  ));
                                },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
