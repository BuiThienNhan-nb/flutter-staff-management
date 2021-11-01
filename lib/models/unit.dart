import 'package:cloud_firestore/cloud_firestore.dart';

class Unit {
  String uid = '';
  String address;
  Timestamp foundedDate;
  String hotline;
  String name;

  Unit({
    required this.uid,
    required this.address,
    required this.foundedDate,
    required this.hotline,
    required this.name,
  });

  factory Unit.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Unit(
      uid: doc.id,
      address: (data!.containsKey('address') && data['address'] != null)
          ? data['address'] as String
          : '',
      foundedDate:
          (data.containsKey('foundedDate') && data['foundedDate'] != null)
              ? data['foundedDate'] as Timestamp
              : Timestamp.fromDate(DateTime.now()),
      hotline: (data.containsKey('hotline') && data['hotline'] != null)
          ? data['hotline'] as String
          : '',
      name: (data.containsKey('name') && data['name'] != null)
          ? data['name'] as String
          : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'foundedDate': foundedDate,
      'hotline': hotline,
      'name': name,
    };
  }
}
