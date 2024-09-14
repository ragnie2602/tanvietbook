import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../data/resources/resources.dart';
import '../../../model/notification/notification_detail_response.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/back_button.dart';
import '../../../shared/widgets/quill/primary_editor.dart';

class NotificationDetailPageArgs {
  final NotificationDetailResponse notificationDetailResponse;

  NotificationDetailPageArgs({required this.notificationDetailResponse});
}

class NotificationDetailPage extends StatelessWidget {
  static const String routeName = '/noti-detail';
  final NotificationDetailResponse notificationDetailResponse;
  const NotificationDetailPage(
      {super.key, required this.notificationDetailResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              opacity: .7,
              image: Image.asset(Assets.imBackgroundNotificationDetail).image)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const PrimaryAppBar(
            //   title: 'Chi tiết thông báo',
            // ),
            const Row(
              children: [
                BackButtonCustom(),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Chi tiết thông báo',
                  style: AppTextTheme.titleMedium,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Utils.isToday(
                          notificationDetailResponse.createdDate ?? '')
                      ? 'Hôm nay'
                      : Utils.formatDate(
                          notificationDetailResponse.createdDate ?? '')),
                  const SizedBox(
                    height: 16,
                  ),
                  // Text(
                  //   notificationDetailResponse.title ?? '',
                  //   style: AppTextTheme.titleMedium,
                  // ),
                  (notificationDetailResponse.title ?? '').contains('"ops":') &&
                          (notificationDetailResponse.title ?? '')
                              .contains('[') &&
                          (notificationDetailResponse.title ?? '').contains('{')
                      ? PrimaryEditor(
                          controller: QuillController.basic()
                            ..document = Utils.parseQuillDocument(
                                notificationDetailResponse.title),
                          readOnly: true,
                          limitCharactor: 100,
                        )
                      : HtmlWidget(
                          notificationDetailResponse.title ?? '',
                          // customWidgetBuilder: (element) {
                          //   return const InlineCustomWidget(
                          //       child: CircleAvatar(),
                          //       );
                          // },
                          textStyle: AppTextTheme.titleMedium.copyWith(),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  (notificationDetailResponse.body ?? '').contains('"ops":') &&
                          (notificationDetailResponse.body ?? '')
                              .contains('[') &&
                          (notificationDetailResponse.body ?? '').contains('{')
                      ? PrimaryEditor(
                          controller: QuillController.basic()
                            ..document = Utils.parseQuillDocument(
                                notificationDetailResponse.body),
                          readOnly: true,
                        )
                      : HtmlWidget(
                          notificationDetailResponse.body ?? '',
                          textStyle: AppTextTheme.bodyRegular.copyWith(),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  // ...notificationDetailResponse.images
                  //         ?.map((e) => Column(
                  //               children: [
                  //                 PrimaryNetworkImage(imageUrl: e),
                  //                 const SizedBox(
                  //                   height: 16,
                  //                 ),
                  //               ],
                  //             ))
                  //         .toList() ??
                  //     []
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
