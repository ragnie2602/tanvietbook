import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../../domain/entity/appointment/appointment_entity.dart';
import '../../domain/entity/appointment/calendar_abstract.dart';
import '../../domain/entity/appointment/event_entity.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/loading.dart';
import '../../shared/widgets/no_data.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_icon_button.dart';
import 'cubit/appointment_cubit.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  AppointmentDetailArgs? args;
  final AppointmentCubit cubit = getIt.get();
  late DateTime _focusDate;
  final List<CalendarAbstract> items = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    args = context.arguments as AppointmentDetailArgs;
    _focusDate = args?.focusDate ?? DateTime.now();

    cubit.getCalendarDayEvent(DateTime.utc(_focusDate.year, _focusDate.month, _focusDate.day));
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    return Scaffold(
        appBar: PrimaryAppBar(
            centerTitle: true,
            elevation: 0,
            leading: const BackButton(),
            style: AppTextTheme.textPrimaryBoldLarge.copyWith(fontSize: 16),
            title: 'Đặt lịch hẹn'),
        body: BlocProvider.value(
            value: cubit,
            child: Container(
                color: AppColor.white,
                padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TableCalendar(
                      calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) => day == _focusDate
                              ? Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                      color: AppColor.red),
                                  child: Center(
                                      child: Text('${day.day}',
                                          style: AppTextTheme.calendarMedium.copyWith(color: AppColor.white))))
                              : Center(child: Text('${day.day}', style: AppTextTheme.calendarMedium)),
                          dowBuilder: (context, day) => day == _focusDate
                              ? Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                      color: AppColor.red),
                                  child: Text(Utils.toWeekDayString(day.weekday),
                                      textAlign: TextAlign.center,
                                      style: AppTextTheme.calendarSmall.copyWith(color: AppColor.white)))
                              : Text(Utils.toWeekDayString(day.weekday), textAlign: TextAlign.center),
                          headerTitleBuilder: (context, day) => Row(children: [
                                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: AppColor.blue02.withOpacity(0.1)),
                                      padding: const EdgeInsets.all(8),
                                      child: Text('Hôm nay',
                                          style: AppTextTheme.bodyRegular.copyWith(color: AppColor.blue02))),
                                  Row(children: [
                                    Text('${today.day}', style: AppTextTheme.calendarLarge),
                                    const SizedBox(width: 6),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(Utils.toWeekDayString(today.weekday, fullText: true),
                                          style: AppTextTheme.textPrimaryBold.copyWith(color: AppColor.gray14)),
                                      Text('Tháng ${today.month} / ${today.year}',
                                          style: AppTextTheme.textPrimaryBold.copyWith(color: AppColor.gray14))
                                    ])
                                  ]),
                                  const SizedBox(height: 20),
                                  PrimaryButton(
                                      backgroundColor: AppColor.white,
                                      contentPadding: EdgeInsets.zero,
                                      context: context,
                                      elevation: 0.0,
                                      onPressed: () {
                                        Navigator.pushNamed(context, AppRoute.appointment2);
                                      },
                                      label: 'Lịch tháng',
                                      textStyle: AppTextTheme.textButtonPrimary.copyWith(color: AppColor.blue02))
                                ]),
                                const Spacer(),
                                PrimaryButton(
                                    backgroundColor: AppColor.blue02,
                                    context: context,
                                    onPressed: () {
                                      Navigator.pushNamed(context, AppRoute.appointmentAdd);
                                    },
                                    label: 'Thêm lịch hẹn'),
                                const SizedBox(width: 16)
                              ]),
                          outsideBuilder: (context, day, focusedDay) => Center(
                              child: Text('${day.day}',
                                  style: AppTextTheme.calendarMedium.copyWith(color: AppColor.gray07))),
                          todayBuilder: (context, day, focusedDay) => day == _focusDate
                              ? Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                      color: AppColor.red),
                                  child: Center(
                                      child: Text('${day.day}',
                                          style: AppTextTheme.calendarMedium.copyWith(color: AppColor.white))))
                              : Center(child: Text('${day.day}', style: AppTextTheme.calendarMedium))),
                      calendarFormat: CalendarFormat.week,
                      firstDay: DateTime.now().subtract(const Duration(days: 365)),
                      focusedDay: _focusDate,
                      headerStyle: const HeaderStyle(formatButtonVisible: false, headerMargin: EdgeInsets.only(left: 10), leftChevronVisible: false, rightChevronVisible: false),
                      key: ValueKey(_focusDate),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      locale: 'vi',
                      onDaySelected: (selectedDay, focusedDay) => setState(() {
                            _focusDate = selectedDay;
                            cubit.getCalendarDayEvent(
                                DateTime.utc(selectedDay.year, selectedDay.month, selectedDay.day));
                          }),
                      weekendDays: const [DateTime.friday, DateTime.saturday]),
                  Row(children: [
                    const SizedBox(width: 8),
                    Expanded(
                        flex: 62,
                        child: Text('Thời gian',
                            style: AppTextTheme.titleMedium.copyWith(color: AppColor.gray14),
                            textAlign: TextAlign.center)),
                    const SizedBox(width: 14),
                    Expanded(
                        flex: 250,
                        child: Text('Lịch trình', style: AppTextTheme.titleMedium.copyWith(color: AppColor.gray14))),
                    const SizedBox(width: 8)
                  ]),
                  Expanded(
                      child: RefreshIndicator(
                          backgroundColor: AppColor.white,
                          onRefresh: () => cubit
                              .getCalendarDayEvent(DateTime.utc(_focusDate.year, _focusDate.month, _focusDate.day)),
                          child: BlocBuilder<AppointmentCubit, AppointmentState>(
                              buildWhen: (previous, current) =>
                                  current is AppointmentLoading ||
                                  current is AppointmentAddAppointmentSuccess ||
                                  current is AppointmentGetCalendarDayEventSuccess ||
                                  current is AppointmentGetCalendarDayEventFailed ||
                                  current is AppointmentAddAppointmentSuccess,
                              builder: (context, state) {
                                if (state is AppointmentGetCalendarDayEventSuccess) {
                                  items.clear();
                                  items.addAll(state.calendarEvent.listAppointment?.map((e) => e) ?? []);
                                  items.addAll(state.calendarEvent.listEvent?.map((e) => e) ?? []);
                                } else if (state is AppointmentAddAppointmentSuccess) {
                                  items.add(state.appointment);
                                }
                                items.sort(((a, b) => DateTime.parse(
                                        '${a is AppointmentEntity ? a.dateAppointment : a is EventEntity ? a.startTime : ''}')
                                    .compareTo(DateTime.parse(
                                        '${b is AppointmentEntity ? b.dateAppointment : b is EventEntity ? b.startTime : ''}'))));

                                return state is AppointmentLoading
                                    ? const Center(child: Loading())
                                    : items.isNotEmpty
                                        ? ListView.builder(
                                            itemBuilder: (context, index) {
                                              final item = items[index];

                                              return item is EventEntity
                                                  ? EventItem(event: item)
                                                  : item is AppointmentEntity
                                                      ? AppointmentItem(appointment: item)
                                                      : Container();
                                            },
                                            itemCount: items.length)
                                        : const NoData();
                              })))
                ]))));
  }
}

class Appointment2 extends StatefulWidget {
  const Appointment2({super.key});

  @override
  State<Appointment2> createState() => _Appointment2State();
}

class _Appointment2State extends State<Appointment2> {
  final AppointmentCubit cubit = getIt.get();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    cubit.getCalendarEvent(DateTime.now().month, DateTime.now().year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PrimaryAppBar(centerTitle: true, elevation: 0, leading: BackButton(), title: 'Đặt lịch hẹn'),
        backgroundColor: AppColor.white,
        body: BlocProvider.value(
            value: cubit,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Lịch', style: AppTextTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.gray09), borderRadius: BorderRadius.circular(5)),
                      child: BlocBuilder<AppointmentCubit, AppointmentState>(
                          buildWhen: (previous, current) =>
                              current is AppointmentGetCalendarEventSuccess || current is AppointmentInitial,
                          builder: (context, state) {
                            return TableCalendar(
                                calendarBuilders: CalendarBuilders(
                                    dowBuilder: (context, day) =>
                                        Text(Utils.toWeekDayString(day.weekday), textAlign: TextAlign.center),
                                    headerTitleBuilder: (context, day) => Text('Tháng ${day.month}',
                                        style: AppTextTheme.bodyLarge, textAlign: TextAlign.center),
                                    singleMarkerBuilder: (context, day, event) {
                                      // int type =
                                      //     event is Map<int, String> ? Map<int, String>.from(event).keys.first : -1;

                                      int type = int.parse(event.toString());
                                      return Container(
                                          decoration: BoxDecoration(
                                              color: type == 0
                                                  ? AppColor.red
                                                  : type == 1
                                                      ? AppColor.blue02
                                                      : AppColor.yellow01,
                                              shape: BoxShape.circle),
                                          height: 6,
                                          width: 6);
                                    }),
                                eventLoader: state is AppointmentGetCalendarEventSuccess
                                    ? ((day) {
                                        List<int> e = [];
                                        if (state.calendarEvent['listDateOfBirth']
                                                ?.where((element) => Utils.compareDate(DateTime.parse(element), day))
                                                .isNotEmpty ==
                                            true) {
                                          e.add(2);
                                        }
                                        if (state.calendarEvent['listAppointment']
                                                ?.where((element) => Utils.compareDate(DateTime.parse(element), day))
                                                .isNotEmpty ==
                                            true) {
                                          e.add(1);
                                        }
                                        if (state.calendarEvent['listEvent']
                                                ?.where((element) => Utils.compareDate(DateTime.parse(element), day))
                                                .isNotEmpty ==
                                            true) {
                                          e.add(0);
                                        }

                                        return e;
                                      })
                                    : null,
                                focusedDay: _focusedDay,
                                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                                headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                                lastDay: DateTime.now().add(const Duration(days: 365)),
                                locale: 'vi',
                                onDaySelected: (selectedDay, focusedDay) => Navigator.popAndPushNamed(
                                    context, AppRoute.appointment,
                                    arguments: AppointmentDetailArgs(selectedDay)),
                                onPageChanged: (focusedDay) {
                                  _focusedDay = focusedDay;
                                  cubit.getCalendarEvent(_focusedDay.month, _focusedDay.year);
                                },
                                startingDayOfWeek: StartingDayOfWeek.monday);
                          })),
                  const SizedBox(height: 14),
                  Container(
                      constraints: BoxConstraints(minWidth: context.screenWidth),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColor.gray15),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Column(children: [
                        Row(children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(context.screenWidth * 10 / 428),
                                  color: AppColor.red),
                              height: context.screenWidth * 10 / 428,
                              width: context.screenWidth * 10 / 428),
                          const SizedBox(width: 14),
                          Text('Ngày có sự kiện', style: AppTextTheme.bodyDescription.copyWith(color: AppColor.black))
                        ]),
                        const SizedBox(height: 4),
                        Row(children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(context.screenWidth * 10 / 428),
                                  color: AppColor.blue02),
                              height: context.screenWidth * 10 / 428,
                              width: context.screenWidth * 10 / 428),
                          const SizedBox(width: 14),
                          Text('Ngày có lịch hẹn', style: AppTextTheme.bodyDescription.copyWith(color: AppColor.black))
                        ]),
                        const SizedBox(height: 4),
                        Row(children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(context.screenWidth * 10 / 428),
                                  color: AppColor.yellow01),
                              height: context.screenWidth * 10 / 428,
                              width: context.screenWidth * 10 / 428),
                          const SizedBox(width: 14),
                          Text('Sinh nhật khách hàng',
                              style: AppTextTheme.bodyDescription.copyWith(color: AppColor.black))
                        ])
                      ])),
                  const SizedBox(height: 24),
                  Row(children: [
                    const Spacer(),
                    PrimaryButton(
                        backgroundColor: AppColor.blue02,
                        context: context,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoute.appointmentAdd);
                        },
                        label: 'Thêm lịch hẹn'),
                    const Spacer()
                  ])
                ])))));
  }
}

class EventItem extends StatelessWidget {
  final EventEntity event;
  late final Color backgroundColor, contentColor;

  EventItem({super.key, required this.event}) {
    final end = DateTime.parse(event.startTime ?? ''),
        now = DateTime.now(),
        start = DateTime.parse(event.startTime ?? '');

    if (now.compareTo(start) < 0) {
      backgroundColor = AppColor.yellow02;
      contentColor = AppColor.black;
    } else if (now.compareTo(end) > 0) {
      backgroundColor = AppColor.gray15;
      contentColor = AppColor.black;
    } else {
      backgroundColor = AppColor.blue02;
      contentColor = AppColor.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(width: 8),
      Expanded(
          flex: 62,
          child: Column(children: [
            const SizedBox(height: 16),
            Text(Utils.toTime(event.startTime ?? ''), style: AppTextTheme.calendarMedium, textAlign: TextAlign.center),
            if (event.endTime?.isNotEmpty == true)
              Text(Utils.toTime(event.endTime ?? ''), style: AppTextTheme.calendarRegular, textAlign: TextAlign.end),
          ])),
      const SizedBox(width: 14),
      Expanded(
          flex: 250,
          child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: backgroundColor),
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16),
              child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Sự kiện', style: AppTextTheme.titleSemiLarge.copyWith(color: contentColor)),
                  const SizedBox(height: 6),
                  Text('${event.title}', style: AppTextTheme.titleMedium.copyWith(color: contentColor)),
                  const SizedBox(height: 10),
                  Row(children: [
                    SvgPicture.asset(Assets.icClockCircle),
                    const SizedBox(width: 6),
                    Text('${Utils.toTime(event.startTime ?? '')} - ${Utils.toTime(event.endTime ?? '')}',
                        style: AppTextTheme.textPrimary.copyWith(color: contentColor))
                  ]),
                  const SizedBox(height: 6),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    SvgPicture.asset(Assets.icLocationOutline, color: AppColor.gray16),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text('${event.location}, ${event.district}, ${event.city}',
                            style: AppTextTheme.textPrimary.copyWith(color: contentColor)))
                  ])
                ])),
                PrimaryIconButton(
                    backgroundColor: backgroundColor,
                    context: context,
                    elevation: 0,
                    icon: Assets.icEllipsis,
                    iconColor: contentColor,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.eventDetail, arguments: EventDetailArgs(event));
                    })
              ]))),
      const SizedBox(width: 8)
    ]);
  }
}

class AppointmentItem extends StatelessWidget {
  final AppointmentEntity appointment;
  late final Color backgroundColor, contentColor;

  AppointmentItem({super.key, required this.appointment}) {
    final DateTime occur = DateTime.parse(appointment.dateAppointment ?? ''), now = DateTime.now();

    if (now.compareTo(occur) < 0) {
      backgroundColor = AppColor.yellow02;
      contentColor = AppColor.black;
    } else if (now.difference(occur).inMinutes <= 30) {
      backgroundColor = appointment.status == "1" ? AppColor.gray15 : AppColor.blue02;
      contentColor = appointment.status == "1" ? AppColor.black : AppColor.white;
    } else {
      backgroundColor = AppColor.red;
      contentColor = AppColor.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(width: 8),
      Expanded(
          flex: 62,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(Utils.toTime(appointment.dateAppointment ?? ''),
                  style: AppTextTheme.calendarMedium, textAlign: TextAlign.center),
            ],
          )),
      const SizedBox(width: 14),
      Expanded(
          flex: 250,
          child: Container(
              constraints: BoxConstraints(maxWidth: context.screenWidth),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: backgroundColor),
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16),
              child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Đặt lịch hẹn', style: AppTextTheme.titleSemiLarge.copyWith(color: contentColor)),
                  const SizedBox(height: 6),
                  Text(appointment.type == 0 ? 'Nội bộ' : 'Khách hàng',
                      style: AppTextTheme.titleMedium.copyWith(color: contentColor)),
                  const SizedBox(height: 6),
                  appointment.customerId != null
                      ? Text('${appointment.customerName} - ${appointment.customerPhone}',
                          style: AppTextTheme.titleMedium.copyWith(color: contentColor))
                      : Text('${appointment.employeeName} - ${appointment.position}',
                          style: AppTextTheme.titleMedium.copyWith(color: contentColor)),
                  const SizedBox(height: 10),
                  Row(children: [
                    SvgPicture.asset(Assets.icClockCircle, color: contentColor),
                    const SizedBox(width: 6),
                    Text(Utils.toTime(appointment.dateAppointment ?? ''),
                        style: AppTextTheme.titleRegular.copyWith(color: contentColor))
                  ]),
                  const SizedBox(height: 6),
                  Container(
                      constraints: BoxConstraints(maxWidth: context.screenWidth),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        SvgPicture.asset(Assets.icLocationOutline, color: contentColor),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(
                                '${appointment.location}, ${appointment.ward}, ${appointment.district}, ${appointment.province}',
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                style: AppTextTheme.bodyRegular.copyWith(color: contentColor)))
                      ]))
                ])),
                PrimaryIconButton(
                    backgroundColor: backgroundColor,
                    borderColor: backgroundColor,
                    context: context,
                    elevation: 0,
                    icon: Assets.icEllipsis,
                    iconColor: contentColor,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.appointmentAdd,
                          arguments: AppointmentAddArgs(appointment: appointment));
                    })
              ]))),
      const SizedBox(width: 8)
    ]);
  }
}
