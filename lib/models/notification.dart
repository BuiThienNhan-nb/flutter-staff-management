import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {
  String uid = "";
  String title;
  String description;
  String userName;
  Timestamp time;

  Notifications({
    required this.uid,
    required this.title,
    required this.description,
    required this.userName,
    required this.time,
  });

  factory Notifications.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Notifications(
      uid: doc.id,
      title: (data!.containsKey('title') && data['title'] != null)
          ? data['title'] as String
          : '',
      description:
          (data.containsKey('description') && data['description'] != null)
              ? data['description'] as String
              : "",
      userName: (data.containsKey('userName') && data['userName'] != null)
          ? data['userName'] as String
          : "",
      time: (data.containsKey('time') && data['time'] != null)
          ? data['time'] as Timestamp
          : Timestamp.fromDate(DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'userName': userName,
      'time': time,
    };
  }
}
