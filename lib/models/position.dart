import 'package:cloud_firestore/cloud_firestore.dart';

class Position {
  String uid = '';
  String name;
  // double allowancePoint;
  Map<String, num> allowancePoints;

  Position(
      {required this.uid,
      required this.name,
      // required this.allowancePoint,
      required this.allowancePoints});

  factory Position.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Position(
      uid: doc.id,
      name: (data!.containsKey('name') && data['name'] != null)
          ? data['name'] as String
          : '',
      // allowancePoint:
      //     (data.containsKey('allowancePoint') && data['allowancePoint'] != null)
      //         ? data['allowancePoint'] as double
      //         : 0.0,
      allowancePoints: (data.containsKey('allowancePoints') &&
              data['allowancePoints'] != null)
          ? new Map<String, num>.from(data['allowancePoints'])
          : {},
    );
  }

  factory Position.clone(Position position) {
    return new Position(
        uid: position.uid,
        name: position.name,
        // allowancePoint: position.allowancePoint,
        allowancePoints: position.allowancePoints);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'allowancePoints': allowancePoints,
    };
  }
}
