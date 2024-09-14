import 'package:flutter/material.dart';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import '../../shared/etx/view_extensions.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/no_data.dart';
import '../../shared/widgets/primary_app_bar.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/primary_icon_button.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({super.key});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late EventDetailArgs args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = context.arguments as EventDetailArgs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimaryAppBar(actions: [
          PrimaryIconButton(
              context: context,
              elevation: 0,
              height: context.screenWidth * 20 / 375,
              icon: Icons.share_outlined,
              iconColor: AppColor.blue04,
              onPressed: () {},
              width: context.screenWidth * 20 / 375)
        ], centerTitle: true, elevation: 0, leading: const BackButton(), title: 'Chi tiết sự kiện'),
        backgroundColor: AppColor.white,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${args.event.title}', style: AppTextTheme.titleMedium),
                  const SizedBox(height: 14),
                  Center(
                      child:
                          args.event.picture != null ? Image.network(args.event.picture!, height: context.screenWidth * 138 / 375) : const NoData(message: 'Không tìm được ảnh')),
                  const SizedBox(height: 14),
                  RichText(
                      text: TextSpan(
                          text: 'Ngày diễn ra: ',
                          style: AppTextTheme.titleRegular,
                          children: [TextSpan(text: Utils.toStringDate(args.event.date ?? ''), style: AppTextTheme.bodyRegular.copyWith(fontWeight: FontWeight.w400))])),
                  const SizedBox(height: 14),
                  RichText(
                      text: TextSpan(text: 'Thời gian: ', style: AppTextTheme.titleRegular, children: [
                    TextSpan(
                        text: '${Utils.toTime(args.event.startTime ?? '', letterDivider: true)} - ${Utils.toTime(args.event.endTime ?? '', letterDivider: true)}',
                        style: AppTextTheme.bodyRegular.copyWith(fontWeight: FontWeight.w400))
                  ])),
                  const SizedBox(height: 14),
                  RichText(
                      text: TextSpan(text: 'Địa điểm: ', style: AppTextTheme.titleRegular, children: [
                    TextSpan(
                        text: '${args.event.location}, ${args.event.town}, ${args.event.district}, ${args.event.city}',
                        style: AppTextTheme.bodyRegular.copyWith(fontWeight: FontWeight.w400))
                  ])),
                  const SizedBox(height: 14),
                  Text('${args.event.description}', style: AppTextTheme.bodyMedium.copyWith(fontWeight: FontWeight.w400)),
                  const SizedBox(height: 14),
                  RichText(
                      text: TextSpan(
                          text: 'Chi tiết sự kiện xem tại: ',
                          style: AppTextTheme.titleRegular,
                          children: [TextSpan(text: '${args.event.note}', style: AppTextTheme.bodyRegular.copyWith(color: AppColor.blue02, fontWeight: FontWeight.w400))])),
                  const SizedBox(height: 14),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    PrimaryButton(
                        backgroundColor: AppColor.white,
                        borderColor: AppColor.green01,
                        context: context,
                        elevation: 0,
                        onPressed: () {},
                        label: 'Quan tâm',
                        textStyle: AppTextTheme.subTitle1),
                    const SizedBox(width: 10),
                    PrimaryButton(
                        backgroundColor: AppColor.green01, context: context, onPressed: () {}, label: 'Đăng ký', textStyle: AppTextTheme.subTitle1.copyWith(color: AppColor.white)),
                    const SizedBox(width: 10),
                    PrimaryButton(context: context, onPressed: () {}, label: 'Từ chối', textStyle: AppTextTheme.subTitle1.copyWith(color: AppColor.white))
                  ]),
                  const SizedBox(height: 14),
                  Center(
                    child: args.event.status == 2
                        ? Text('Bạn đã đăng ký tham gia sự kiện này!', style: AppTextTheme.bodyMedium.copyWith(color: AppColor.green01))
                        : args.event.status == 3
                            ? Text('Bạn đã quan tâm sự kiẹn này!', style: AppTextTheme.bodyMedium.copyWith(color: AppColor.green01))
                            : Container(),
                  )
                ]))));
  }
}
