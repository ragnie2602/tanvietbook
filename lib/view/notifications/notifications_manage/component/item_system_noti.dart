import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/config.dart';
import '../../../../model/notification/notification_info_response.dart';
import '../../notifications_detail/notifications_detail.dart';

class ItemSystemNoti extends StatefulWidget {
  final Notifications notifications;

  const ItemSystemNoti(this.notifications, {super.key});

  @override
  State<ItemSystemNoti> createState() => _ItemSystemNotiState();
}

class _ItemSystemNotiState extends State<ItemSystemNoti> {
  var dateFormat = DateFormat('hh:mm dd/MM/yyyy ');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // var hubConnection = NotificationHelper.instance.hubConnection;
        // hubConnection.invoke("UpdateSeenOneNotification", args: <Object>[
        //   {"notificationId": widget.notifications.id}
        // ]);
        setState(() {
          widget.notifications.isSeen = true;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NotificationsDetail(widget.notifications)));
      },
      child: Container(
        padding: const EdgeInsets.only(right: 10, top: 3, bottom: 3),
        decoration: BoxDecoration(
            color: widget.notifications.isSeen == true
                ? Colors.white
                : const Color.fromRGBO(21, 207, 170, 0.2),
            border:
                const Border(top: BorderSide(width: 0.5, color: Colors.grey))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                padding: const EdgeInsets.all(18),
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/blank.jpg"),
                  radius: 20,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
                  child: Text(widget.notifications.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
                  child: Text(widget.notifications.body ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: primaryColor,
                      size: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      width: MediaQuery.of(context).size.width - 110,
                      child: Text(
                          dateFormat.format(widget.notifications.createdDate!),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: primaryColor)),
                    ),
                  ],
                )
              ],
            ),
            // const Spacer(),
            // const Icon(Icons.more_horiz)
          ],
        ),
      ),
    );
  }
}
