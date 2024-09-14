import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/config.dart';
import '../../../../model/notification/notification_info_response.dart';

class ItemIndividualNoti extends StatefulWidget {
  final Notifications notifications;

  const ItemIndividualNoti(this.notifications, {super.key});

  @override
  State<ItemIndividualNoti> createState() => _ItemIndividualNotiState();
}

class _ItemIndividualNotiState extends State<ItemIndividualNoti> {
  var dateFormat = DateFormat('hh:mm dd/MM/yyyy ');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(right: 10),
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
                width: MediaQuery.of(context).size.width - 180,
                child: Text(widget.notifications.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 180,
                child: Text(widget.notifications.body ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 180,
                child: Text(
                    dateFormat.format(widget.notifications.createdDate!),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: primaryColor)),
              )
            ],
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              // backgroundColor: Colors.white,
              foregroundColor: primaryColor,
              side: const BorderSide(color: primaryColor),
            ),
            child: const Text(
              "Theo dõi",
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
