import 'package:cloud_firestore/cloud_firestore.dart';

class Addition {
  String uid = '';
  String content;
  bool isReward;
  int value;

  Addition({
    required this.uid,
    required this.content,
    required this.isReward,
    required this.value,
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'isReward': isReward,
      'value': value,
    };
  }
}
