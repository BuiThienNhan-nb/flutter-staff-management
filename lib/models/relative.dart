import 'package:cloud_firestore/cloud_firestore.dart';

class Relative {
  String uid = '';
  Timestamp birthdate;
  String job;
  String name;
  String type;

  Relative({
    required this.uid,
    required this.birthdate,
    required this.job,
    required this.name,
    required this.type,
  });

  factory Relative.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Relative(
      uid: doc.id,
      birthdate: (data!.containsKey('birthdate') && data['birthdate'] != null)
          ? data['birthdate'] as Timestamp
          : Timestamp.fromDate(DateTime.now()),
      job: (data.containsKey('job') && data['job'] != null)
          ? data['job'] as String
          : '',
      name: (data.containsKey('name') && data['name'] != null)
          ? data['name'] as String
          : '',
      type: (data.containsKey('type') && data['type'] != null)
          ? data['type'] as String
          : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'birthdate': birthdate,
      'job': job,
      'name': name,
      'type': type,
    };
  }
}
