import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/repository/local/local_data_access.dart';
import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../../domain/entity/appointment/appointment_entity.dart';
import '../../domain/entity/customer/customer.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_drop_down_form_field.dart';
import '../../shared/widgets/primary_notification.dart';
import '../../shared/widgets/secondary_text_field.dart';
import '../affiliate/cubit/affiliate_cubit.dart';
import '../customer/cubit/customer_cubit.dart';
import 'cubit/appointment_cubit.dart';

class AppointmentAdd extends StatefulWidget {
  const AppointmentAdd({super.key});

  @override
  State<AppointmentAdd> createState() => _AppointmentAddState();
}

class _AppointmentAddState extends State<AppointmentAdd> {
  late final AppointmentAddArgs? args;
  final LocalDataAccess localDataAccess = getIt.get();

  final cubit = getIt.get<AppointmentCubit>();
  final customerCubit = getIt.get<CustomerCubit>();

  final TextEditingController contentController = TextEditingController();
  final GlobalKey<FormState> contentKey = GlobalKey<FormState>();
  final TextEditingController datingController = TextEditingController();
  final GlobalKey<FormState> datingKey = GlobalKey<FormState>();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController inChargeController = TextEditingController();
  final GlobalKey<FormState> inChargeKey = GlobalKey<FormState>();
  final TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> locationKey = GlobalKey<FormState>();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final GlobalKey<FormState> timeKey = GlobalKey<FormState>();
  final TextEditingController wardController = TextEditingController();

  Map<String, dynamic> data = {};
  late _Info info;
  bool isEditable = false, _isInitialized = false;

  Position? p;

  List<Map<String, String>> provinces = [];
  List<Map<String, String>> districts = [];
  List<Map<String, String>> wards = [];

  @override
  void initState() {
    super.initState();
    customerCubit.getAllPurpose();
    customerCubit.getAllProvince();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) args = context.arguments == null ? null : context.arguments as AppointmentAddArgs;

    if (!_isInitialized) contentController.text = args?.appointment?.note ?? '';
    if (!_isInitialized) {
      datingController.text = Utils.toStringDate(args?.appointment?.dateAppointment ?? '', letterDivider: '/');
    }
    if (!_isInitialized) districtController.text = args?.appointment?.district ?? '';
    if (!_isInitialized) inChargeController.text = args?.appointment?.salerName ?? localDataAccess.getUserName();
    if (!_isInitialized) locationController.text = args?.appointment?.location ?? '';
    if (!_isInitialized) purposeController.text = args?.appointment?.purpose ?? '';
    if (!_isInitialized) provinceController.text = args?.appointment?.province ?? '';
    if (!_isInitialized) timeController.text = Utils.toTime(args?.appointment?.dateAppointment ?? '');
    if (!_isInitialized) wardController.text = args?.appointment?.ward ?? '';

    if (!_isInitialized) {
      if (args == null) {
        // ignore: prefer_const_literals_to_create_immutables
        // info = _Info(data: {'type': -1});
        data = {'type': -1};
      } else {
        // info = _Info(
        // data: args!.appointment!.customerId == null
        //     ? {
        //         'employeeName': args!.appointment!.employeeName,
        //         'employeeUserName': args!.appointment!.employeeUserName,
        //         'position': args!.appointment!.position,
        //         'type': 0
        //       }
        //     : {
        //         'address': args!.appointment!.address,
        //         'customerId': args!.appointment!.customerId,
        //         'customerName': args!.appointment!.customerName,
        //         'customerMobile': args!.appointment!.customerPhone,
        //         'type': 1
        //       });
        data = args!.appointment!.customerId == null
            ? {
                'employeeName': args!.appointment!.employeeName,
                'employeeUserName': args!.appointment!.employeeUserName,
                'position': args!.appointment!.position,
                'type': 0
              }
            : {
                'address': args!.appointment!.address,
                'customerId': args!.appointment!.customerId,
                'customerName': args!.appointment!.customerName,
                'customerMobile': args!.appointment!.customerPhone,
                'type': 1
              };
      }
    }

    if (!_isInitialized) info = _Info(data: data, isEditable: args == null || isEditable);

    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            const PrimaryAppBar(centerTitle: true, elevation: 0, leading: BackButton(), title: 'Thông tin lịch hẹn'),
        body: MultiBlocProvider(
            providers: [BlocProvider.value(value: customerCubit), BlocProvider.value(value: cubit)],
            child: SingleChildScrollView(
                child: Column(children: [
              BlocListener<AppointmentCubit, AppointmentState>(
                  listener: (context, state) {
                    if (state is AppointmentAddAppointmentSuccess || state is AppointmentEditAppointmentSuccess) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else if (state is AppointmentAddAppointmentFailed) {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) =>
                              PrimaryNotification(approve: () => Navigator.pop(context), text: 'Có lỗi xảy ra'));
                    }
                  },
                  child: Container()),
              info,
              const SizedBox(height: 16),
              Container(
                  color: AppColor.white,
                  padding: const EdgeInsets.all(16),
                  width: context.screenWidth,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Thông tin lịch hẹn', style: AppTextTheme.titleMedium),
                    const SizedBox(height: 12),
                    SecondaryTextField(
                        context: context,
                        controller: inChargeController,
                        formKey: inChargeKey,
                        isDense: true,
                        isRequired: true,
                        label: 'Người phụ trách',
                        labelStyle: AppTextTheme.bodyMedium,
                        readOnly: args != null && !isEditable,
                        validator: Utils.textEmptyValidator),
                    const SizedBox(height: 12),
                    SecondaryTextField(
                        context: context,
                        controller: datingController,
                        formKey: datingKey,
                        inputType: AppInputType.datePicker,
                        isDense: true,
                        isRequired: true,
                        label: 'Ngày hẹn',
                        labelStyle: AppTextTheme.bodyMedium,
                        readOnly: args != null && !isEditable,
                        validator: Utils.textEmptyValidator),
                    const SizedBox(height: 12),
                    SecondaryTextField(
                        context: context,
                        controller: timeController,
                        formKey: timeKey,
                        inputType: AppInputType.timePicker,
                        isDense: true,
                        isRequired: true,
                        label: 'Thời gian',
                        labelStyle: AppTextTheme.bodyMedium,
                        readOnly: args != null && !isEditable,
                        validator: Utils.textEmptyValidator),
                    const SizedBox(height: 12),
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
                                  customerCubit.getAllDistricts(provinces.firstWhere(
                                          (element) => element["full_name"] == provinceController.text)["code"] ??
                                      '');
                                }
                              }

                              return PrimaryDropDownFormField(
                                  controller: provinceController,
                                  dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  enabled: args == null || isEditable,
                                  fillColor: AppColor.white,
                                  hintText: '--- Chọn tỉnh thành phố ---',
                                  initialValue: provinceController.text.isEmpty ? null : provinceController.text,
                                  items: List.from(provinces.map((e) => e["full_name"])),
                                  onChanged: (p0, p1) {
                                    districtController.text = '';
                                    wardController.text = '';
                                    customerCubit.getAllDistricts(provinces[p1]["code"] ?? '');
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
                                  customerCubit.getAllWards(districts.firstWhere(
                                          (element) => element["full_name"] == districtController.text)["code"] ??
                                      '');
                                }
                              }

                              return PrimaryDropDownFormField(
                                  controller: districtController,
                                  dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  enabled: args == null || isEditable,
                                  fillColor: AppColor.white,
                                  hintText: '--- Chọn quận huyện ---',
                                  initialValue: districtController.text.isEmpty ? null : districtController.text,
                                  items: List.from(districts.map((e) => e["full_name"])),
                                  key: UniqueKey(),
                                  onChanged: (p0, p1) {
                                    wardController.text = '';
                                    customerCubit.getAllWards(districts[p1]["code"] ?? '');
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
                                  enabled: args == null || isEditable,
                                  fillColor: AppColor.white,
                                  hintText: '--- Chọn xã phường ---',
                                  initialValue: wardController.text.isEmpty ? null : wardController.text,
                                  items: wards.map((e) => e['full_name'] ?? '').toList(),
                                  key: UniqueKey(),
                                  onChanged: (p0, p1) => wardController.text = p0 ?? '');
                            })),
                    const SizedBox(height: 12),
                    RichText(
                        text: TextSpan(
                            text: '* ',
                            style: AppTextTheme.bodySmall.copyWith(color: AppColor.red),
                            children: const [TextSpan(text: 'Địa điểm', style: TextStyle(color: AppColor.black))])),
                    SecondaryTextField(
                        context: context,
                        controller: locationController,
                        formKey: locationKey,
                        isDense: true,
                        labelStyle: AppTextTheme.bodyMedium,
                        readOnly: args != null && !isEditable,
                        validator: Utils.textEmptyValidator),
                    const SizedBox(height: 12),
                    Row(children: [
                      Text('* ', style: AppTextTheme.bodyMedium.copyWith(color: AppColor.red)),
                      const Text('Mục đích', style: AppTextTheme.bodyMedium),
                    ]),
                    const SizedBox(height: 12),
                    BlocBuilder<CustomerCubit, CustomerState>(
                        buildWhen: (previous, current) => current is CustomerGetAllPurposeSuccessState,
                        builder: (context, state) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.gray05, width: 0.3),
                                  borderRadius: BorderRadius.circular(2)),
                              child: PrimaryDropDownFormField(
                                  controller: purposeController,
                                  dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                  enabled: args == null || isEditable,
                                  hintText: state is CustomerGetAllPurposeSuccessState
                                      ? state.purposes.isNotEmpty
                                          ? '(Chọn)'
                                          : '(không có dữ liệu)'
                                      : purposeController.text.isEmpty
                                          ? '(không có dữ liệu)'
                                          : purposeController.text,
                                  initialValue: purposeController.text.isEmpty ? null : purposeController.text,
                                  items: state is CustomerGetAllPurposeSuccessState
                                      ? state.purposes.map((e) => e.name ?? '').toList()
                                      : []),
                            )),
                    const SizedBox(height: 12),
                    SecondaryTextField(
                        context: context,
                        controller: contentController,
                        formKey: contentKey,
                        isDense: true,
                        isRequired: true,
                        label: 'Nội dung',
                        labelStyle: AppTextTheme.bodyMedium,
                        readOnly: args != null && !isEditable,
                        validator: Utils.textEmptyValidator),
                    const SizedBox(height: 20),
                    if (args == null || isEditable)
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        PrimaryButton(
                            backgroundColor: AppColor.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            context: context,
                            onPressed: () {
                              if (args == null) {
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  isEditable = false;
                                  info = _Info(data: data, isEditable: args == null || isEditable);
                                });
                              }
                            },
                            label: 'Hủy',
                            textStyle: AppTextTheme.textButtonPrimary.copyWith(color: AppColor.gray08)),
                        const SizedBox(width: 14),
                        BlocListener<CustomerCubit, CustomerState>(
                          listener: (context, state) {
                            if (state is CustomerCheckRoleSuccess) {
                              if (state.role == UserRole.sale) {
                                onSave();
                              } else {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) => PrimaryNotification(
                                        approve: () => Navigator.pop(context),
                                        text: 'Username người phụ trách phải là sale'));
                              }
                            } else {}
                          },
                          child: PrimaryButton(
                              backgroundColor: AppColor.blue02,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              context: context,
                              onPressed: () {
                                showDialog(context: context, builder: (context) => const Loading());
                                customerCubit.checkRole(username: inChargeController.text);
                              },
                              label: 'Lưu'),
                        )
                      ]),
                    const SizedBox(height: 20),
                    if (!isEditable &&
                        args != null &&
                        DateTime.now().compareTo(
                                DateTime.parse(args!.appointment!.dateAppointment ?? DateTime.now().toString())
                                    .add(const Duration(minutes: 30))) <
                            0)
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        if (data['type'] == 1)
                          PrimaryButton(
                              backgroundColor: DateTime.now().compareTo(DateTime.parse(
                                          args!.appointment!.dateAppointment ?? DateTime.now().toString())) <
                                      0
                                  ? AppColor.gray
                                  : AppColor.blue02,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              context: context,
                              onPressed: () {
                                if (DateTime.now().compareTo(DateTime.parse(args!.appointment!.dateAppointment!)) > 0) {
                                  args?.appointment?.status = "1";
                                  onSave();
                                  checkin(context);
                                }
                              },
                              label: 'Checkin'),
                        if (data['type'] == 1) const SizedBox(width: 14),
                        PrimaryButton(
                            backgroundColor: AppColor.red,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            context: context,
                            onPressed: () {
                              setState(() {
                                isEditable = true;
                                info = _Info(data: data, isEditable: args == null || isEditable);
                              });
                            },
                            label: 'Chỉnh sửa')
                      ])
                  ]))
            ]))));
  }

  checkin(BuildContext context) async {
    List<Location>? locations = await GeocodingPlatform.instance?.locationFromAddress(
            '${args?.appointment?.address ?? ''}, ${args?.appointment?.ward ?? ''}, ${args?.appointment?.district ?? ''}, ${args?.appointment?.province ?? ''}') ??
        [];

    // if (locations.isEmpty) {
    //   if (mounted) {
    //     showDialog(context: context, builder: (context) => const Dialog(child: Text('Không lấy được toạ độ nơi hẹn')));
    //   }
    //   return;
    // }
    if (mounted) {
      Navigator.pushNamed(context, AppRoute.checkin,
          arguments: CheckinPageArgs(
              Customer(
                  id: args!.appointment!.customerId,
                  fullname: args!.appointment!.customerName,
                  mobile: args!.appointment!.customerPhone,
                  address: args!.appointment!.address,
                  commune: data['commune'],
                  district: data['district'],
                  province: data['province']),
              isLimitedDistance: false,
              location: locations.first,
              purpose: purposeController.text));
    }
  }

  onSave() {
    if (!inChargeKey.currentState!.validate()) {
      inChargeKey.currentContext!.ensureVisible();
      return;
    }
    if (!datingKey.currentState!.validate()) {
      datingKey.currentContext!.ensureVisible();
      return;
    }
    if (!timeKey.currentState!.validate()) {
      timeKey.currentContext!.ensureVisible();
      return;
    }
    if (!locationKey.currentState!.validate()) {
      locationKey.currentContext!.ensureVisible();
      return;
    }
    if (!contentKey.currentState!.validate()) {
      contentKey.currentContext!.ensureVisible();
      return;
    }

    final data = info.getData();

    if (args == null) {
      cubit.addAppointment(AppointmentEntity(
          routeId: data['routeId'],
          customerId: data['type'] == 1 ? data['customerId'] : null,
          customerName: data['type'] == 1 ? data['customerName'] : null,
          customerPhone: data['type'] == 1 ? data['customerMobile'] : null,
          address: data['type'] == 1 ? data['address'] : null,
          employeeName: data['type'] == 0 ? data['employeeName'] : null,
          employeeUserName: data['type'] == 0 ? data['employeeUserName'] : null,
          position: data['type'] == 0 ? data['position'] : null,
          salerName: inChargeController.text,
          dateAppointment:
              Utils.toStringIsoDateTime('${datingController.text} ${timeController.text}:00', letterDivider: '/'),
          location: locationController.text,
          district: districtController.text,
          province: provinceController.text,
          ward: wardController.text,
          purpose: purposeController.text,
          note: contentController.text,
          status: "0",
          type: data['type'],
          longitude: p?.longitude ?? 0.0,
          latitude: p?.latitude ?? 0.0));
    } else {
      cubit.editAppointment(AppointmentEntity(
          id: args?.appointment?.id,
          routeId: data['routeId'],
          customerId: data['type'] == 1 ? data['customerId'] : null,
          customerName: data['type'] == 1 ? data['customerName'] : null,
          customerPhone: data['type'] == 1 ? data['customerMobile'] : null,
          address: data['type'] == 1 ? data['address'] : null,
          employeeName: data['type'] == 0 ? data['employeeName'] : null,
          employeeUserName: data['type'] == 0 ? data['employeeUserName'] : null,
          position: data['type'] == 0 ? data['position'] : null,
          salerName: inChargeController.text,
          dateAppointment:
              Utils.toStringIsoDateTime('${datingController.text} ${timeController.text}:00', letterDivider: '/'),
          location: locationController.text,
          district: districtController.text,
          province: provinceController.text,
          ward: wardController.text,
          purpose: purposeController.text,
          note: contentController.text,
          type: data['type'],
          status: args?.appointment?.status ?? "0",
          longitude: p?.longitude ?? 0.0,
          latitude: p?.latitude ?? 0.0,
          code: args?.appointment?.code));
    }
  }
}

// ignore: must_be_immutable
class _Info extends StatefulWidget {
  Map<String, dynamic> data;
  final bool isEditable;

  _Info({required this.data, this.isEditable = true});

  @override
  State<_Info> createState() => _InfoState();

  Map<String, dynamic> getData() => data;
}

class _InfoState extends State<_Info> {
  final CustomerCubit customerCubit = getIt.get();
  int hasInputed = -1;

  @override
  void initState() {
    super.initState();
    if (widget.data['type'] == 1) {
      customerCubit.getCustomer(widget.data['customerId']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(16),
        width: context.screenWidth,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            SvgPicture.asset(Assets.icLocationOutline, color: AppColor.red),
            const SizedBox(width: 12),
            const Text('Thông tin đối tượng', style: AppTextTheme.textPrimaryBoldMedium)
          ]),
          const SizedBox(height: 22),
          if (widget.data['type'] > -1)
            Padding(
                padding: const EdgeInsets.only(left: 16),
                child: BlocProvider(
                    create: (context) => customerCubit,
                    child: BlocListener<CustomerCubit, CustomerState>(
                        listener: (context, state) {
                          if (state is CustomerGetCustomerSuccess) {
                            setState(() {
                              widget.data['commune'] = state.customer.commune ?? '';
                              widget.data['district'] = state.customer.district ?? '';
                              widget.data['province'] = state.customer.province ?? '';
                            });
                          }
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.data['type'] == 1
                                ? [
                                    Text('${widget.data['customerName']}  |  ${widget.data['customerMobile']}',
                                        style: AppTextTheme.bodyRegular),
                                    const SizedBox(height: 8),
                                    Text('${widget.data['address']}, ${widget.data['commune'] ?? ''}',
                                        style: AppTextTheme.bodyRegular),
                                    const SizedBox(height: 8),
                                    Text('${widget.data['district'] ?? ''}, ${widget.data['province'] ?? ''}',
                                        style: AppTextTheme.bodyRegular),
                                    const SizedBox(height: 8)
                                  ]
                                : [
                                    Text('${widget.data['employeeUserName']}', style: AppTextTheme.bodyRegular),
                                    const SizedBox(height: 8),
                                    Text('${widget.data['employeeName']}', style: AppTextTheme.bodyRegular),
                                    const SizedBox(height: 8),
                                    Text('${widget.data['position']}', style: AppTextTheme.bodyRegular),
                                    const SizedBox(height: 8)
                                  ])))),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (widget.isEditable)
              PrimaryButton(
                  backgroundColor: AppColor.blue02,
                  context: context,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.customerChoosePage,
                        arguments: CustomerPageArgs(
                            isGetCustomerByCurrentRoute: true,
                            onCustomerSelected: (customer) {
                              setState(() {
                                widget.data['type'] = 1;
                                widget.data['routeId'] = '${customer.routeId}';
                                widget.data['customerId'] = '${customer.id}';
                                widget.data['customerName'] = '${customer.fullname}';
                                widget.data['customerMobile'] = '${customer.mobile}';
                                widget.data['address'] = '${customer.address}';
                                widget.data['commune'] = '${customer.commune}';
                                widget.data['district'] = '${customer.district}';
                                widget.data['province'] = '${customer.province}';
                              });
                            }));
                  },
                  label: 'Khách hàng'),
            const SizedBox(width: 40),
            if (widget.isEditable)
              PrimaryButton(
                  context: context,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                            child: Internal(
                                data: widget.data,
                                messenger: (p0, p1, p2) {
                                  setState(() {
                                    widget.data['type'] = 0;
                                    widget.data['employeeUserName'] = p0;
                                    widget.data['employeeName'] = p1;
                                    widget.data['position'] = p2;
                                  });
                                })));
                  },
                  label: 'Nội bộ')
          ])
        ]));
  }
}

// ignore: must_be_immutable
class Internal extends StatelessWidget {
  Map<String, dynamic> data;
  final TextEditingController fullnameController = TextEditingController();
  final GlobalKey<FormState> fullnameKey = GlobalKey();
  final TextEditingController positionController = TextEditingController();
  final GlobalKey<FormState> positionKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final Function(String, String, String) messenger;
  final cubit = getIt.get<AffiliateCubit>();

  Internal({super.key, required this.data, required this.messenger});

  @override
  Widget build(BuildContext context) {
    fullnameController.text = data['employeeName'] ?? '';
    positionController.text = data['position'] ?? '';
    usernameController.text = data['employeeUserName'] ?? '';

    return BlocProvider(
        create: (context) => cubit,
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.white),
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              BlocListener<AffiliateCubit, AffiliateState>(
                  listener: (context, state) {
                    if (state is AffiliateCheckCollaboratorExistSuccess) {
                      if (state.isExisted) {
                        messenger(usernameController.text, fullnameController.text, positionController.text);
                        Navigator.pop(context);
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                child: PrimaryNotification(
                                    approve: () => Navigator.pop(context),
                                    text: 'Không tồn tại username này trong hệ thống')));
                      }
                    }
                  },
                  child: Container()),
              const Center(child: Text('Thông tin đối tượng', style: AppTextTheme.subTitleRed)),
              const SizedBox(height: 14),
              SecondaryTextField(controller: usernameController, isDense: true, label: 'Username'),
              const SizedBox(height: 14),
              SecondaryTextField(
                  controller: fullnameController,
                  formKey: fullnameKey,
                  isDense: true,
                  isRequired: true,
                  label: 'Họ và tên',
                  validator: Utils.textEmptyValidator),
              const SizedBox(height: 14),
              SecondaryTextField(
                  controller: positionController,
                  formKey: positionKey,
                  isDense: true,
                  isRequired: true,
                  label: 'Chức vụ',
                  validator: Utils.textEmptyValidator),
              const SizedBox(height: 14),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                PrimaryButton(
                    backgroundColor: AppColor.white,
                    borderColor: AppColor.neutral5,
                    context: context,
                    label: 'Hủy',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textStyle: AppTextTheme.textButtonPrimary.copyWith(color: AppColor.gray08)),
                const SizedBox(width: 14),
                PrimaryButton(
                    backgroundColor: AppColor.blue02,
                    context: context,
                    onPressed: () {
                      onSave(context);
                    },
                    label: 'Lưu')
              ])
            ])));
  }

  onSave(BuildContext context) async {
    if (!fullnameKey.currentState!.validate()) {
      fullnameKey.currentContext!.ensureVisible();
      return;
    }
    if (!positionKey.currentState!.validate()) {
      positionKey.currentContext!.ensureVisible();
      return;
    }
    if (usernameController.text.isNotEmpty) {
      cubit.checkCollaboratorExist(usernameController.text);
    } else {
      messenger(usernameController.text, fullnameController.text, positionController.text);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
