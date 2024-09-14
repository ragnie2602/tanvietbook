// ignore_for_file: deprecated_member_use
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../data/repository/local/local_data_access.dart';
import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../../domain/entity/appointment/appointment_entity.dart';
import '../../domain/entity/customer/customer.dart';
import '../../model/route.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/container/primary_gesture_detector.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/no_data.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_drop_down_form_field.dart';
import '../../shared/widgets/primary_icon_button.dart';
import '../../shared/widgets/primary_search_text_field.dart';
import '../base/base_page_sate.dart';
import 'cubit/customer_cubit.dart';

class CustomerChoosePage extends StatefulWidget {
  const CustomerChoosePage({super.key});

  @override
  State<CustomerChoosePage> createState() => _CustomerChoosePageState();
}

class _CustomerChoosePageState extends BasePageState<CustomerChoosePage, CustomerCubit> {
  late CustomerPageArgs args;
  List<Customer> customers = [];
  final LocalDataAccess localDataAccess = getIt.get();
  List<RouteEntity> _routes = [];
  TextEditingController routeController = TextEditingController();
  String? routeId;
  String routeName = '';
  TextEditingController searchController = TextEditingController();
  String search = '';

  @override
  PreferredSizeWidget? get appBar =>
      const PrimaryAppBar(canPop: true, centerTitle: true, title: 'Danh sách khách hàng');

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  void initState() {
    super.initState();

    cubit.getAllRoutes(isCurrent: true);
    cubit.checkRole();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    args = context.arguments as CustomerPageArgs;
  }

  @override
  Widget buildPage(BuildContext context) {
    return RefreshIndicator(
        backgroundColor: AppColor.white,
        onRefresh: () => cubit.searchCustomerByRoute(routeId),
        child: Column(children: [
          const SizedBox(height: 16),
          Container(
              color: AppColor.white,
              constraints: BoxConstraints(maxWidth: context.screenWidth),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Row(children: [
                Expanded(
                    child: SizedBox(
                        height: 40,
                        child: PrimarySearchTextField(
                            controller: searchController,
                            hintText: 'Nhập số điện thoại/tên khách hàng',
                            onChanged: (_) {},
                            prefixIcon: const Icon(Icons.search, color: AppColor.blue02),
                            suffixIcon: const SizedBox()))),
                const SizedBox(width: 16),
                PrimaryButton(
                    backgroundColor: AppColor.blue02,
                    context: context,
                    onPressed: () => cubit.searchCustomerByRoute(routeId, search: searchController.text),
                    label: 'Tìm kiếm')
              ])),
          BlocConsumer<CustomerCubit, CustomerState>(
              listener: (context, state) {
                if (state is CustomerGetAllRoutesSuccessState) {
                  setState(() {
                    _routes = state.routes;
                    if (_routes.isNotEmpty) {
                      cubit.searchCustomerByRoute(routeId = _routes[0].id ?? '');
                      routeController.text = _routes.first.name ?? '';
                      routeName = _routes[0].name ?? '';
                    } else {
                      cubit.searchCustomerByRoute(null);
                    }
                  });
                }
              },
              buildWhen: (previous, current) => current is CustomerGetAllRoutesSuccessState,
              builder: (context, state) {
                return state is CustomerGetAllRoutesSuccessState
                    ? Column(children: [
                        PrimaryButton(
                            backgroundColor: AppColor.white,
                            borderColor: AppColor.white,
                            context: context,
                            icon: Icons.add_circle_outline,
                            iconColor: AppColor.blue02,
                            label: 'Thêm thông tin khách hàng',
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.customerAddPage,
                                  arguments: CustomerAddPageArgs(cubit, _routes));
                            },
                            textStyle: const TextStyle(color: AppColor.blue02)),
                        const SizedBox(height: 16),
                        localDataAccess.getUserRole() == UserRole.sale
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColor.gray05, width: 0.3),
                                    borderRadius: BorderRadius.circular(2)),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                width: context.screenWidth,
                                child: PrimaryDropDownFormField(
                                    controller: routeController,
                                    initialValue: routeName,
                                    decoration: const BoxDecoration(color: AppColor.white),
                                    dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                    items: List.from(_routes.map((e) => e.name).toSet()),
                                    onChanged: (p0, p1) {
                                      cubit.searchCustomerByRoute(
                                          routeId = (_routes.firstWhere((element) => element.name == p0).id) ?? '');
                                      routeName = p0 ?? '';
                                    }))
                            : Container()
                      ])
                    : Container();
              }),
          const SizedBox(height: 16),
          Flexible(
              child: BlocBuilder<CustomerCubit, CustomerState>(
                  buildWhen: (previous, current) =>
                      current is CustomerSearchCustomerByRouteSuccess ||
                      current is CustomerAddCustomerSuccess ||
                      current is CustomerInitial,
                  builder: (context, state) {
                    if (state is CustomerInitial) {
                      return const Loading();
                    } else if (state is CustomerSearchCustomerByRouteSuccess) {
                      customers = state.customers;
                    } else if (state is CustomerAddCustomerSuccess) {
                      customers.insert(0, state.customer);
                    }

                    return customers.isEmpty
                        ? const Center(child: Padding(padding: EdgeInsets.only(top: 100), child: NoData()))
                        : ListView.builder(
                            itemBuilder: (context, index) => CustomerDetail(
                                customer: customers[index],
                                isShowCheckingSection: !args.isGetCustomerByCurrentRoute,
                                onTap: () {
                                  args.onCustomerSelected?.call(customers[index]);
                                  Navigator.pop(context);
                                },
                                routeName: routeName),
                            itemCount: customers.length,
                            shrinkWrap: true);
                  }))
        ]));
  }
}

// ignore: must_be_immutable
class CustomerDetail extends StatefulWidget {
  final Customer customer;
  final bool isShowCheckingSection;
  final Function()? onTap;
  final String routeName;
  // final isInCheckin

  const CustomerDetail(
      {super.key, required this.customer, this.isShowCheckingSection = true, this.onTap, required this.routeName});

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  late Customer _customer;
  final CustomerCubit localCubit = CustomerCubit();
  Location? location;

  @override
  void initState() {
    super.initState();
    if (widget.isShowCheckingSection) getDistance();
    _customer = widget.customer;
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryGestureDetector(
        onTap: () {
          if (!widget.isShowCheckingSection) {
            widget.onTap?.call();
          }
        },
        child: BlocProvider(
            create: (context) => localCubit,
            child: BlocListener<CustomerCubit, CustomerState>(
              listener: (context, state) {
                if (state is CustomerEditCustomerSuccess) {
                  setState(() {
                    _customer = state.customer;
                  });
                }
              },
              child: Column(children: [
                Container(
                    color: AppColor.white,
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
                    width: context.screenWidth,
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(
                          child: Column(children: [
                        _customer.customerType == 0
                            ? Row(children: [
                                Text('${_customer.fullname} | ',
                                    style: AppTextTheme.textPrimaryBold.copyWith(fontWeight: FontWeight.w700)),
                                Text('${_customer.mobile}')
                              ])
                            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text('${_customer.fullname}',
                                    style: AppTextTheme.textPrimaryBold.copyWith(fontWeight: FontWeight.w700)),
                                Row(children: [
                                  Text('${_customer.contactPerson} | ',
                                      style: AppTextTheme.textPrimaryBold.copyWith(fontWeight: FontWeight.w700)),
                                  Text('${_customer.mobile}')
                                ])
                              ]),
                        const SizedBox(height: 8),
                        Row(children: [
                          Expanded(
                              child: Text(Utils.formatAddress(
                                  _customer.address, _customer.commune, _customer.district, _customer.province))),
                          BlocBuilder<CustomerCubit, CustomerState>(
                              buildWhen: (previous, current) => current is CustomerGetDistanceSuccess,
                              builder: (context, state) {
                                return PrimaryButton(
                                    backgroundColor: AppColor.white,
                                    context: context,
                                    elevation: 0,
                                    onPressed: () {
                                      openGoogleMaps(
                                          '${_customer.commune}, ${_customer.district}, ${_customer.province}');
                                    },
                                    label: state is CustomerGetDistanceSuccess
                                        ? '${(state.distance).toPrecision(2)} km'
                                        : '-.-- km',
                                    icon: Assets.icDirection,
                                    iconColor: AppColor.blue02,
                                    textStyle: AppTextTheme.textPrimary.copyWith(color: AppColor.blue02));
                              })
                        ]),
                        if (widget.isShowCheckingSection)
                          SizedBox(
                            width: context.screenWidth,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(children: [
                                const SizedBox(width: 16),
                                SvgPicture.asset(Assets.icCalendar, color: AppColor.blue02),
                                const SizedBox(width: 5),
                                Expanded(
                                    child: Text(
                                        'Thời gian checkin gần đây: ${Utils.toStringDate(_customer.timeCheckinRecent ?? '', showTime: true)}'))
                              ]),
                              const SizedBox(height: 4),
                              Row(children: [
                                const SizedBox(width: 16),
                                SvgPicture.asset(Assets.icChecklist, color: AppColor.blue02),
                                const SizedBox(width: 5),
                                Expanded(child: Text('Tổng số lần đã checkin: ${_customer.totalCheckin}'))
                              ]),
                              const SizedBox(height: 4),
                              Row(children: [
                                const SizedBox(width: 16),
                                SvgPicture.asset(Assets.icCheckbox, color: AppColor.blue02),
                                const SizedBox(width: 5),
                                Expanded(child: Text('Tổng số đơn hàng: ${_customer.totalOrder}'))
                              ]),
                              const SizedBox(height: 12)
                            ]),
                          )
                      ])),
                      PrimaryIconButton(
                          backgroundColor: AppColor.white,
                          borderColor: AppColor.white,
                          context: context,
                          elevation: 0,
                          icon: Assets.icEdit3,
                          iconColor: AppColor.blue02,
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoute.customerAddPage,
                                arguments: CustomerAddPageArgs(localCubit, [],
                                    customer: _customer, routeName: widget.routeName));
                          })
                    ])),
                if (widget.isShowCheckingSection)
                  Container(
                      color: AppColor.white,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                        address: _customer.address,
                                        customerId: _customer.id,
                                        customerName: _customer.fullname,
                                        customerPhone: _customer.mobile)));
                          },
                          textStyle: AppTextTheme.bodyTiny,
                        ),
                        const Spacer(),
                        PrimaryButton(
                            backgroundColor: AppColor.yellow01,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            context: context,
                            icon: Assets.icShopping,
                            label: 'Đặt hàng',
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.customerChooseProduct,
                                  arguments: CustomerAllProductsArgs(_customer));
                            },
                            textStyle: AppTextTheme.bodyTiny),
                        const Spacer(),
                        BlocBuilder<CustomerCubit, CustomerState>(
                            buildWhen: (previous, current) => current is CustomerGetDistanceSuccess,
                            builder: (context, state) {
                              return PrimaryButton(
                                backgroundColor: (state is CustomerGetDistanceSuccess && state.distance <= 1)
                                    ? AppColor.blue03
                                    : AppColor.gray08,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                context: context,
                                icon: Assets.icCheckin,
                                label: 'Checkin',
                                onPressed: (state is CustomerGetDistanceSuccess && state.distance <= 1)
                                    ? () async {
                                        if (await requestPosition()) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushNamed(context, AppRoute.checkin,
                                              arguments: CheckinPageArgs(_customer, location: location!));
                                        }
                                      }
                                    : () {},
                                textStyle: AppTextTheme.bodyTiny,
                              );
                            }),
                        const Spacer()
                      ])),
                Container(color: AppColor.white, height: 8),
                const SizedBox(height: 16)
              ]),
            )));
  }

  openGoogleMaps(String address) async {
    List<Location>? locations = await GeocodingPlatform.instance?.locationFromAddress(address) ?? [];

    if (locations.isEmpty) {
      return;
    }

    final availableMaps = await MapLauncher.installedMaps;

    final googleMap = availableMaps.firstWhere((element) => element.mapType == MapType.google);

    await googleMap.showDirections(destination: Coords(locations.first.latitude, locations.first.longitude));
  }

  getDistance() async {
    var status = await Permission.location.status;

    if (!status.isGranted) {
      status = await Permission.location.request();

      if (!status.isGranted) {
        return null;
      }
    }
    Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    List<Location> locations = await GeocodingPlatform.instance?.locationFromAddress(
            '${_customer.address}, ${_customer.commune ?? ''}, ${_customer.district ?? ''}, ${_customer.province ?? ''}') ??
        [];

    if (locations.isEmpty) {
      return;
    }

    location = locations.first;

    localCubit.getDistance(p.latitude, p.longitude, locations.first.latitude, locations.first.longitude);
  }

  Future<bool> requestPosition() async {
    var status = await Permission.location.status;

    if (!status.isGranted) {
      status = await Permission.location.request();
    }
    return status.isGranted;
  }
}
