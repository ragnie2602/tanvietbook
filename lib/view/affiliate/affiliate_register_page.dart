import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/config.dart';
import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../model/member/collaborator/collaborator_response.dart';
import '../../model/member/contact_default_type_response.dart';
import '../../model/member/member_detail_info.dart';
import '../../shared/bloc/get_image/get_image_bloc.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/icon_assets.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_divider.dart';
import '../../shared/widgets/secondary_text_field.dart';
import '../agency_page/cubit/agency_cubit.dart';
import '../base/base_page_sate.dart';
import '../edit_profile/component/contact_type_drop_down.dart';
import '../user_profile/bloc/user_info_bloc.dart';
import 'cubit/affiliate_cubit.dart';

class AffiliateRegisterPage extends StatefulWidget {
  const AffiliateRegisterPage({super.key});

  @override
  State<AffiliateRegisterPage> createState() => _AffiliateRegisterPageState();
}

class _AffiliateRegisterPageState
    extends BasePageState<AffiliateRegisterPage, AffiliateCubit> {
  @override
  bool get useBlocProviderValue => true;

  @override
  PreferredSizeWidget? get appBar => const PrimaryAppBar(
        title: 'Đăng kí Cộng tác viên',
      );

  @override
  Color? get backgroundColor => AppColor.white;

  @override
  bool get isUseLoading => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = (context.arguments as AffiliateRegisterPageArgs);
    setCubit = args.affiliateCubit;
    memberInfo = context.read<UserInfoBloc>().memberInfo!;

    if (args.collaboratorResponse != null) {
      collaboratorInfo = args.collaboratorResponse!.copyWith();
      usernameController.text = collaboratorInfo.username ?? '';
      fullnameController.text = (collaboratorInfo.fullname ?? '').toUpperCase();
      refferalNameController.text = collaboratorInfo.referralCode ?? '';
      dobController.text = Utils.formatDate(collaboratorInfo.dateOfBirth ?? '');
      emailController.text = collaboratorInfo.email ?? '';
      permanentAddressController.text = collaboratorInfo.permanentAddress ?? '';
      contactAddressController.text = collaboratorInfo.currentAddress ?? '';
      taxController.text = collaboratorInfo.taxCode ?? '';
      identityNumberController.text =
          collaboratorInfo.citizenIdentityCard ?? '';
      idCardIssuedDateController.text =
          Utils.formatDate(collaboratorInfo.dateOfIssue ?? '');
      idCardIssuedAddressController.text = collaboratorInfo.placeOfIssue ?? '';
      phoneNumberController.text = collaboratorInfo.mobile ?? '';

      bankAccountOwnerController.text = collaboratorInfo.accountName ?? '';
      bankAccountNumberController.text = collaboratorInfo.accountNumber ?? '';
      //       final taxController = TextEditingController();
      // final identityNumberController = TextEditingController();
      // final idCardIssuedDateController = TextEditingController();
      // final idCardIssuedAddressController = TextEditingController();
      // final bankAccountOwnerController = TextEditingController();
      // final bankAccountNumberController = TextEditingController();
    } else {
      collaboratorInfo = CollaboratorResponse();
      usernameController.text = args.ssoCubit.user?.login ?? '';
      fullnameController.text =
          (args.ssoCubit.user?.firstName ?? '').toUpperCase();
      refferalNameController.text = args.ssoCubit.user?.referralCode ?? '';
      phoneNumberController.text = args.ssoCubit.user?.phoneNumber ?? '';
      dobController.text = Utils.formatDate(memberInfo.dob ?? '');
      emailController.text = args.ssoCubit.user?.email ?? '';
      idCardIssuedAddressController.text = 'Cục CS QL HC về TTXH';
      permanentAddressController.text = Utils.formatAddress(memberInfo.address,
          memberInfo.commune, memberInfo.district, memberInfo.city);
      contactAddressController.text = Utils.formatAddress(memberInfo.address,
          memberInfo.commune, memberInfo.district, memberInfo.city);
    }
  }

  late final AffiliateRegisterPageArgs args;
  late final MemberInfo memberInfo;

  final usernameController = TextEditingController();
  final fullnameController = TextEditingController();
  final refferalNameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final permanentAddressController = TextEditingController();
  final contactAddressController = TextEditingController();
  final taxController = TextEditingController();
  final identityNumberController = TextEditingController();
  final idCardIssuedDateController = TextEditingController();
  final idCardIssuedAddressController = TextEditingController();
  final bankAccountOwnerController = TextEditingController();
  final bankAccountNumberController = TextEditingController();

  final usernameFormKey = GlobalKey<FormState>();
  final fullnameFormKey = GlobalKey<FormState>();
  final refferalNameFormKey = GlobalKey<FormState>();
  final dobFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final phoneNumberFormKey = GlobalKey<FormState>();
  final permanentAddressFormKey = GlobalKey<FormState>();
  final contactAddressFormKey = GlobalKey<FormState>();
  final taxFormKey = GlobalKey<FormState>();
  final identityNumberFormKey = GlobalKey<FormState>();
  final idCardIssuedDateFormKey = GlobalKey<FormState>();
  final idCardIssuedAddressFormKey = GlobalKey<FormState>();
  final bankNameFormKey = GlobalKey<FormState>();
  final bankAccountOwnerFormKey = GlobalKey<FormState>();
  final bankAccountNumberFormKey = GlobalKey<FormState>();

  final bankItems = bankOptions
      .map((e) => ContactDefaultTypeResponse(
            type: (e['value'] as Map)['type'],
            label: e['label'].toString(),
            value: e['label'].toString(),
            iconUrl: (e['value'] as Map)['iconUrl'],
          ))
      .toList();
  bool isAgreeWithTerm = true;

  final _getImageBloc = GetImageBloc();
  late final CollaboratorResponse collaboratorInfo;

  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider(
      create: (context) => _getImageBloc,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thông tin cá nhân',
                  style: AppTextTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                SecondaryTextField(
                  controller: usernameController,
                  formKey: usernameFormKey,
                  label: 'Tên tài khoản',
                  readOnly: true,
                  disable: true,
                ),
                const SizedBox(height: 16),
                SecondaryTextField(
                  controller: fullnameController,
                  formKey: fullnameFormKey,
                  label: 'Họ và tên',
                  isRequired: true,
                  validator: Utils.textEmptyValidator,
                ),
                const SizedBox(height: 16),
                SecondaryTextField(
                  controller: refferalNameController,
                  formKey: refferalNameFormKey,
                  label: 'Mã giới thiệu',
                  // readOnly: true,
                  isRequired: true,
                  validator: Utils.textEmptyValidator,
                  // disable: true,
                ),
                const SizedBox(height: 16),
                SecondaryTextField(
                  controller: dobController,
                  formKey: dobFormKey,
                  validator: Utils.textEmptyValidator,
                  label: 'Ngày sinh',
                  inputType: AppInputType.datePicker,
                  isRequired: true,
                  context: context,
                ),
                const SizedBox(height: 16),
                SecondaryTextField(
                  controller: emailController,
                  formKey: emailFormKey,
                  label: 'Email',
                  isRequired: true,
                  validator: Utils.emailValidator,
                ),
                const SizedBox(height: 16),
                SecondaryTextField(
                  controller: phoneNumberController,
                  formKey: phoneNumberFormKey,
                  label: 'Số điện thoại',
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                  validator: Utils.textEmptyValidator,
                ),
                const SizedBox(height: 16),
                SecondaryTextField(
                  controller: permanentAddressController,
                  formKey: permanentAddressFormKey,
                  label: 'Địa chỉ thường trú',
                  isRequired: true,
                  validator: Utils.textEmptyValidator,
                ),
                const SizedBox(height: 16),
                SecondaryTextField(
                  controller: contactAddressController,
                  formKey: contactAddressFormKey,
                  label: 'Địa chỉ liên hệ',
                  isRequired: true,
                  validator: Utils.textEmptyValidator,
                ),
                const SizedBox(height: 16),
                // PrimaryContainer(
                //   backgroundColor: AppColor.primaryBackgroundContainer,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Thông tin nâng cao',
                //         style: AppTextTheme.titleMedium,
                //       ),
                //       const SizedBox(height: 20),
                //       SecondaryTextField(
                //         controller: taxController,
                //         formKey: taxFormKey,
                //         label: 'Mã số thuế',
                //         isRequired: true,
                //         validator: Utils.textEmptyValidator,
                //       ),
                //       const SizedBox(height: 16),
                //       SecondaryTextField(
                //         controller: identityNumberController,
                //         formKey: identityNumberFormKey,
                //         label: 'Số CCCD/ CMT',
                //         isRequired: true,
                //         validator: Utils.textEmptyValidator,
                //       ),
                //       const SizedBox(height: 16),
                //       SecondaryTextField(
                //         controller: idCardIssuedDateController,
                //         formKey: idCardIssuedDateFormKey,
                //         label: 'Ngày cấp',
                //         isRequired: true,
                //         validator: Utils.textEmptyValidator,
                //         inputType: AppInputType.datePicker,
                //         context: context,
                //       ),
                //       const SizedBox(height: 16),
                //       SecondaryTextField(
                //         key: UniqueKey(),
                //         controller: idCardIssuedAddressController,
                //         // formKey: idCardIssuedAddressFormKey,
                //         inputType: AppInputType.dropDown,
                //         label: 'Nơi cấp',
                //         // suffixIcon: Icon(Icons.arrow_drop_down_circle_outlined),
                //         context: context,
                //         readOnly: true,
                //         data: const [
                //           'Cục CS QL HC về TTXH',
                //           'Cục  CS DKQL cứ trú DLQG về dân cư',
                //           'Khác',
                //         ],
                //         onDropdownValueChanged: (value, index) {
                //           collaboratorInfo.placeOfIssue = value;
                //         },
                //         hintText: 'Chọn Nơi cấp',
                //         isRequired: true,
                //       ),
                //       const SizedBox(height: 16),
                //       const Text(
                //         'Ảnh chụp CCCD/CMT 2 mặt',
                //         style: AppTextTheme.titleMedium,
                //       ),
                //       const SizedBox(height: 16),
                //       PrimaryReorderGridImage(
                //         initialData: (collaboratorInfo.image1 != null &&
                //                 collaboratorInfo.image2 != null)
                //             ? [
                //                 collaboratorInfo.image1!,
                //                 collaboratorInfo.image2!
                //               ]
                //             : [],
                //         getImageBloc: _getImageBloc,
                //         maxQuantity: 2,
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 16),
                const Text(
                  'Tên ngân hàng',
                  style: AppTextTheme.bodyStrong,
                ),
                const SizedBox(height: 10),
                ContactTypeDropDown(
                  hintText: 'Chọn loại ngân hàng',
                  onChanged: (value) {
                    collaboratorInfo.bankName = value.value;

                    // selectedContactType = value;
                    // _editProfileBloc.add(
                    //     EditProfileGetContactTypeEvent(
                    //         isType: false, type: value.type));
                    // hasChangeMainContactType = true;
                    // if (value.type != 'BankAccount') {
                    //   selectedBankType = null;
                    // }
                  },
                  controller: TextEditingController(),
                  items: bankItems,
                  initialValue: bankItems.firstWhereOrNull(
                      (element) => element.label == collaboratorInfo.bankName),
                ),
                const SizedBox(height: 16),
                SecondaryTextField(
                  controller: bankAccountOwnerController,
                  formKey: bankAccountOwnerFormKey,
                  label: 'Chủ tài khoản',
                  isRequired: true,
                  validator: Utils.textEmptyValidator,
                ),
                const SizedBox(height: 16),
                SecondaryTextField(
                  controller: bankAccountNumberController,
                  formKey: bankAccountNumberFormKey,
                  label: 'Số tài khoản',
                  isRequired: true,
                  validator: Utils.textEmptyValidator,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    StatefulBuilder(
                      builder: (context, innerSetState) {
                        return Checkbox(
                            value: isAgreeWithTerm,
                            onChanged: (value) {
                              innerSetState(() => isAgreeWithTerm = value!);
                            });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              text:
                                  'Tôi đồng ý với các điều khoản và điều kiện của ',
                              style: AppTextTheme.bodyRegular),
                          TextSpan(
                            text: 'hợp đồng CTV',
                            style: AppTextTheme.bodyStrong
                                .copyWith(color: AppColor.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Utils.launchUri(
                                    context
                                            .read<AgencyCubit>()
                                            .agencyDetail
                                            .pdf ??
                                        '',
                                    UriType.website);
                              },
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            )),
          ),
          MultiBlocListener(
            listeners: [
              BlocListener<AffiliateCubit, AffiliateState>(
                listener: (context, state) {
                  state.maybeWhen(
                    checkCollaboratorExistSuccess: (isExisted) {
                      if (isExisted) {
                        hideLoading();
                        _onCheckRefferalCodeExisted();
                      } else {
                        hideLoading();
                        toastWarning(
                            'Mã giới thiệu không tồn tại trong hệ thống ${args.agencyCubit.agencyDetail.shortName}');
                      }
                    },
                    regsiterCollaboratorSuccess: (success) {
                      toastSuccess('Yêu cầu đăng ký CTV thành công');
                      hideLoading();
                      context.read<AffiliateCubit>()
                        ..resetState()
                        ..getAffiliateRegisterInfo();
                      Navigator.pop(context, true);
                    },
                    regsiterCollaboratorFailed: () {
                      hideLoading();
                      toastWarning('Yêu cầu đăng ký CTV thất bại');
                    },
                    orElse: () {},
                  );
                },
              ),
              // BlocListener<GetImageBloc, GetImageState>(
              //   listener: (context, state) {
              //     if (state is GetImageGetMultiImageUrlSuccessState) {

              //     }
              //     if (state is GetImageGetMultiImageUrlErrorState) {
              //       hideLoading();
              //       toastWarning('Tải ảnh lên thất bại');
              //     }
              //   },
              // ),
            ],
            child: Column(
              children: [
                const PrimaryDivider(),
                PrimaryButton(
                  context: context,
                  onPressed: _onRegisterPressed,
                  label: 'Đăng ký',
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _onRegisterPressed() {
    cubit.resetState();
    showLoading();
    cubit.checkCollaboratorExist(refferalNameController.text.trim());
  }

  void _onCheckRefferalCodeExisted() {
    // if (!usernameFormKey.validateAndScroll(context)) return;
    if (!usernameFormKey.validateAndScroll()) {
      return;
    }
    if (!fullnameFormKey.validateAndScroll()) {
      return;
    }
    if (!refferalNameFormKey.validateAndScroll()) {
      return;
    }
    if (!dobFormKey.validateAndScroll()) {
      return;
    }
    if (!emailFormKey.validateAndScroll()) {
      return;
    }
    if (!phoneNumberFormKey.validateAndScroll()) {
      return;
    }
    if (!permanentAddressFormKey.validateAndScroll()) {
      return;
    }
    if (!contactAddressFormKey.validateAndScroll()) {
      return;
    }
    // if (!taxFormKey.validateAndScroll()) {
    //   return;
    // }
    // if (!identityNumberFormKey.validateAndScroll()) {
    //   return;
    // }
    // if (!idCardIssuedDateFormKey.validateAndScroll()) {
    //   return;
    // }
    // if (_getImageBloc.imageData.last.type == ImageDataType.addNew ||
    //     _getImageBloc.imageData.length == 1) {
    //   toastWarning('Bạn chưa cập nhật ảnh CCCD/CMT 2 mặt');
    //   return;
    // }

    if (collaboratorInfo.bankName == null ||
        collaboratorInfo.bankName!.isEmpty) {
      toastWarning('Bạn chưa chọn thông tin ngân hàng');
      return;
    }
    if (!bankAccountOwnerFormKey.validateAndScroll()) {
      return;
    }
    if (!bankAccountNumberFormKey.validateAndScroll()) {
      return;
    }
    if (!isAgreeWithTerm) {
      toastWarning('Bạn chưa đồng ý với điều khoản và điều kiện hợp đồng CTV');
      return;
    }
    showLoading();
    collaboratorInfo
      ..accountName = memberInfo.login
      ..accountNumber = bankAccountNumberController.text.trim()
      ..agency = AppConfig.agencyName
      ..citizenIdentityCard = identityNumberController.text.trim()
      ..currentAddress = contactAddressController.text.trim()
      ..dateOfBirth = Utils.toStringIsoDate(dobController.text.trim())
      ..dateOfIssue = Utils.toStringIsoDate(DateTime.now().toIso8601String())
      ..email = emailController.text.trim()
      ..fullname = fullnameController.text.trim()
      ..mobile = phoneNumberController.text.trim()
      ..permanentAddress = permanentAddressController.text.trim()
      ..placeOfIssue = idCardIssuedAddressController.text.trim()
      ..referralCode = refferalNameController.text.trim()
      // ..taxCode = taxController.text.trim()
      // ..image1 = state.imageData.first.data
      // ..image2 = state.imageData.last.data
      ..userId = memberInfo.id
      ..username = memberInfo.login;
    cubit.regsiterCollaborator(collaboratorInfo);
  }
}
