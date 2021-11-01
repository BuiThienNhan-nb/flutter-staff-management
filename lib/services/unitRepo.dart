import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/unit.dart';

class UnitRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Unit>> unitStream() {
    return _db.collection('units').snapshots().map((QuerySnapshot query) {
      List<Unit> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Unit.fromJson(element));
      });
      return list;
    });
  }

  Stream<Unit> unitByIdStream(String _uid) {
    return _db.collection('units').snapshots().map((QuerySnapshot query) {
      Unit _unit = Unit(
        uid: 'uid',
        address: '',
        foundedDate: Timestamp.fromDate(DateTime.now()),
        hotline: '',
        name: '',
      );
      for (var element in query.docs) {
        //get data
        if (element.id == _uid) {
          _unit = Unit.fromJson(element);
          break;
        }
      }
      return _unit;
    });
  }
}
