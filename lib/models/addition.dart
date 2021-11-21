import 'package:cloud_firestore/cloud_firestore.dart';

class Addition {
  String uid = '';
  String content;
  bool isReward;
  int value;
  Timestamp date;
  String additionId;

  Addition({
    required this.uid,
    required this.content,
    required this.isReward,
    required this.value,
    required this.date,
    required this.additionId,
  });

  factory Addition.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Addition(
      uid: doc.id,
      content: (data!.containsKey('content') && data['content'] != null)
          ? data['content'] as String
          : '',
      isReward: (data.containsKey('isReward') && data['isReward'] != null)
          ? data['isReward'] as bool
          : true,
      value: (data.containsKey('value') && data['value'] != null)
          ? data['value'] as int
          : 0,
      date: (data.containsKey('date') && data['date'] != null)
          ? data['date'] as Timestamp
          : Timestamp.fromDate(DateTime.now().add(const Duration(days: 1))),
      additionId: (data.containsKey('additionId') && data['additionId'] != null)
          ? data['additionId'] as String
          : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'isReward': isReward,
      'value': value,
    };
  }

  Map<String, dynamic> toChildMap() {
    return {
      'additionId': additionId,
      'date': date,
    };
  }

  DateTime getDate() {
    return DateTime.fromMillisecondsSinceEpoch(date.seconds * 1000);
  }
}
