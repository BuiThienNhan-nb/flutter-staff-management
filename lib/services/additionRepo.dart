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

  Stream<Addition> additionByIdStream(String _uid) {
    return _db.collection('additions').snapshots().map((QuerySnapshot query) {
      Addition _addition =
          Addition(uid: "uid", content: "", isReward: true, value: 0);
      for (var element in query.docs) {
        //get data
        if (element.id == _uid) {
          _addition = Addition.fromJson(element);
          break;
        }
      }
      return _addition;
    });
  }
}
