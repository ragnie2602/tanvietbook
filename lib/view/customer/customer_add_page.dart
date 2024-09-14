import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/config.dart';
import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/resources/resources.dart';
import '../../model/customer/customer_response.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_drop_down_form_field.dart';
import '../../shared/widgets/secondary_text_field.dart';
import '../../shared/widgets/text_field/primary_text_field.dart';
import 'cubit/customer_cubit.dart';

class CustomerAddPage extends StatefulWidget {
  const CustomerAddPage({super.key});

  @override
  State<CustomerAddPage> createState() => _CustomerAddPageState();
}

class _CustomerAddPageState extends State<CustomerAddPage> {
  late CustomerAddPageArgs args;

  final TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> addressKey = GlobalKey<FormState>();
  final TextEditingController birthController = TextEditingController();
  final GlobalKey<FormState> birthKey = GlobalKey<FormState>();
  final TextEditingController contactController = TextEditingController();
  final GlobalKey<FormState> contactKey = GlobalKey<FormState>();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
  final TextEditingController positionController = TextEditingController();
  final GlobalKey<FormState> positionKey = GlobalKey<FormState>();
  final TextEditingController provinceController = TextEditingController();
  final GlobalKey<FormState> provinceKey = GlobalKey<FormState>();
  final TextEditingController routeController = TextEditingController();
  final TextEditingController taxCodeController = TextEditingController();
  final TextEditingController typeCustomerController = TextEditingController();
  final TextEditingController wardController = TextEditingController();

  late final CustomerCubit cubit;
  bool _isInitialized = false;
  List<Map<String, String>> provinces = [];
  List<Map<String, String>> districts = [];
  List<Map<String, String>> wards = [];
  int type = 0; // 0 : personal; 1: enterprise
  String routeId = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    args = context.arguments as CustomerAddPageArgs;

    if (!_isInitialized) cubit = args.cubit;
    if (!_isInitialized) cubit.getAllProvince();

    if (!_isInitialized) addressController.text = args.customer?.address ?? '';
    if (!_isInitialized) contactController.text = args.customer?.contactPerson ?? '';
    if (!_isInitialized && args.customer?.dateOfBirth != null) {
      birthController.text = Utils.formatDate(args.customer!.dateOfBirth!);
    }
    if (!_isInitialized) districtController.text = args.customer?.district ?? '';
    if (!_isInitialized) emailController.text = args.customer?.email ?? '';
    if (args.customer?.foundation != null) birthController.text = Utils.formatDate(args.customer!.foundation!);
    if (!_isInitialized) nameController.text = args.customer?.fullname ?? '';
    if (!_isInitialized) phoneController.text = args.customer?.mobile ?? '';
    if (!_isInitialized) positionController.text = args.customer?.position ?? '';
    if (!_isInitialized) provinceController.text = args.customer?.province ?? '';
    if (!_isInitialized) routeId = args.customer?.routeId ?? '';
    if (!_isInitialized) taxCodeController.text = args.customer?.taxCode ?? '';
    if (!_isInitialized) typeCustomerController.text = 'Cá nhân';
    if (!_isInitialized) type = args.customer?.customerType ?? 0;
    if (!_isInitialized) wardController.text = args.customer?.commune ?? '';

    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimaryAppBar(
            canPop: true,
            centerTitle: true,
            leading: const BackButton(),
            style: AppTextTheme.textPrimaryBoldLarge.copyWith(fontSize: 16),
            title: 'Thông tin khách hàng'),
        body: BlocProvider.value(
            value: cubit,
            child: SingleChildScrollView(
                child: Column(children: [
              const SizedBox(height: 16),
              Container(
                  color: AppColor.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SecondaryTextField(
                        context: context,
                        controller: nameController,
                        formKey: nameKey,
                        isDense: true,
                        isRequired: true,
                        label: 'Tên khách hàng',
                        labelStyle: AppTextTheme.bodyRegular,
                        validator: Utils.textEmptyValidator),
                    const SizedBox(height: 8),
                    RichText(
                        text: const TextSpan(
                            text: '*',
                            style: TextStyle(color: AppColor.red, fontSize: 8),
                            children: [TextSpan(text: ' Loại khách hàng', style: AppTextTheme.bodySmall)])),
                    const SizedBox(height: 8),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.gray05, width: 0.5),
                            borderRadius: BorderRadius.circular(2)),
                        width: context.screenWidth,
                        child: PrimaryDropDownFormField(
                            controller: typeCustomerController,
                            decoration: const BoxDecoration(color: AppColor.white),
                            dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                            initialValue: type == 1 ? 'Doanh nghiệp' : 'Cá nhân',
                            items: const ['Cá nhân', 'Doanh nghiệp'],
                            onChanged: (p0, p1) {
                              setState(() {
                                type = p1;
                              });
                            })),
                    const SizedBox(height: 8),
                    if (type == 1)
                      SecondaryTextField(
                          context: context,
                          controller: taxCodeController,
                          isDense: true,
                          label: 'Mã số thuế',
                          labelStyle: AppTextTheme.bodyRegular,
                          validator: Utils.textEmptyValidator),
                    if (type == 1)
                      SecondaryTextField(
                          context: context,
                          controller: contactController,
                          formKey: contactKey,
                          isDense: true,
                          isRequired: true,
                          label: 'Người liên hệ',
                          labelStyle: AppTextTheme.bodyRegular,
                          validator: Utils.textEmptyValidator),
                    if (type == 1) const SizedBox(height: 8),
                    if (type == 1)
                      SecondaryTextField(
                          context: context,
                          controller: positionController,
                          formKey: positionKey,
                          isDense: true,
                          isRequired: true,
                          label: 'Chức vụ',
                          labelStyle: AppTextTheme.bodyRegular,
                          validator: Utils.textEmptyValidator),
                    if (type == 1) const SizedBox(height: 8),
                    SecondaryTextField(
                        context: context,
                        controller: phoneController,
                        formKey: phoneKey,
                        isDense: true,
                        isRequired: true,
                        keyboardType: TextInputType.phone,
                        label: 'Số điện thoại',
                        labelStyle: AppTextTheme.bodyRegular,
                        validator: Utils.phoneValidator),
                    const SizedBox(height: 8),
                    RichText(text: const TextSpan(text: 'Email', style: AppTextTheme.bodySmall, children: [])),
                    const SizedBox(height: 8),
                    PrimaryTextField(controller: emailController),
                    const SizedBox(height: 8),
                    SecondaryTextField(
                        context: context,
                        controller: birthController,
                        formKey: birthKey,
                        inputType: AppInputType.datePicker,
                        isDense: true,
                        label: type == 0 ? 'Ngày sinh' : 'Ngày thành lập',
                        labelStyle: AppTextTheme.bodyMedium,
                        validator: Utils.textEmptyValidator),
                    const SizedBox(height: 8),
                    SecondaryTextField(
                        context: context,
                        controller: addressController,
                        formKey: addressKey,
                        isDense: true,
                        isRequired: true,
                        label: 'Địa chỉ',
                        labelStyle: AppTextTheme.bodyRegular),
                    const SizedBox(height: 8),
                    RichText(
                        text: const TextSpan(
                            text: '*',
                            style: TextStyle(color: AppColor.red, fontSize: 8),
                            children: [TextSpan(text: ' Tỉnh (Thành phố)', style: AppTextTheme.bodySmall)])),
                    const SizedBox(height: 8),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.gray05, width: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        width: context.screenWidth,
                        child: BlocBuilder<CustomerCubit, CustomerState>(
                            buildWhen: (previous, current) => current is CustomerGetAllProvincesSuccess,
                            builder: (context, state) {
                              if (state is CustomerGetAllProvincesSuccess) {
                                provinces = state.provinces;

                                if (provinceController.text.isNotEmpty) {
                                  cubit.getAllDistricts(provinces.firstWhere(
                                          (element) => element["full_name"] == provinceController.text)["code"] ??
                                      '');
                                }
                              }

                              return PrimaryDropDownFormField(
                                  controller: provinceController,
                                  dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  fillColor: AppColor.white,
                                  hintText: '--- Chọn tỉnh thành phố ---',
                                  initialValue: provinceController.text.isEmpty ? null : provinceController.text,
                                  items: List.from(provinces.map((e) => e["full_name"])),
                                  key: provinceKey,
                                  onChanged: (p0, p1) {
                                    districtController.text = '';
                                    wardController.text = '';
                                    cubit.getAllDistricts(provinces[p1]["code"] ?? '');
                                  });
                            })),
                    const SizedBox(height: 8),
                    RichText(
                        text: const TextSpan(
                            text: '*',
                            style: TextStyle(color: AppColor.red, fontSize: 8),
                            children: [TextSpan(text: ' Quận (Huyện)', style: AppTextTheme.bodySmall)])),
                    const SizedBox(height: 8),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.gray05, width: 0.3),
                            borderRadius: BorderRadius.circular(2)),
                        width: context.screenWidth,
                        child: BlocBuilder<CustomerCubit, CustomerState>(
                            buildWhen: (previous, current) => current is CustomerGetAllDistrictSuccess,
                            builder: (context, state) {
                              if (state is CustomerGetAllDistrictSuccess) {
                                districts = state.districts;
                                if (wards.isEmpty &&
                                    provinceController.text.isNotEmpty &&
                                    districtController.text.isNotEmpty) {
                                  cubit.getAllWards(districts.firstWhere(
                                          (element) => element["full_name"] == districtController.text)["code"] ??
                                      '');
                                }
                              }

                              return PrimaryDropDownFormField(
                                  controller: districtController,
                                  dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  fillColor: AppColor.white,
                                  hintText: '--- Chọn quận huyện ---',
                                  initialValue: districtController.text.isEmpty ? null : districtController.text,
                                  items: List.from(districts.map((e) => e["full_name"])),
                                  key: UniqueKey(),
                                  onChanged: (p0, p1) {
                                    wardController.text = '';
                                    cubit.getAllWards(districts[p1]["code"] ?? '');
                                  });
                            })),
                    const SizedBox(height: 8),
                    RichText(
                        text: const TextSpan(
                            text: '*',
                            style: TextStyle(color: AppColor.red, fontSize: 8),
                            children: [TextSpan(text: ' Xã (Phường)', style: AppTextTheme.bodySmall)])),
                    const SizedBox(height: 8),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.gray05, width: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        width: context.screenWidth,
                        child: BlocBuilder<CustomerCubit, CustomerState>(
                            buildWhen: (previous, current) =>
                                current is CustomerGetAllWardSuccess ||
                                current is CustomerGetAllDistrictFailed ||
                                current is CustomerGetAllWardFailed,
                            builder: (context, state) {
                              if (state is CustomerGetAllWardSuccess) {
                                wards = state.wards;
                              }
                              return PrimaryDropDownFormField(
                                  controller: wardController,
                                  dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  fillColor: AppColor.white,
                                  hintText: '--- Chọn xã phường ---',
                                  initialValue: wardController.text.isEmpty ? null : wardController.text,
                                  items: wards.map((e) => e['full_name'] ?? '').toList(),
                                  key: UniqueKey(),
                                  onChanged: (p0, p1) => wardController.text = p0 ?? '');
                            })),
                    const SizedBox(height: 8),
                    if (args.routes.isNotEmpty)
                      RichText(
                          text: const TextSpan(
                              text: 'Chọn tuyến',
                              style: AppTextTheme.bodySmall,
                              children: [TextSpan(text: '*', style: TextStyle(color: AppColor.red))])),
                    if (args.routes.isNotEmpty) const SizedBox(height: 8),
                    if (args.routes.isNotEmpty)
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.gray05, width: 0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          width: context.screenWidth,
                          child: PrimaryDropDownFormField(
                            controller: routeController,
                            dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                            enabled: args.customer == null ? true : false,
                            fillColor: AppColor.white,
                            hintText: args.routeName ?? '--- Chọn tuyến ---',
                            items: List.from(args.routes.map((e) => e.name).toSet()),
                            onChanged: (p0, p1) => routeId = args.routes[p1].id ?? '',
                          )),
                    const SizedBox(height: 16),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      PrimaryButton(
                          backgroundColor: AppColor.white,
                          contentPadding: const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 8),
                          context: context,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          label: 'Hủy',
                          textStyle: AppTextTheme.textButtonPrimary.copyWith(color: AppColor.gray08)),
                      const SizedBox(width: 20),
                      BlocListener<CustomerCubit, CustomerState>(
                          listener: (context, state) {
                            if (state is CustomerAddCustomerSuccess || state is CustomerEditCustomerSuccess) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else if (state is CustomerAddCustomerFailed || state is CustomerEditCustomerFailed) {
                              Navigator.pop(context);
                              showGlobalDialog(message: 'Lỗi');
                            }
                          },
                          child: PrimaryButton(
                              backgroundColor: AppColor.blue02,
                              contentPadding: const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 8),
                              context: context,
                              onPressed: () {
                                showDialog(context: context, builder: (context) => const Loading());
                                if (args.customer == null) {
                                  addCustomer();
                                } else {
                                  editCustomer();
                                }
                              },
                              label: 'Lưu'))
                    ])
                  ]))
            ]))));
  }

  addCustomer() {
    if (!nameKey.currentState!.validate()) {
      nameKey.currentContext!.ensureVisible();
      return;
    }
    if (!phoneKey.currentState!.validate()) {
      phoneKey.currentContext!.ensureVisible();
      return;
    }
    if (!addressKey.currentState!.validate()) {
      addressKey.currentContext!.ensureVisible();
      return;
    }
    if (type == 1 && !contactKey.currentState!.validate()) {
      contactKey.currentContext!.ensureVisible();
      return;
    }
    if (type == 1 && !positionKey.currentState!.validate()) {
      positionKey.currentContext!.ensureVisible();
      return;
    }

    cubit.addCustomer(CustomerResponse(
        routeId: routeId,
        fullname: nameController.text,
        dateOfBirth: type == 0 ? Utils.toStringIsoDate(birthController.text) : null,
        email: emailController.text,
        mobile: phoneController.text,
        address: addressController.text,
        district: districtController.text,
        province: provinceController.text,
        commune: wardController.text,
        agency: AppConfig.agencyName,
        customerType: type,
        taxCode: taxCodeController.text,
        contactPerson: contactController.text,
        position: positionController.text,
        foundation: type == 1 ? Utils.toStringIsoDate(birthController.text) : null));
  }

  editCustomer() {
    if (!nameKey.currentState!.validate()) {
      nameKey.currentContext!.ensureVisible();
      return;
    }
    if (!phoneKey.currentState!.validate()) {
      phoneKey.currentContext!.ensureVisible();
      return;
    }
    if (!addressKey.currentState!.validate()) {
      addressKey.currentContext!.ensureVisible();
      return;
    }
    if (type == 1 && !contactKey.currentState!.validate()) {
      contactKey.currentContext!.ensureVisible();
      return;
    }
    if (type == 1 && !positionKey.currentState!.validate()) {
      positionKey.currentContext!.ensureVisible();
      return;
    }

    cubit.editCustomer(CustomerResponse(
        id: args.customer!.id,
        routeId: routeId,
        fullname: nameController.text,
        dateOfBirth: type == 0 ? Utils.toStringIsoDate(birthController.text) : null,
        email: emailController.text,
        mobile: phoneController.text,
        address: addressController.text,
        district: districtController.text,
        province: provinceController.text,
        commune: wardController.text,
        agency: AppConfig.agencyName,
        customerType: type,
        taxCode: taxCodeController.text,
        contactPerson: contactController.text,
        position: positionController.text,
        foundation: type == 1 ? Utils.toStringIsoDate(birthController.text) : null));
  }
}
