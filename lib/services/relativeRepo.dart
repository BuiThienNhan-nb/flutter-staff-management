import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/relative.dart';

class RelativeRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Relative>> relativeStream() {
    return _db
        .collection('relatives')
        // .orderBy('name')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Relative> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Relative.fromJson(element));
      });
      return list;
    });
  }

  Stream<List<Relative>> relativeByEmployeeStream(DocumentReference _doc) {
    return _doc.collection('relatives').snapshots().map((QuerySnapshot query) {
      List<Relative> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Relative.fromJson(element));
      });
      return list;
    });
  }
}
