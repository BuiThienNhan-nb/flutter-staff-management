import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:staff_management/models/quota.dart';

class QuotaHistory {
  String uid = '';
  String quotaId;
  Timestamp joinDate;
  Timestamp dismissDate;
  Rx<Quota> quota;

  QuotaHistory({
    required this.uid,
    required this.quotaId,
    required this.joinDate,
    required this.dismissDate,
    required this.quota,
  });

  factory QuotaHistory.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return QuotaHistory(
      uid: doc.id,
      quotaId: (data!.containsKey('quotaId') && data['quotaId'] != null)
          ? data['quotaId'] as String
          : '',
      joinDate: (data.containsKey('joinDate') && data['joinDate'] != null)
          ? data['joinDate'] as Timestamp
          : Timestamp.fromDate(DateTime.now().add(const Duration(days: 1))),
      dismissDate:
          (data.containsKey('dismissDate') && data['dismissDate'] != null)
              ? data['dismissDate'] as Timestamp
              : Timestamp.fromDate(DateTime.now()),
      quota: new Quota(uid: 'uid', duration: 0, name: '', ranks: []).obs,
    );
  }

  factory QuotaHistory.clone(QuotaHistory quotaHistory) {
    return new QuotaHistory(
        uid: quotaHistory.uid,
        quotaId: quotaHistory.quotaId,
        joinDate: quotaHistory.joinDate,
        dismissDate: quotaHistory.dismissDate,
        quota: Quota.clone(quotaHistory.quota.value).obs);
  }

  List<QuotaHistory> quotasInRange(
      List<QuotaHistory> list, DateTime begin, DateTime end) {
    List<QuotaHistory> _newList = [];
    int index = 0;
    if (list[index].joinDate.toDate().isBefore(end)) {}
    // for (var item in list) {
    //   if (item.)
    // }
    return [];
  }

  Map<String, dynamic> toMap() {
    return {
      'quotaId': quotaId,
      'joinDate': joinDate,
      'dismissDate': dismissDate,
    };
  }
}
