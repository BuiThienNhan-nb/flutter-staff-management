import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/salaryRecords.dart';

class SalaryRecordRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<SalaryRecord>> salaryRecordStream() {
    return _db
        .collection('salaryRecords')
        .orderBy('year')
        .snapshots()
        .map((QuerySnapshot query) {
      List<SalaryRecord> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(SalaryRecord.fromJson(element));
      });
      return list;
    });
  }
}
