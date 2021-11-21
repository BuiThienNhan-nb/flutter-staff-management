import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/workHistory.dart';

class WorkHistoryRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<WorkHistory>> workHistoryStream() {
    return _db
        .collection('workHistories')
        // .orderBy('name')
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
