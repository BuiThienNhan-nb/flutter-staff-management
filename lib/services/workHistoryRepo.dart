import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/workHistory.dart';

class WorkHistoryRepo {
  Stream<List<WorkHistory>> workHistoryByEmployeeStream(
      DocumentReference _doc) {
    return _doc
        .collection('workHistories')
        .orderBy('joinDate', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<WorkHistory> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(WorkHistory.fromJson(element));
      });
      return list;
    });
  }
}
