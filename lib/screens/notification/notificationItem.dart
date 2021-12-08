import 'package:flutter/material.dart';
import 'package:staff_management/models/notification.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  final Notifications _notification;
  const NotificationItem({Key? key, required Notifications notification})
      : _notification = notification,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${_notification.title}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Text("${_notification.description}"),
          SizedBox(height: 5),
          Text(
              "${_notification.userName} - ${DateFormat("dd/MM/yyyy HH:mm:ss").format(_notification.time.toDate())}")
        ],
      ),
    );
  }
}
