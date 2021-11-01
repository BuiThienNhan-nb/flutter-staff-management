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

        //Try to get addition document by id just retrieved

        // String currentItemId = list.last.uid;
        // Timestamp currentDate = list.last.date;
        // FirebaseFirestore.instance
        //     .collection('additions')
        //     .snapshots()
        //     .map((QuerySnapshot query) {
        //   // query.docs.forEach((elementChild)
        //   for (var elementChild in query.docs) {
        //     if (elementChild.id == list.last.additionId) {
        //       list.last = Addition.fromJson(elementChild);
        //       list.last.uid = currentItemId;
        //       list.last.additionId = elementChild.id;
        //       list.last.date = currentDate;
        //       break;
        //     }
        //   }
        // });
      });
      return list;
    });
  }

  Stream<List<Addition>> additionByEmployeeStream(List<Addition> _list) {
    // List<Addition> list = [];
    // for (var item in _list) {
    //   return _db.collection('additions').snapshots().map((QuerySnapshot query) {
    //     query.docs.forEach((element) {
    //       list.add(Addition.fromJson(element));
    //     });
    //     return list;
    //   });
    // }
    // return list;
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

      // query.docs.forEach((element) {
      //   // _list.forEach((item)
      //   for (var item in _list) {
      //     if (element.id == item.additionId) {
      //       list.add(Addition.fromJson(element));
      //       list.last.uid = item.uid;
      //       list.last.additionId = item.additionId;
      //       list.last.date = item.date;
      //       break;
      //     }
      //   }
      // });
      return newList;
    });
  }

  // Stream<Addition> additionByIdStream(String uid) {
  //   return _db
  //       .collection('additions')
  //       // .orderBy('name')
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     Addition _addition = Addition(
  //       uid: 'uid',
  //       content: '',
  //       isReward: true,
  //       value: 0,
  //     );
  //     for (var element in query.docs) {
  //       //get data
  //       if (element.id == uid) _addition = Addition.fromJson(element);
  //       break;
  //     }
  //     return _addition;
  //   });
  // }

  // Stream<List<Addition>> additionByEmployeeStream(DocumentReference _doc) {
  //   return _doc.collection('additions').snapshots().map((QuerySnapshot query) {
  //     List<Addition> list = [];
  //     query.docs.forEach((element) {
  //       // //retrieve addition by id
  //       // String uid = element.id;
  //       Map<String, dynamic>? _data = element.data() as Map<String, dynamic>?;
  //       String uid =
  //           (_data!.containsKey('additionId') && _data['additionId'] != null)
  //               ? _data['additionId'] as String
  //               : '';
  //       list.add(Addition.fromJson(element));
  //       _db.collection('additions').snapshots().map((QuerySnapshot query) {
  //         for (var element2 in query.docs) {
  //           //add to list
  //           if (element2.id == uid) {
  //             list.last = Addition.fromJson(element2);
  //             // list.add(Addition.fromJson(element2));
  //           }
  //           break;
  //         }
  //       });
  //       list.last.date = (_data.containsKey('date') && _data['date'] != null)
  //           ? _data['date'] as Timestamp
  //           : Timestamp.fromDate(DateTime.now().add(const Duration(days: 1)));
  //       // list.add(Addition.fromJson(element));
  //     });
  //     return list;
  //   });
  // }
}
