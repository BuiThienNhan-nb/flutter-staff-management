import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:staff_management/models/addition.dart';

class AdditionHistory {
  String uid = '';
  String additionId;
  Timestamp date;
  Rx<Addition> addition;

  AdditionHistory({
    required this.uid,
    required this.additionId,
    required this.date,
    required this.addition,
  });

  factory AdditionHistory.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return AdditionHistory(
      uid: doc.id,
      additionId:
          (data!.containsKey('additionId') && data['additionId'] != null)
              ? data['additionId'] as String
              : '',
      date: (data.containsKey('date') && data['date'] != null)
          ? data['date'] as Timestamp
          : Timestamp.fromDate(DateTime.now().add(const Duration(days: 1))),
      addition: new Addition(
        uid: "uid",
        content: "",
        isReward: true,
        value: 0,
      ).obs,
    );
  }

  factory AdditionHistory.clone(AdditionHistory additionHistory) {
    return new AdditionHistory(
        uid: additionHistory.uid,
        additionId: additionHistory.additionId,
        date: additionHistory.date,
        addition: Addition.clone(additionHistory.addition.value).obs);
  }

  Map<String, dynamic> toMap() {
    return {
      'additionId': additionId,
      'date': date,
    };
  }

  DateTime getDate() {
    return date.toDate();
  }
}
