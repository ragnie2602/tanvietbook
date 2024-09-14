import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../../domain/entity/user_address/user_address.dart';
import '../../shared/bloc/address/address_bloc.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/dialog_helper.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_switch.dart';
import '../../shared/widgets/secondary_text_field.dart';
import '../base/base_page_sate.dart';
import 'cubit/agency_cubit.dart';

class AgencyAddUserAddressPage extends StatefulWidget {
  const AgencyAddUserAddressPage({super.key});

  @override
  State<AgencyAddUserAddressPage> createState() => _AgencyAddUserAddressPageState();
}

class _AgencyAddUserAddressPageState extends BasePageState<AgencyAddUserAddressPage, AgencyCubit> {
  @override
  PreferredSizeWidget? get appBar => const PrimaryAppBar(
        title: 'Thông tin nhận hàng',
      );

  @override
  Color? get backgroundColor => AppColor.white;

  @override
  bool get isUseLoading => true;

  @override
  bool get useBlocProviderValue => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AgencyAddUserAddressPageAgrs args = context.arguments as AgencyAddUserAddressPageAgrs;

    setCubit = args.agencyCubit;
    if (args.userAddress != null) {
      isUpdate = true;
      userAddress = args.userAddress!.copyWith();
      nameController.text = args.userAddress?.name ?? '';
      phoneController.text = args.userAddress?.phoneNumber ?? '';
      emailController.text = args.userAddress?.email ?? '';
      provinceController.text = args.userAddress?.province ?? '';
      districtController.text = args.userAddress?.district ?? '';
      wardController.text = args.userAddress?.commune ?? '';
      addressController.text = args.userAddress?.address ?? '';
    } else {
      isUpdate = false;
      userAddress = UserAddress(
        status: AddressStatus.normal,
      );
    }
    _addressBloc = AddressBloc(utilityRepository: getIt.get())..add(const AddressGetAllEvent());
    // ..add(
    //   AddressGetProvinceListEvent(
    //       initialProvince: provinceController.text,
    //       initialDistrict: districtController.text),
    // );
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController wardController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final nameFormKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  final provinceFormKey = GlobalKey<FormState>();
  final districtFormKey = GlobalKey<FormState>();
  final wardFormKey = GlobalKey<FormState>();
  final addressFormKey = GlobalKey<FormState>();

  late final AddressBloc _addressBloc;
  late final UserAddress userAddress;
  late final bool isUpdate;

  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider(
      create: (context) => _addressBloc,
      lazy: false,
      child: SingleChildScrollView(
        child: MultiBlocListener(
          listeners: [
            BlocListener<AddressBloc, AddressState>(
              listener: (context, state) {
                if (state is AddressGetAllSuccessState) {
                  _addressBloc.add(
                    AddressGetProvinceListEvent(
                        initialProvince: provinceController.text, initialDistrict: districtController.text),
                  );
                }
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
            ),
            BlocListener<AgencyCubit, AgencyState>(
              listener: (context, state) {
                state.maybeWhen(
                    orElse: () {},
                    addUserAddressSuccess: (userAddressAdded) {
                      toastSuccess(AlertText.updateSuccess);
                      hideLoading();
                      context.pop(userAddressAdded);
                      cubit.getAllAddressByUser();
                    },
                    addUserAddressFailed: () {
                      toastWarning(AlertText.updateFailed);
                      hideLoading();
                    },
                    deleteUserAddressSuccess: () {
                      toastSuccess(AlertText.deleteSuccess);
                      hideLoading();
                      context.pop(userAddress);
                      cubit.getAllAddressByUser();
                    },
                    deleteUserAddressFailed: () {
                      hideLoading();
                      toastWarning(AlertText.deleteFailed);
                    });
              },
            ),
          ],
          child: Column(
            children: [
              const SizedBox(height: 20),
              SecondaryTextField(
                isRequired: true,
                controller: nameController,
                label: 'Họ tên',
                hintText: 'Nhập họ tên',
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                formKey: nameFormKey,
                validator: Utils.textEmptyValidator,
              ),
              const SizedBox(height: 20),
              SecondaryTextField(
                isRequired: true,
                controller: phoneController,
                label: 'Số điện thoại',
                hintText: 'Nhập số điện thoại',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                formKey: phoneFormKey,
                validator: Utils.textEmptyValidator,
              ),
              const SizedBox(height: 20),
              SecondaryTextField(
                controller: emailController,
                label: 'Email',
                hintText: 'Nhập email',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              SecondaryTextField(
                isRequired: false,
                label: "Tỉnh/Thành phố",
                controller: provinceController,
                hintText: 'Chọn Tỉnh thành',
                readOnly: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => getAddressDialog(data: _addressBloc.provinceList),
                  ).then(
                    (provinceSelected) {
                      _addressBloc.add(AddressHandleSelectedEvent(selected: provinceSelected));
                    },
                  );
                },
                formKey: provinceFormKey,
                validator: Utils.textEmptyValidator,
              ),
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
                  log('_addressBloc.currentProvinceSelectedId: ${_addressBloc.currentProvinceSelectedId}');
                  if (_addressBloc.currentProvinceSelectedId != '') {
                    showDialog(
                      context: context,
                      builder: (context) => getAddressDialog(data: _addressBloc.districtList),
                    ).then(
                      (districtSelected) {
                        _addressBloc.add(AddressHandleSelectedEvent(selected: districtSelected));
                      },
                    );
                  }
                },
                formKey: districtFormKey,
                validator: Utils.textEmptyValidator,
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
                  if (_addressBloc.currentDistrictSelectedId != '') {
                    showDialog(
                      context: context,
                      builder: (context) => getAddressDialog(data: _addressBloc.wardsList),
                    ).then(
                      (wardSelected) {
                        _addressBloc.add(AddressHandleSelectedEvent(selected: wardSelected));
                      },
                    );
                  }
                },
                formKey: wardFormKey,
                validator: Utils.textEmptyValidator,
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
                // isSwitchChecked: !addressHidden,
                onSwitchChanged: (value) {
                  // addressHidden = !value;
                },
                formKey: addressFormKey,
                validator: Utils.textEmptyValidator,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    'Đặt làm địa chỉ mặc định',
                    style: AppTextTheme.bodyMedium,
                  ),
                  const Spacer(),
                  PrimarySwitch(
                    initialValue: userAddress.status == AddressStatus.main,
                    onToggle: (value) {},
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryButton(
                    context: context,
                    onPressed: _onDeletePressed,
                    label: 'Xoá địa chỉ',
                    backgroundColor: AppColor.red,
                  ),
                  const SizedBox(width: 10),
                  PrimaryButton(
                    context: context,
                    onPressed: _onSavePressed,
                    label: 'Lưu địa chỉ',
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  _onSavePressed() {
    final bool c1 = nameFormKey.currentState!.validate();
    final bool c2 = phoneFormKey.currentState!.validate();
    final bool c3 = addressFormKey.currentState!.validate();
    final bool c4 = wardFormKey.currentState!.validate();
    final bool c5 = districtFormKey.currentState!.validate();
    final bool c6 = provinceFormKey.currentState!.validate();

    if (!c1) {
      nameFormKey.currentContext!.ensureVisible();
      return;
    }
    if (!c2) {
      phoneFormKey.currentContext!.ensureVisible();
      return;
    }
    if (!c3) {
      provinceFormKey.currentContext!.ensureVisible();
      return;
    }
    if (!c4) {
      districtFormKey.currentContext!.ensureVisible();
      return;
    }
    if (!c5) {
      wardFormKey.currentContext!.ensureVisible();
      return;
    }
    if (!c6) {
      addressFormKey.currentContext!.ensureVisible();
      return;
    }

    showLoading();

    userAddress
      ..name = nameController.text.trim()
      ..phoneNumber = phoneController.text.trim()
      ..email = emailController.text.trim()
      ..address = addressController.text.trim()
      ..province = provinceController.text.trim()
      ..district = districtController.text.trim()
      ..commune = wardController.text.trim();
    if (isUpdate) {
      cubit.updateUserAddress(userAddress: userAddress);
    } else {
      cubit.addUserAddress(userAddress: userAddress);
    }
  }

  _onDeletePressed() {
    context.showAppDialog(
      getAlertDialog(
        context: context,
        title: 'Xác nhận',
        message: AlertText.alertDeleteText,
        onPositivePressed: () {
          showLoading();
          cubit.deleteUserAddress(userAddress: userAddress);
        },
      ),
    );
  }
}
