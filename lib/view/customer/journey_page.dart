import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

import '../../config/config.dart';
import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../../domain/entity/checkin/checkin_detail.dart';
import '../../model/checkin/journey_request.dart';
import '../../model/route.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/no_data.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_drop_down_form_field.dart';
import 'cubit/customer_cubit.dart';

class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  final CustomerCubit cubit = getIt.get();
  final DateTime dateTime = DateTime.now();
  final TextEditingController modeController = TextEditingController();
  final TextEditingController routeController = TextEditingController();
  int mode = 0;
  List<RouteEntity> routes = [];
  String routeId = '';
  final TextEditingController timeController = TextEditingController();
  int view = 0;

  @override
  void initState() {
    super.initState();
    cubit.getAllRoutes(isCurrent: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PrimaryAppBar(canPop: true, centerTitle: true, title: 'Xem hành trình'),
        body: BlocProvider.value(
            value: cubit,
            child: Container(
                constraints: BoxConstraints(maxHeight: context.screenHeight),
                child: Column(children: [
                  const SizedBox(width: 12),
                  Container(
                      color: AppColor.white,
                      padding: const EdgeInsets.all(16),
                      width: context.screenWidth,
                      child: Column(children: [
                        SizedBox(
                            child: Row(children: [
                          Expanded(
                              child: PrimaryDropDownFormField(
                            controller: timeController,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)), color: AppColor.neutral5),
                            hintText: 'Thời gian',
                            initialValue: 'Hôm nay',
                            items: const ['Hôm nay', 'Hôm qua', 'Tuần này', 'Tháng này', 'Năm nay', 'Khoảng thời gian'],
                            onChanged: (p0, p1) {
                              mode = p1;
                              getJourney();
                            },
                          )),
                          const SizedBox(width: 12),
                          Expanded(
                              child: BlocListener<CustomerCubit, CustomerState>(
                                  listener: (context, state) {
                                    if (state is CustomerGetAllRoutesSuccessState) {
                                      setState(() {
                                        routes = state.routes;
                                        routeId = state.routes[0].id ?? '';
                                        getJourney();
                                      });
                                    }
                                  },
                                  child: PrimaryDropDownFormField(
                                    controller: routeController,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)), color: AppColor.neutral5),
                                    hintText: routes.isNotEmpty ? routes[0].name : '(chưa có tuyến)',
                                    hintTextStyle:
                                        AppTextTheme.bodyMedium.copyWith(color: AppColor.black.withOpacity(0.6)),
                                    items: routes.map((e) => e.name ?? '').toSet().toList(),
                                    onChanged: (p0, p1) {
                                      routeId = routes.elementAt(p1).id ?? '';
                                      getJourney();
                                    },
                                    textStyle: AppTextTheme.bodyMedium.copyWith(
                                        color: AppColor.black.withOpacity(0.6), overflow: TextOverflow.ellipsis),
                                  )))
                        ])),
                        const SizedBox(height: 12),
                        PrimaryDropDownFormField(
                            controller: modeController,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)), color: AppColor.neutral5),
                            initialValue: 'Xem theo danh sách lịch sử checkin',
                            items: const ['Xem theo danh sách lịch sử checkin', 'Xem theo bản đồ'],
                            onChanged: (p0, p1) => setState(() {
                                  view = p1;
                                }))
                      ])),
                  Expanded(
                      child: BlocBuilder<CustomerCubit, CustomerState>(
                          buildWhen: (previous, current) =>
                              current is CustomerInitial ||
                              current is CustomerGetJourneySuccess ||
                              current is CustomerGetJourneyFailed,
                          builder: (context, state) {
                            if (state is CustomerGetJourneyFailed) {
                              return const NoData();
                            } else if (state is CustomerInitial) {
                              return const Loading();
                            } else if (state is CustomerGetJourneySuccess) {
                              return view == 1
                                  ? JourneyByMap(checkinDetails: state.checkinDetails)
                                  : JourneyByList(checkinDetails: state.checkinDetails);
                            }
                            return Container();
                          }))
                ]))));
  }

  getJourney() {
    switch (mode) {
      case 0:
        cubit.getJourneys(JourneyRequest(
            agency: AppConfig.agencyName,
            day: dateTime.day,
            month: dateTime.month,
            year: dateTime.year,
            routeId: routeId));
        break;
      case 1:
        cubit.getJourneys(JourneyRequest(
            agency: AppConfig.agencyName,
            day: dateTime.day - 1,
            month: dateTime.month,
            year: dateTime.year,
            routeId: routeId));
        break;
      case 2:
        cubit.getJourneys(JourneyRequest(agency: AppConfig.agencyName, week: 0, routeId: routeId));
        break;
      case 3:
        cubit.getJourneys(
            JourneyRequest(agency: AppConfig.agencyName, month: dateTime.month, year: dateTime.year, routeId: routeId));
        break;
      case 4:
        cubit.getJourneys(JourneyRequest(agency: AppConfig.agencyName, year: dateTime.year, routeId: routeId));
        break;
      default:
    }
  }
}

class JourneyByList extends StatelessWidget {
  final CustomerCubit cubit = getIt.get();
  final List<CheckinDetail> checkinDetails;

  JourneyByList({super.key, required this.checkinDetails});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => Container(
            color: AppColor.white,
            constraints: BoxConstraints(maxWidth: context.screenWidth),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SvgPicture.asset(Assets.icLocation, color: AppColor.red02),
              const SizedBox(width: 4),
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${checkinDetails[index].customerName} - ${checkinDetails[index].mobileCus}',
                    style: AppTextTheme.textPrimaryBold),
                Text('${checkinDetails[index].addressCus}', style: AppTextTheme.textPrimaryBold),
                Row(children: [
                  Expanded(
                      child: Text('${checkinDetails[index].districtCus}, ${checkinDetails[index].provinceCus}',
                          softWrap: true, style: AppTextTheme.textPrimaryBold)),
                  PrimaryButton(
                      backgroundColor: AppColor.white,
                      contentPadding: EdgeInsets.zero,
                      context: context,
                      elevation: 0,
                      label: 'Xem chi tiết',
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(child: _Detail(cubit, checkinDetails[index].id ?? '')));
                      },
                      textStyle: AppTextTheme.textPrimarySmallItalic
                          .copyWith(color: AppColor.blue02, decoration: TextDecoration.underline))
                ])
              ]))
            ])),
        itemCount: checkinDetails.length);
  }
}

class JourneyByMap extends StatefulWidget {
  final List<CheckinDetail> checkinDetails;
  const JourneyByMap({super.key, required this.checkinDetails});

  @override
  State<JourneyByMap> createState() => _JourneyByMapState();
}

class _JourneyByMapState extends State<JourneyByMap> {
  final CustomerCubit cubit = getIt.get();
  final MapController controller = MapController();

  @override
  Widget build(BuildContext context) {
    return widget.checkinDetails.isNotEmpty
        ? FlutterMap(
            mapController: controller,
            options: MapOptions(
                center: LatLng(widget.checkinDetails[0].latitudeCheckout!, widget.checkinDetails[0].longitudeCheckout!),
                zoom: 16.0),
            children: [
                TileLayer(
                    additionalOptions: const {'api_key': 'Kpvm8q9Ja3v8PyvLqJnFFIVkVisDf9Z0kto0vGp5'},
                    urlTemplate:
                        "https://maps.goong.io/maps/embed?mid=ecf33587-d8c5-4e1d-a355-65e7fb039f3e&lat=21.026745&long=105.801982&z=12"),
                MarkerLayer(
                    markers: widget.checkinDetails
                        .map((e) => Marker(
                            point: LatLng(e.latitudeCheckout!, e.longitudeCheckout!),
                            builder: (context) => InkWell(
                                onTap: () => showDialog(
                                    builder: (context) => Dialog(child: _Detail(cubit, e.id ?? '')), context: context),
                                child: SvgPicture.asset(Assets.icLocation, color: AppColor.red))))
                        .toList())
              ])
        : const NoData();
  }
}

class _Detail extends StatelessWidget {
  final CustomerCubit cubit;
  final String id;

  const _Detail(this.cubit, this.id);

  @override
  Widget build(BuildContext context) {
    cubit.getCheckinDetail(id);
    return BlocProvider.value(
        value: cubit,
        child: BlocBuilder<CustomerCubit, CustomerState>(
            buildWhen: (previous, current) => current is CustomerGetCheckinDetailSuccess || current is CustomerInitial,
            builder: (context, state) {
              return state is CustomerGetCheckinDetailSuccess
                  ? (state.checkinDetail != null
                      ? Container(
                          color: AppColor.white,
                          constraints: BoxConstraints(maxWidth: context.screenWidth),
                          padding: const EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: Column(mainAxisSize: MainAxisSize.min, children: [
                              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                SvgPicture.asset(Assets.icLocation, color: AppColor.red),
                                const SizedBox(width: 4),
                                Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text('${state.checkinDetail!.customerName} - ${state.checkinDetail!.mobileCus}',
                                      softWrap: true, style: AppTextTheme.textPrimaryBoldMedium),
                                  Text('${state.checkinDetail!.addressCus} - ${state.checkinDetail!.communeCus}',
                                      style: AppTextTheme.textPrimaryBoldMedium),
                                  Text('${state.checkinDetail!.districtCus} - ${state.checkinDetail!.provinceCus}',
                                      style: AppTextTheme.textPrimaryBoldMedium),
                                  const SizedBox(height: 16),
                                  if (state.checkinDetail!.locationCheckin != null)
                                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      SvgPicture.asset(Assets.icPointOnMap, color: AppColor.blue02),
                                      const SizedBox(width: 4),
                                      Expanded(
                                          child: Text('Địa điểm checkin: ${state.checkinDetail!.locationCheckin}',
                                              softWrap: true))
                                    ]),
                                  const SizedBox(height: 4),
                                  if (state.checkinDetail!.timeCheckin != null)
                                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      SvgPicture.asset(Assets.icCalendar, color: AppColor.blue02),
                                      const SizedBox(width: 4),
                                      Expanded(
                                          child: Text(
                                              'Thời gian checkin: ${Utils.formatDate(state.checkinDetail!.timeCheckin ?? '', showTime: true)}',
                                              softWrap: true))
                                    ]),
                                  const SizedBox(height: 4),
                                  if (state.checkinDetail!.timeCheckout != null)
                                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      SvgPicture.asset(Assets.icCalendar, color: AppColor.blue02),
                                      const SizedBox(width: 4),
                                      Expanded(
                                          child: Text(
                                              'Thời gian checkout: ${Utils.formatDate(state.checkinDetail!.timeCheckout ?? '', showTime: true)}',
                                              softWrap: true))
                                    ]),
                                  const SizedBox(height: 4),
                                  if (state.checkinDetail!.purpose != null)
                                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      SvgPicture.asset(Assets.icChecklist, color: AppColor.blue02),
                                      const SizedBox(width: 4),
                                      Expanded(
                                          child:
                                              Text('Nội dung checkin: ${state.checkinDetail!.purpose}', softWrap: true))
                                    ]),
                                  const SizedBox(height: 4),
                                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    SvgPicture.asset(Assets.icArchived, color: AppColor.blue02),
                                    const SizedBox(width: 4),
                                    Expanded(
                                        flex: 5,
                                        child:
                                            Text('Tổng số đơn hàng checkin: ${state.checkinDetail!.orderTotal ?? 0}')),
                                    Expanded(
                                      child: PrimaryButton(
                                          backgroundColor: AppColor.white,
                                          contentPadding: EdgeInsets.zero,
                                          context: context,
                                          elevation: 0,
                                          label: 'Xem',
                                          onPressed: () {
                                            Navigator.pushNamed(context, AppRoute.agencyOrderListPage,
                                                arguments: AgencyOrderListPageArgs(
                                                    orders: state.checkinDetail?.listOrderId ?? []));
                                          },
                                          textStyle: AppTextTheme.textPrimarySmallItalic
                                              .copyWith(color: AppColor.blue02, decoration: TextDecoration.underline)),
                                    )
                                  ]),
                                  const SizedBox(height: 10),
                                  const Text('Hình ảnh', style: AppTextTheme.textPrimaryBoldMedium),
                                  // ListView.builder(
                                  //     itemBuilder: (context, i) => checkinDetails[index].images != null ? Image.network(checkinDetails[index].images![i]) : Container(),
                                  //     scrollDirection: Axis.horizontal,
                                  //     shrinkWrap: true)
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: state.checkinDetail!.images == null
                                            ? []
                                            : state.checkinDetail!.images!.map((e) => Image.network(e)).toList()),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text('Ghi chú', style: AppTextTheme.textPrimaryBoldMedium),
                                  const SizedBox(height: 6),
                                  Text('${state.checkinDetail!.note}', softWrap: true)
                                ]))
                              ]),
                              const SizedBox(height: 14),
                              PrimaryButton(
                                  context: context,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  label: 'Xong')
                            ]),
                          ))
                      : const NoData())
                  : const Loading();
            }));
  }
}
