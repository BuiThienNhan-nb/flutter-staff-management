import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/quota.dart';

class QuotaRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Quota>> quotaStream() {
    return _db.collection('quotas').snapshots().map((QuerySnapshot query) {
      List<Quota> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Quota.fromJson(element));
      });
      return list;
    });
  }

  Stream<Quota> quotaByIdStream(String _uid) {
    return _db.collection('quotas').snapshots().map((QuerySnapshot query) {
      Quota _quota = Quota(uid: 'uid', duration: 0, name: '', ranks: []);
      for (var element in query.docs) {
        //get data
        if (element.id == _uid) {
          _quota = Quota.fromJson(element);
          break;
        }
      }
      return _quota;
    });
  }

  Future<void> addQuota(Quota quota) async {
    await _db
        .collection("quotas")
        .add(quota.toMap())
        .then((value) => quota.uid = value.id);
  }
}
