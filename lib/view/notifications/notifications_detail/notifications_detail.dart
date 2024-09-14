// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../config/config.dart';
import '../../../model/notification/notification_info_response.dart';
import '../../../shared/widgets/primary_app_bar.dart';
import '../../user_profile/user_profile.dart';

import '../../../data/constants.dart';

class NotificationsDetail extends StatefulWidget {
  Notifications notifications;

  NotificationsDetail(this.notifications, {super.key});

  @override
  State<NotificationsDetail> createState() => _NotificationsDetailState();
}

class _NotificationsDetailState extends State<NotificationsDetail> {
  var dateFormat = DateFormat('hh:mm dd/MM/yyyy ');
  bool hasLink = false;
  String body = "", link = "";

  @override
  void initState() {
    super.initState();
    if (widget.notifications.body != null &&
        widget.notifications.body!.contains(Environment.domain)) {
      hasLink = true;
      int i = widget.notifications.body!.indexOf(Environment.domain);
      body = widget.notifications.body!.substring(0, i);
      link = widget.notifications.body!.substring(i);
    } else {
      body = widget.notifications.body ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        title: "Thông báo hệ thống",
        canPop: true,
      ),
      body: SafeArea(
        child: Container(
          color: bgColor,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width - 20,
                child: Text(widget.notifications.title ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    color: primaryColor,
                    size: 14,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    child: Text(
                        dateFormat.format(widget.notifications.createdDate!),
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: primaryColor)),
                  ),
                ],
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: RichText(
                    text: TextSpan(
                        text: body,
                        style: const TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  // log(link.substring(baseLink.length));
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserProfile(
                                                viewType: ViewType.viewOwn,
                                                memberUserName: link.substring({
                                                      Environment.domain
                                                    }.length +
                                                    9),
                                              )));
                                },
                              text: link,
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w400))
                        ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
