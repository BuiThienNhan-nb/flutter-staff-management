import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/quota.dart';

class QuotaRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Quota>> quotaStream() {
    return _db
        .collection('quotas')
        // .orderBy('name')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Quota> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Quota.fromJson(element));
      });
      return list;
    });
  }

  Stream<List<Quota>> quotaHistoryByEmployeeStream(DocumentReference _doc) {
    return _doc
        .collection('quotaHistories')
        .orderBy('joinDate', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Quota> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Quota.fromJson(element));
      });
      return list;
    });
  }

  Stream<List<Quota>> listQuotaByEmployeeStream(List<Quota> _list) {
    return _db.collection('quotas').snapshots().map((QuerySnapshot query) {
      List<Quota> newList = [];
      _list.forEach((element) {
        for (var item in query.docs) {
          if (element.qhId == item.id) {
            String currentId = element.uid;
            newList.add(Quota.fromJson(item));
            newList.last.qhId = currentId;
            break;
          }
          if (element.uid == item.id) {
            newList.add(Quota.fromJson(item));
            break;
          }
        }
      });
      return newList;
    });
  }
}
