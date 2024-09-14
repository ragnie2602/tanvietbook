// ignore_for_file: deprecated_member_use
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../../domain/entity/appointment/appointment_entity.dart';
import '../../domain/entity/customer/customer.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/image/image_item.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_drop_down_form_field.dart';
import '../../shared/widgets/text_field/primary_text_field.dart';
import '../../shared/widgets/primary_notification.dart';
import 'cubit/customer_cubit.dart';

class Checkin extends StatefulWidget {
  const Checkin({super.key});

  @override
  State<Checkin> createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> with TickerProviderStateMixin {
  String address = '', checkinId = '';
  final TextEditingController contentController = TextEditingController();
  final CustomerCubit cubit = getIt.get(instanceName: 'singleton');
  late Customer customer;
  List<XFile> images = [];
  late bool isLimitedDistance;
  final TextEditingController noteController = TextEditingController();
  late Location location;
  final List<String> orderIds = [];
  StreamSubscription<Position>? _positionStreamSubscription;
  String? purpose;
  late final TabController tabController;
  // final int _time = 0;

  @override
  void initState() {
    super.initState();

    cubit.getAllPurpose();
    tabController = TabController(length: 2, vsync: this);

    getPosition();
    startTracking();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    customer = (context.arguments as CheckinPageArgs).customer;
    isLimitedDistance = (context.arguments as CheckinPageArgs).isLimitedDistance;
    location = (context.arguments as CheckinPageArgs).location;
    purpose = (context.arguments as CheckinPageArgs).purpose;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (context) => PrimaryNotification(
                  approve: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  cancel: () => Navigator.pop(context),
                  text: 'Bạn đang checkin nhưng chưa checkout. Bạn vẫn muốn tiếp tục chứ?'));
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                // title: StreamBuilder<String>(
                //   stream: Stream.periodic(const Duration(seconds: 1),
                //       (count) => Duration(seconds: ++_time).toString().split('.').first.padLeft(8, "0")),
                //   builder: (context, snapshot) => snapshot.connectionState == ConnectionState.active
                //       ? Text('Checkin ${snapshot.data}', style: AppTextTheme.titleMedium)
                // : const Text('Checkin', style: AppTextTheme.titleMedium),
                leading: BackButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => PrimaryNotification(
                            approve: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            cancel: () => Navigator.pop(context),
                            text: 'Bạn đang checkin nhưng chưa checkout. Bạn vẫn muốn tiếp tục chứ?'))),
                title: const Text('Checkin', style: AppTextTheme.titleMedium)),
            body: BlocProvider.value(
                value: cubit,
                child: SingleChildScrollView(
                    child: Column(children: [
                  BlocListener<CustomerCubit, CustomerState>(
                      listener: (context, state) {
                        if (state is CustomerCheckinFailed) {
                          showGlobalDialog(message: 'Lỗi checkin, vui lòng thử lại sau');
                          Navigator.pop(context);
                        }
                        if (state is CustomerCheckinSuccess) {
                          checkinId = state.checkinId;
                        }
                        if (state is CustomerCheckoutSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoute.home, (route) => route.settings.name == AppRoute.home);
                        }
                        if (state is CustomerCheckoutFailed) {
                          Navigator.pop(context);
                          showGlobalDialog(message: 'Lỗi checkout, vui lòng thử lại');
                        }
                        if (state is CustomerCreateOrderWhileCheckin) {
                          orderIds.add(state.orderId);
                        }
                        if (state is CustomerUploadMediaFailed) {
                          Navigator.pop(context);
                          showGlobalDialog(message: 'Không thể upload được ảnh');
                        }
                      },
                      child: const SizedBox(height: 8)),
                  Container(
                      color: AppColor.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Column(children: [
                        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          SvgPicture.asset(Assets.icPerson, color: AppColor.blue02),
                          const SizedBox(width: 6),
                          Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(
                                '${customer.fullname} - ${customer.mobile}\n${customer.address}\n${customer.district}, ${customer.province}.',
                                style: AppTextTheme.textPrimaryBold.copyWith(color: AppColor.gray02, fontSize: 16)),
                            const SizedBox(height: 6),
                            Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Column(children: [
                                  Row(children: [
                                    SvgPicture.asset(Assets.icCalendarDate, color: AppColor.blue02),
                                    Text('    Ngày sinh nhật: ${Utils.formatDate(customer.dateOfBirth ?? '')}',
                                        style: AppTextTheme.bodyMedium)
                                  ]),
                                  const SizedBox(height: 4),
                                  Row(children: [
                                    SvgPicture.asset(Assets.icUserHeart, color: AppColor.blue02),
                                    Text(
                                        '    Loại khách hàng: ${customer.customerType == 0 ? 'Cá nhân' : 'Doanh nghiệp'}',
                                        style: AppTextTheme.bodyMedium)
                                  ]),
                                  const SizedBox(height: 4),
                                  Row(mainAxisSize: MainAxisSize.min, children: [
                                    SvgPicture.asset(Assets.icCalendar, color: AppColor.blue02),
                                    Expanded(
                                        child: Text(
                                            '    Thời gian checkin gần đây: ${Utils.formatDate(customer.timeCheckinRecent ?? '', showTime: true)}',
                                            style: AppTextTheme.bodyMedium))
                                  ]),
                                  const SizedBox(height: 4),
                                  Row(children: [
                                    SvgPicture.asset(Assets.icChecklist, color: AppColor.blue02),
                                    Text('    Tổng số lần đã checkin: ${customer.totalCheckin ?? 0}',
                                        style: AppTextTheme.bodyMedium)
                                  ]),
                                  const SizedBox(height: 4),
                                  Row(children: [
                                    SvgPicture.asset(Assets.icCheckbox, color: AppColor.blue02),
                                    Text('    Tổng số đơn hàng: ${customer.totalOrder ?? 0}',
                                        style: AppTextTheme.bodyMedium)
                                  ])
                                ]))
                          ]))
                        ]),
                        const SizedBox(height: 8),
                        Row(children: [
                          SvgPicture.asset(Assets.icMapPointWave, color: AppColor.blue02),
                          const SizedBox(width: 6),
                          Expanded(
                              child: RichText(
                            text: TextSpan(
                                text: 'Vị trí checkin: ',
                                style: AppTextTheme.bodyStrong.copyWith(decoration: TextDecoration.underline),
                                children: [
                                  TextSpan(
                                      text: address,
                                      style: AppTextTheme.bodyStrong
                                          .copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.w400))
                                ]),
                          ))
                        ])
                      ])),
                  const SizedBox(height: 12),
                  Container(
                      color: AppColor.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      width: context.screenWidth,
                      child: Row(children: [
                        const Text('Nội dung checkin', style: AppTextTheme.titleMedium),
                        const SizedBox(width: 6),
                        Expanded(
                            child: BlocBuilder<CustomerCubit, CustomerState>(
                                buildWhen: (previous, current) => current is CustomerGetAllPurposeSuccessState,
                                builder: (context, state) => Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: AppColor.gray05, width: 0.3),
                                        borderRadius: BorderRadius.circular(2)),
                                    child: PrimaryDropDownFormField(
                                        controller: contentController,
                                        hintText: state is CustomerGetAllPurposeSuccessState
                                            ? state.purposes.isNotEmpty
                                                ? '(Chọn)'
                                                : '(không có dữ liệu)'
                                            : '(không có dữ liệu)',
                                        initialValue: purpose,
                                        items: state is CustomerGetAllPurposeSuccessState
                                            ? state.purposes.map((e) => e.name ?? '').toList()
                                            : [],
                                        onChanged: (p0, p1) => purpose = p0 ?? ''))))
                      ])),
                  const SizedBox(height: 12),
                  Container(
                      color: AppColor.white,
                      padding: EdgeInsets.zero,
                      child: TabBar(
                          controller: tabController,
                          indicatorColor: AppColor.red,
                          labelStyle: AppTextTheme.boldMedium.copyWith(color: AppColor.black),
                          tabs: const [Tab(text: 'Hình ảnh'), Tab(text: 'Ghi chú')])),
                  Container(
                      color: AppColor.white,
                      height: context.screenWidth * 9 / 16,
                      width: context.screenWidth,
                      child: TabBarView(controller: tabController, children: [
                        _Photo((p0) {
                          if (p0 != null) {
                            images.add(p0);
                          }
                        }),
                        _Note(noteController)
                      ])),
                  const SizedBox(height: 16),
                  Container(
                      color: AppColor.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(children: [
                        const Spacer(),
                        PrimaryButton(
                            backgroundColor: AppColor.green01,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            context: context,
                            icon: Assets.icClipboard,
                            label: 'Đặt lịch hẹn',
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.appointmentAdd,
                                  arguments: AppointmentAddArgs(
                                      appointment: AppointmentEntity(
                                          address: customer.address,
                                          customerId: customer.id,
                                          customerName: customer.fullname,
                                          customerPhone: customer.mobile)));
                            },
                            textStyle: AppTextTheme.bodyRegular.copyWith(color: AppColor.white)),
                        const Spacer(),
                        PrimaryButton(
                            backgroundColor: AppColor.yellow01,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            context: context,
                            icon: Assets.icShopping,
                            label: 'Đặt hàng',
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.customerChooseProduct,
                                  arguments: CustomerAllProductsArgs(customer));
                            },
                            textStyle: AppTextTheme.bodyRegular.copyWith(color: AppColor.white)),
                        const Spacer(),
                        PrimaryButton(
                            backgroundColor: AppColor.blue03,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            context: context,
                            icon: Assets.icCheckin,
                            label: 'Checkout',
                            onPressed: () {
                              if (purpose?.isEmpty == true) {
                                showDialog(
                                    context: context,
                                    builder: (context) => PrimaryNotification(
                                        cancel: () => Navigator.pop(context), text: 'Bạn chưa chọn nội dung checkin'));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => PrimaryNotification(
                                        approve: () {
                                          Navigator.pop(context);
                                          checkout();
                                        },
                                        cancel: () => Navigator.pop(context),
                                        text: 'Xác nhận checkout?'));
                              }
                            },
                            textStyle: AppTextTheme.bodyRegular.copyWith(color: AppColor.white)),
                        const Spacer()
                      ]))
                ])))));
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  checkout() async {
    if (mounted) {
      showDialog(context: context, builder: ((context) => const Loading()));
    }

    Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    cubit.checkout(
        checkinId: checkinId,
        images: images,
        latitude: p.latitude,
        location: address,
        longitude: p.longitude,
        notes: noteController.text,
        purpose: contentController.text,
        listOrderId: orderIds);
  }

  getPosition() async {
    Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(p.latitude, p.longitude);

    await cubit.checkin(
        customer,
        '${placemarks[0].street}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}',
        p.latitude,
        p.longitude);

    setState(() {
      address = '${placemarks[0].street}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}';
    });
  }

  startTracking() {
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    _positionStreamSubscription = geolocatorPlatform
        .getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 2))
        .listen((event) {
      if (isLimitedDistance &&
          Utils.distanceBetween(location.latitude, location.longitude, event.latitude, event.longitude) > 1) {
        checkout();
      }
    });
  }
}

class _Photo extends StatefulWidget {
  final Function(XFile?) imageHandle;

  const _Photo(this.imageHandle);

  @override
  State<_Photo> createState() => _PhotoState();
}

class _PhotoState extends State<_Photo> with AutomaticKeepAliveClientMixin {
  final ImagePicker _picker = ImagePicker();
  List<XFile?> images = [];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          children: images
              .map((e) => e != null
                  ? ImageItem(
                      image: e,
                      onCancel: (p0) => setState(() {
                            images.removeWhere((element) => element == p0);
                          }),
                      padding: const EdgeInsets.symmetric(vertical: 4))
                  : Container())
              .toList(),
        ),
        const SizedBox(height: 16),
        Center(
            child: Row(children: [
          const Spacer(),
          PrimaryButton(
              backgroundColor: AppColor.blue02,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              context: context,
              icon: Assets.icCamera,
              label: 'Chụp ảnh',
              onPressed: _getImage,
              textStyle: AppTextTheme.bodyMedium.copyWith(color: AppColor.white)),
          const Spacer()
        ])),
      ]),
    );
  }

  Future<void> _getImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, maxHeight: 250, maxWidth: 250, imageQuality: 88);

    widget.imageHandle(image);

    setState(() {
      images.add(image);
    });
  }
}

class _Note extends StatefulWidget {
  final TextEditingController controller;

  const _Note(this.controller);
  @override
  State<_Note> createState() => _NoteState();
}

class _NoteState extends State<_Note> {
  String note = '';
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(children: [
          Expanded(
            child: Container(
                decoration:
                    const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2)), color: AppColor.neutral5),
                child: PrimaryTextField(
                    controller: widget.controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (p0) => visible = true)),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Spacer(),
              if (visible)
                PrimaryButton(
                    backgroundColor: AppColor.gray12,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    context: context,
                    label: 'Hủy',
                    onPressed: () {
                      widget.controller.text = note;
                      setState(() {
                        visible = false;
                      });
                    },
                    textStyle: AppTextTheme.bodyMedium),
              SizedBox(width: context.screenWidth * 0.072),
              if (visible)
                PrimaryButton(
                    backgroundColor: AppColor.blue02,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    context: context,
                    label: 'Lưu',
                    onPressed: () {
                      note = widget.controller.text;
                      setState(() {
                        visible = false;
                      });
                    },
                    textStyle: AppTextTheme.bodyMedium.copyWith(color: AppColor.white)),
              const Spacer()
            ],
          )
        ]));
  }
}
