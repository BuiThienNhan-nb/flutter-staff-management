import 'package:cloud_firestore/cloud_firestore.dart';

class Position {
  String uid = '';
  String name;
  double allowancePoint;

  Position(
      {required this.uid, required this.name, required this.allowancePoint});

  factory Position.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Position(
      uid: doc.id,
      name: (data!.containsKey('name') && data['name'] != null)
          ? data['name'] as String
          : '',
      allowancePoint:
          (data.containsKey('allowancePoint') && data['allowancePoint'] != null)
              ? data['allowancePoint'] as double
              : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'allowancePoint': allowancePoint,
    };
  }
}
