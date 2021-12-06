import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:staff_management/models/position.dart';
import 'package:staff_management/models/unit.dart';

class WorkHistory {
  String uid = '';
  Timestamp dismissDate;
  Timestamp joinDate;
  String positionId;
  String unitId;
  Rx<Position> position;
  Rx<Unit> unit;

  WorkHistory({
    required this.uid,
    required this.dismissDate,
    required this.joinDate,
    required this.positionId,
    required this.unitId,
    required this.position,
    required this.unit,
  });

  factory WorkHistory.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return WorkHistory(
      uid: doc.id,
      dismissDate:
          (data!.containsKey('dismissDate') && data['dismissDate'] != null)
              ? data['dismissDate'] as Timestamp
              : Timestamp.fromDate(DateTime.now()),
      joinDate: (data.containsKey('joinDate') && data['joinDate'] != null)
          ? data['joinDate'] as Timestamp
          : Timestamp.fromDate(DateTime.now()),
      positionId: (data.containsKey('positionId') && data['positionId'] != null)
          ? data['positionId'] as String
          : '',
      unitId: (data.containsKey('unitId') && data['unitId'] != null)
          ? data['unitId'] as String
          : '',
      position: new Position(
        uid: 'uid',
        name: '',
        // allowancePoint: 0,
        allowancePoints: {},
      ).obs,
      unit: new Unit(
        uid: 'uid',
        address: '',
        foundedDate: Timestamp.fromDate(DateTime.now()),
        hotline: '',
        name: '',
      ).obs,
    );
  }

  factory WorkHistory.clone(WorkHistory workHistory) {
    return new WorkHistory(
        uid: workHistory.uid,
        dismissDate: workHistory.dismissDate,
        joinDate: workHistory.joinDate,
        positionId: workHistory.positionId,
        unitId: workHistory.unitId,
        position: Position.clone(workHistory.position.value).obs,
        unit: Unit.clone(workHistory.unit.value).obs);
  }

  Map<String, dynamic> toMap() {
    return {
      'dismissDate': dismissDate,
      'joinDate': joinDate,
      'positionId': positionId,
      'unitId': unitId,
    };
  }
}
