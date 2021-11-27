import 'package:cloud_firestore/cloud_firestore.dart';

class Quota {
  String uid = '';
  // String qhId;
  int duration;
  String name;
  List<double> ranks;
  // Timestamp joinDate;
  // Timestamp dismissDate;

  Quota({
    required this.uid,
    // required this.qhId,
    required this.duration,
    required this.name,
    required this.ranks,
    // required this.joinDate,
    // required this.dismissDate,
  });

  factory Quota.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Quota(
      uid: doc.id,
      duration: (data!.containsKey('duration') && data['duration'] != null)
          ? data['duration'] as int
          : 0,
      name: (data.containsKey('name') && data['name'] != null)
          ? data['name'] as String
          : '',
      ranks: (data.containsKey('ranks') && data['ranks'] != null)
          ? (data['ranks'] as List<dynamic>).cast<double>()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'duration': duration,
      'name': name,
      'ranks': ranks,
    };
  }

  // Map<String, dynamic> toChildMap() {
  //   return {
  //     'quotaId': uid,
  //     'joinDate': joinDate,
  //     'dismissDate': dismissDate,
  //   };
  // }
}
