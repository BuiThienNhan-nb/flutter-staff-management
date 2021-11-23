import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/quotaHistories.dart';

class QuotaHistoryRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<QuotaHistory>> quotaHistoryByEmployeeStream(
      DocumentReference _doc) {
    return _doc
        .collection('quotaHistories')
        .orderBy('joinDate', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<QuotaHistory> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(QuotaHistory.fromJson(element));
      });
      return list;
    });
  }
}
