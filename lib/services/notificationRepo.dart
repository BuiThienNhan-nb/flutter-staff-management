import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/notification.dart';

class NotificationRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Notifications>> notificationStream() {
    return _db
        .collection('notifications')
        .orderBy('time', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Notifications> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Notifications.fromJson(element));
      });
      return list;
    });
  }

  Future<void> addNotification(Notifications notification) async {
    await _db
        .collection("notifications")
        .add(notification.toMap())
        .then((value) => notification.uid = value.id);
  }
}
