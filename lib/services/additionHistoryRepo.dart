import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/additionHistory.dart';

class AdditionHistoryRepo {
  Stream<List<AdditionHistory>> additionHistoryStream(DocumentReference _doc) {
    return _doc
        .collection('additions')
        // .orderBy('name')
        .snapshots()
        .map((QuerySnapshot query) {
      List<AdditionHistory> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(AdditionHistory.fromJson(element));
      });
      return list;
    });
  }
}
