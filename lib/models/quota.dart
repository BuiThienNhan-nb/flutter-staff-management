import 'package:cloud_firestore/cloud_firestore.dart';

class Quota {
  String uid = '';
  int duration;
  String name;
  List<double> ranks;

  Quota({
    required this.uid,
    required this.duration,
    required this.name,
    required this.ranks,
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
}
