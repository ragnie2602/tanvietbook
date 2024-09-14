import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/member/contact_default_type_response.dart';
import '../../../model/member/contact_member_info.dart';
import '../../../shared/widgets/primary_checkbox.dart';
import '../../../shared/widgets/primary_shimmer.dart';
import '../../../shared/widgets/primary_switch.dart';
import 'contact_type_drop_down.dart';

import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/dialog_helper.dart';
import '../../../shared/widgets/primary_drop_down_form_field.dart';
import '../../../shared/widgets/secondary_text_field.dart';
import '../bloc3/edit_profile_bloc.dart';
import '../../../shared/widgets/button/action_button.dart';

class UpdateContactInfo extends StatefulWidget {
  final bool isAddNew;
  final String contactBaseId;

  /// if you need to update this contact item, you must pass the contact info object to here.
  final ContactInfoResponse? contactInfoResponse;

  const UpdateContactInfo(
      {Key? key,
      this.isAddNew = false,
      required this.contactBaseId,
      this.contactInfoResponse})
      : super(key: key);

  @override
  State<UpdateContactInfo> createState() => _UpdateContactInfoState();
}

class _UpdateContactInfoState extends State<UpdateContactInfo> {
  late ContactDefaultTypeResponse selectedContactType;
  ContactDefaultTypeResponse? selectedBankType;
  late bool contactHidden;
  late bool contactUseAsBase;
  late bool hasChangeMainContactType = true;
  final EditProfileBloc _editProfileBloc = EditProfileBloc();
  List<String>? bankAccountInfo;

  final _titleController = TextEditingController();
  final _detailController = TextEditingController();

  final _titleFormKey = GlobalKey<FormState>();
  final _detailFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _editProfileBloc.bankItems;
    _editProfileBloc.contactItems;
    if (widget.isAddNew) {
      _editProfileBloc.add(const EditProfileGetContactTypeEvent(isType: true));
    } else {
      selectedContactType = ContactDefaultTypeResponse(
          iconUrl:
              Utils.getIconUrlByType(widget.contactInfoResponse?.type ?? ''),
          value: widget.contactInfoResponse?.type,
          label: Utils.getSocialLabelByType(
              widget.contactInfoResponse?.type ?? ''),
          type: widget.contactInfoResponse?.type);

      if (selectedContactType.type == 'BankAccount') {
        if (widget.contactInfoResponse?.type == 'BankAccount') {
          bankAccountInfo = widget.contactInfoResponse?.value?.split('\$')
            ?..removeWhere((element) => element.isEmpty);
        }

        selectedBankType = _editProfileBloc.bankItems
            .firstWhere((element) => element.type == bankAccountInfo![0]);
      }
    }

    _titleController.text = widget.contactInfoResponse != null
        ? widget.contactInfoResponse?.type == 'BankAccount'
            ? bankAccountInfo![1]
            : widget.contactInfoResponse!.title ?? ''
        : '';
    _detailController.text = widget.contactInfoResponse != null
        ? widget.contactInfoResponse?.type == 'BankAccount'
            ? bankAccountInfo![2]
            : widget.contactInfoResponse!.value ?? ''
        : '';
    contactHidden = widget.contactInfoResponse != null
        ? (widget.contactInfoResponse?.hidden ?? false)
        : false;
    contactUseAsBase = widget.contactInfoResponse != null
        ? (widget.contactInfoResponse?.useAsBase ?? false)
        : false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _editProfileBloc.hasChangedContactInfo);
        return false;
      },
      child: BlocProvider(
        create: (context) => _editProfileBloc,
        child: Dialog(
            child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.95,
              minHeight: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      widget.isAddNew ? 'Thêm mới liên hệ' : 'Cập nhật liên hệ',
                      style: AppTextTheme.textPrimaryBoldMedium,
                    ),
                    const Spacer(),
                    PrimarySwitch(
                      initialValue: !contactHidden,
                      onToggle: (value) {
                        contactHidden = !value;
                      },
                    )
                  ],
                ),
              ),

              // main type
              !widget.isAddNew // -> is update
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ContactTypeDropDown(
                        hintText: 'Chọn loại liên hệ',
                        readOnly: true,
                        onChanged: (value) {
                          // _titleController.text = value.type ?? '';
                          selectedContactType = value;
                          // _editProfileBloc.add(EditProfileGetContactTypeEvent(
                          //     isType: false, type: value.value));
                        },
                        controller: TextEditingController(),
                        items: [selectedContactType],
                        initialValue: selectedContactType,
                      ),
                    )
                  : BlocBuilder<EditProfileBloc, EditProfileState>(
                      buildWhen: (pre, current) =>
                          current is EditProfileGetContactTypeSuccessState,
                      builder: (context, state) {
                        if (state is EditProfileGetContactTypeSuccessState) {
                          // final contactType = state.contactDefaultTypeResponse;

                          // ContactDefaultTypeResponse initialValue;
                          // try {
                          //   initialValue = widget.contactInfoResponse != null
                          //       ? contactType
                          //           .where((element) =>
                          //               element.type ==
                          //               widget.contactInfoResponse?.type)
                          //           .toList()
                          //           .first
                          //       : contactType[0];
                          // } catch (e) {
                          //   initialValue = contactType[0];
                          // }
                          // // _editProfileBloc.add(EditProfileGetContactTypeEvent(
                          // //     isType: false, type: initialValue.value));
                          // selectedContactType = initialValue;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ContactTypeDropDown(
                              hintText: 'Chọn loại liên hệ',
                              onChanged: (value) {
                                if (value.type != 'BankAccount') {
                                  _titleController.text = value.label ?? '';
                                } else {
                                  _titleController.text = '';
                                }
                                selectedContactType = value;
                                _editProfileBloc.add(
                                    EditProfileGetContactTypeEvent(
                                        isType: false, type: value.type));
                                hasChangeMainContactType = true;
                                if (value.type != 'BankAccount') {
                                  selectedBankType = null;
                                }
                              },
                              controller: TextEditingController(),
                              items: state.contactDefaultTypeResponse,
                              initialValue: null,
                            ),
                          );
                        } else {
                          return PrimaryShimmer(
                              child: Container(
                            color: AppColor.gray09,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: PrimaryDropDownFormField(
                              items: const [],
                              fillColor: AppColor.gray09,
                              initialValue: null,
                              controller: TextEditingController(),
                            ),
                          ));
                        }
                      }),
              const SizedBox(height: 8),

              // bank
              BlocBuilder<EditProfileBloc, EditProfileState>(
                buildWhen: (previous, current) =>
                    current is EditProfileGetAllBankTypeSuccessState,
                builder: (context, state) {
                  if (state is EditProfileGetAllBankTypeSuccessState &&
                      state.isBankType) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ContactTypeDropDown(
                        // if this is rebuilt, an uniqueKey must be provided -> to let engine know to render new widget (...)
                        // key: UniqueKey(),
                        hintText: 'Tên ngân hàng',
                        onChanged: (value) {
                          // _titleController.text = value.value ?? '';
                          selectedBankType = value;
                        },
                        controller: TextEditingController(),
                        items: state.contactDefaultTypeResponse,
                        initialValue: selectedBankType,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),

              // only init when first edit build
              if (!widget.isAddNew && selectedBankType != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ContactTypeDropDown(
                    hintText: 'Chọn loại ngân hàng',
                    readOnly: true,
                    onChanged: (value) {},
                    controller: TextEditingController(),
                    items: [selectedBankType!],
                    initialValue: selectedBankType,
                  ),
                ),

              const SizedBox(height: 16),
              const Divider(
                height: 1,
                thickness: 1,
                color: AppColor.gray09,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SecondaryTextField(
                      controller: _titleController,
                      label: 'Nhập tiêu đề',
                      isRequired: true,
                      validator: Utils.textEmptyValidator,
                      textInputAction: TextInputAction.next,
                      formKey: _titleFormKey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SecondaryTextField(
                      isRequired: true,
                      controller: _detailController,
                      label: 'Dữ liệu',
                      prefixIcon: const Icon(Icons.link),
                      validator: Utils.textEmptyValidator,
                      maxLines: 3,
                      textInputAction: TextInputAction.done,
                      formKey: _detailFormKey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PrimaryCheckBox(
                        onTap: () {
                          contactUseAsBase = !contactUseAsBase;
                        },
                        value: contactUseAsBase),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocListener<EditProfileBloc, EditProfileState>(
                      listener: (context, state) {
                        if (state is EditProfileLoadingState) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => getLoadingDialog());
                        }
                        if (state is EditProfileUpdateContactInfoFailedState) {
                          Navigator.pop(context);
                        }
                        if (state is EditProfileUpdateContactInfoSuccessState) {
                          Navigator.pop(context);
                          Navigator.pop(
                              context, _editProfileBloc.hasChangedContactInfo);
                        }

                        // avoid unexpected rebuild
                        if (state is EditProfileGetContactTypeSuccessState) {}
                      },
                      child: ActionButton(
                        saveText: widget.contactInfoResponse != null
                            ? 'Cập nhật'
                            : 'Thêm mới',
                        onSave: () {
                          bool c1 = _titleFormKey.currentState!.validate();
                          bool c2 = _detailFormKey.currentState!.validate();
                          if (c1 && c2) {
                            _editProfileBloc.add(
                              EditProfileAddContactInfoEvent(
                                contactInfoResponse: ContactInfoResponse(
                                  id: widget.contactInfoResponse?.id,
                                  contactBaseId: widget.contactBaseId,
                                  title:
                                      selectedContactType.type == 'BankAccount'
                                          ? null
                                          : _titleController.text.trim(),
                                  value: selectedContactType.type ==
                                          'BankAccount'
                                      ? ('${selectedBankType?.label}\$${_titleController.text.trim()}\$${_detailController.text.trim()}')
                                      : _detailController.text.trim(),
                                  type: selectedContactType.type,
                                  iconUrl:
                                      selectedContactType.type == 'BankAccount'
                                          ? selectedBankType?.iconUrl
                                          : selectedContactType.iconUrl,
                                  hidden: contactHidden,
                                  useAsBase: contactUseAsBase,
                                ),
                              ),
                            );
                          }
                        },
                        onCancel: () {
                          Navigator.pop(
                              context, _editProfileBloc.hasChangedContactInfo);
                        },
                        onDelete: widget.isAddNew
                            ? null
                            : () {
                                _editProfileBloc.add(
                                    EditProfileDeleteContactInfoEvent(
                                        contactId:
                                            widget.contactInfoResponse?.id ??
                                                '',
                                        contactBaseId: widget.contactBaseId));
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
