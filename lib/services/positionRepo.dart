import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/position.dart';

class PositionRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Position>> positionStream() {
    return _db
        .collection('positions')
        // .orderBy('name')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Position> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Position.fromJson(element));
      });
      return list;
    });
  }

  Stream<Position> positionByIdStream(String _uid) {
    return _db.collection('positions').snapshots().map((QuerySnapshot query) {
      Position _position = Position(
        uid: 'uid',
        name: '',
        allowancePoint: 0.0,
      );
      for (var element in query.docs) {
        //get data
        if (element.id == _uid) {
          _position = Position.fromJson(element);
          break;
        }
      }
      return _position;
    });
  }
}
