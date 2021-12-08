import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/screens/notification/notificationItem.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 60),
      child: Obx(
        () => ListView.builder(
          itemCount: notificationController.listNotifications.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: NotificationItem(
                notification: notificationController.listNotifications[index]),
          ),
        ),
      ),
    );
  }
}
