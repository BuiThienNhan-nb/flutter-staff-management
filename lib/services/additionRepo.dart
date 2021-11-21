import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/addition.dart';

class AdditionRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Addition>> additionStream() {
    return _db
        .collection('additions')
        // .orderBy('name')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Addition> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Addition.fromJson(element));
      });
      return list;
    });
  }

  Stream<List<Addition>> fetchAdditionIdStream(DocumentReference _doc) {
    return _doc.collection('additions').snapshots().map((QuerySnapshot query) {
      List<Addition> list = [];
      query.docs.forEach((element) {
        list.add(Addition.fromJson(element));
      });
      return list;
    });
  }

  Stream<List<Addition>> additionByEmployeeStream(List<Addition> _list) {
    return _db.collection('additions').snapshots().map((QuerySnapshot query) {
      List<Addition> newList = [];
      _list.forEach((element) {
        for (var item in query.docs) {
          if (element.additionId == item.id) {
            newList.add(Addition.fromJson(item));
            newList.last.uid = element.uid;
            newList.last.additionId = item.id;
            newList.last.date = element.date;
            break;
          }
        }
      });
      return newList;
    });
  }
}
