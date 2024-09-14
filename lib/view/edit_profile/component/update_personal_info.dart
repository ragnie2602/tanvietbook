import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/constants.dart';
import '../../../data/repository/remote/repository.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../di/di.dart';
import '../../../model/member/member_detail_info.dart';
import '../../../shared/bloc/address/address_bloc.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/button/action_button.dart';
import '../../../shared/widgets/dialog_helper.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../../../shared/widgets/secondary_text_field.dart';
import '../bloc3/edit_profile_bloc.dart';

// ignore: must_be_immutable
class EditPersonalInfo extends StatefulWidget {
  MemberInfo memberDetailInfo;

  EditPersonalInfo({
    required this.memberDetailInfo,
    Key? key,
  }) : super(key: key);

  @override
  State<EditPersonalInfo> createState() => _EditPersonalInfoState();
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  final TextEditingController dobController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController provinceController = TextEditingController();

  final TextEditingController districtController = TextEditingController();

  final TextEditingController wardController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController positionController = TextEditingController();

  final TextEditingController companyController = TextEditingController();

  final AddressBloc _addressBloc =
      AddressBloc(utilityRepository: getIt.get<UtilityRepository>());

  final EditProfileBloc editProfileBloc = EditProfileBloc();

  final MemberInfo memberInfoEdited = MemberInfo();

  bool dobHidden = false;
  bool addressHidden = false;
  bool genderHidden = false;

  @override
  void initState() {
    super.initState();
    // init controller
    dobController.text = Utils.formatDate(widget.memberDetailInfo.dob ?? '');
    genderController.text = widget.memberDetailInfo.gender ?? 'Nam';
    provinceController.text = widget.memberDetailInfo.city ?? '';
    districtController.text = widget.memberDetailInfo.district ?? '';
    wardController.text = widget.memberDetailInfo.commune ?? '';
    addressController.text = widget.memberDetailInfo.address ?? '';
    // positionController.text = memberDetailInfo.job ?? '';
    // companyController.text = memberDetailInfo.company ?? '';
    dobHidden = widget.memberDetailInfo.dobHidden ?? false;
    addressHidden = widget.memberDetailInfo.addressHidden ?? false;
    genderHidden = widget.memberDetailInfo.genderHidden ?? false;

    _addressBloc.add(const AddressGetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _addressBloc,
        ),
        BlocProvider(
          create: (context) => editProfileBloc,
        ),
      ],
      child: BlocListener<AddressBloc, AddressState>(
        listener: (context, state) {
          _addressBloc.add(
            AddressGetProvinceListEvent(
                initialProvince: provinceController.text,
                initialDistrict: districtController.text),
          );
          if (state is AddressSelectProvince) {
            provinceController.text = state.provinceName;
            districtController.text = '';
            wardController.text = '';
            _addressBloc.add(AddressGetDistrictListEvent());
          }
          if (state is AddressSelectDistrict) {
            districtController.text = state.districtName;
            wardController.text = '';
            _addressBloc.add(AddressGetWardListEvent());
          }
          if (state is AddressSelectWard) {
            wardController.text = state.wardName;
          }
        },
        child: PopScope(
          canPop: false,
          onPopInvoked: (value) async {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            // });
          },
          child: Scaffold(
            backgroundColor: AppColor.primaryBackgroundColor,
            appBar: PrimaryAppBar(
              title: 'Chỉnh sửa thông tin cá nhân',
              onBackPressed: () {
                Navigator.pop(context, editProfileBloc.hasChangedPersonalInfo);
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
                        const Row(
                          children: [
                            Icon(
                              Icons.badge_outlined,
                              color: AppColor.secondaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Thông tin cá nhân',
                              style: AppTextTheme.textPrimaryBoldMedium,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SecondaryTextField(
                          controller: dobController,
                          inputType: AppInputType.datePicker,
                          label: 'Ngày sinh',
                          suffixIcon: Icons.calendar_month,
                          keyboardType: TextInputType.datetime,
                          context: context,
                          isShowSwitch: true,
                          isSwitchChecked: !dobHidden,
                          onSwitchChanged: (value) {
                            dobHidden = !value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SecondaryTextField(
                          controller: genderController,
                          inputType: AppInputType.dropDown,
                          label: 'Giới tính',
                          // suffixIcon: Icon(Icons.arrow_drop_down_circle_outlined),
                          context: context,
                          readOnly: true,
                          data: const ['Nam', 'Nữ', 'Khác'],

                          hintText: 'Chọn giới tính',
                          isShowSwitch: true,
                          isSwitchChecked: !genderHidden,
                          onSwitchChanged: (value) {
                            genderHidden = !value;
                          },
                          onDropdownValueChanged: (value, index) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SecondaryTextField(
                            isRequired: false,
                            // validator: _provinceValidator,
                            // formKey: _provinceFormKey,
                            label: "Tỉnh/Thành phố",
                            controller: provinceController,
                            hintText: 'Chọn Tỉnh thành',
                            readOnly: true,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => getAddressDialog(
                                    data: _addressBloc.provinceList),
                              ).then(
                                (provinceSelected) {
                                  _addressBloc.add(AddressHandleSelectedEvent(
                                      selected: provinceSelected));
                                },
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        SecondaryTextField(
                          // validator: _districtValidator,
                          // formKey: _districtFormKey,
                          label: "Quận/Huyện",
                          controller: districtController,
                          hintText: 'Chọn Quận/Huyện',
                          readOnly: true,
                          onTap: () {
                            if (_addressBloc.currentProvinceSelectedId != '') {
                              showDialog(
                                context: context,
                                builder: (context) => getAddressDialog(
                                    data: _addressBloc.districtList),
                              ).then(
                                (districtSelected) {
                                  _addressBloc.add(AddressHandleSelectedEvent(
                                      selected: districtSelected));
                                },
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SecondaryTextField(
                          // formKey: _communeFormKey,
                          label: "Xã/Phường",
                          hintText: 'Chọn Xã/Phường',
                          controller: wardController,
                          readOnly: true,
                          onTap: () {
                            if (_addressBloc.currentDistrictSelectedId != "") {
                              showDialog(
                                context: context,
                                builder: (context) => getAddressDialog(
                                    data: _addressBloc.wardsList),
                              ).then(
                                (wardSelected) {
                                  _addressBloc.add(AddressHandleSelectedEvent(
                                      selected: wardSelected));
                                },
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SecondaryTextField(
                          controller: addressController,
                          label: 'Địa chỉ chi tiết',
                          hintText: 'Nhập địa chỉ chi tiết',
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          isShowSwitch: true,
                          isSwitchChecked: !addressHidden,
                          onSwitchChanged: (value) {
                            addressHidden = !value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // SecondaryTextField(
                        //   controller: positionController,
                        //   label: 'Vị trí (Chức vụ)',
                        //   hintText: 'Nhập vị trí',
                        //   textInputAction: TextInputAction.next,
                        //   textCapitalization: TextCapitalization.sentences,
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // SecondaryTextField(
                        //   controller: companyController,
                        //   label: 'Công ty (Tổ chức)',
                        //   hintText: 'Nhập tên Công ty (Tổ chức)',
                        //   textInputAction: TextInputAction.next,
                        //   textCapitalization: TextCapitalization.sentences,
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        BlocListener<EditProfileBloc, EditProfileState>(
                          listener: (context, state) {
                            if (state is EditProfileLoadingState) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) => getLoadingDialog());
                            }
                            if (state
                                is EditProfileUpdatePersonalInfoFailedState) {
                              Navigator.pop(context);
                            }
                            if (state
                                is EditProfileUpdatePersonalInfoSuccessState) {
                              Navigator.pop(context);
                              Navigator.pop(context,
                                  editProfileBloc.hasChangedPersonalInfo);

                              widget.memberDetailInfo =
                                  widget.memberDetailInfo.copyWith(
                                dob: Utils.toStringIsoDate(
                                    dobController.text.trim()),
                                gender: genderController.text.trim(),
                                address: addressController.text.trim(),
                                commune: wardController.text.trim(),
                                district: districtController.text.trim(),
                                city: provinceController.text.trim(),
                              );
                            }
                          },
                          child: ActionButton(onSave: () {
                            ViewUtils.unFocusView();
                            editProfileBloc.add(
                              EditProfileUpdatePersonalInfoEvent(
                                memberInfo: MemberInfo(
                                  dob: widget.memberDetailInfo.dob !=
                                          Utils.toStringIsoDate(
                                              dobController.text.trim())
                                      ? Utils.toStringIsoDate(
                                          dobController.text.trim())
                                      : null,
                                  dobHidden: dobHidden,
                                  gender: widget.memberDetailInfo.gender !=
                                          genderController.text.trim()
                                      ? genderController.text.trim()
                                      : null,
                                  genderHidden: genderHidden,
                                  address: widget.memberDetailInfo.address !=
                                          addressController.text.trim()
                                      ? addressController.text.trim()
                                      : null,
                                  addressHidden: addressHidden,
                                  commune: widget.memberDetailInfo.commune !=
                                          wardController.text.trim()
                                      ? wardController.text.trim()
                                      : null,
                                  district: widget.memberDetailInfo.district !=
                                          districtController.text.trim()
                                      ? districtController.text.trim()
                                      : null,
                                  city: widget.memberDetailInfo.city !=
                                          provinceController.text.trim()
                                      ? provinceController.text.trim()
                                      : null,
                                  // job: memberDetailInfo.job !=
                                  //         positionController.text.trim()
                                  //     ? positionController.text.trim()
                                  //     : null,
                                  // company: memberDetailInfo.company !=
                                  //         companyController.text.trim()
                                  //     ? companyController.text.trim()
                                  //     : null,
                                ),
                              ),
                            );
                          }, onCancel: () {
                            Navigator.pop(context,
                                editProfileBloc.hasChangedPersonalInfo);
                          }),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
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
