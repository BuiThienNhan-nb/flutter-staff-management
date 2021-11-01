import 'package:cloud_firestore/cloud_firestore.dart';

class SalaryRecord {
  String uid = '';
  List<int> minimumSalary;
  int year;

  SalaryRecord({
    required this.uid,
    required this.minimumSalary,
    required this.year,
  });

  factory SalaryRecord.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return SalaryRecord(
      uid: doc.id,
      minimumSalary:
          (data!.containsKey('minimumSalary') && data['minimumSalary'] != null)
              ? (data['minimumSalary'] as List<dynamic>).cast<int>()
              : [],
      year: (data.containsKey('year') && data['year'] != null)
          ? data['year'] as int
          : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'minimumSalary': minimumSalary,
      'year': year,
    };
  }

  int currentSalary() {
    switch (DateTime.now().month) {
      case 4:
      case 5:
      case 6:
        return minimumSalary[1];
      case 7:
      case 8:
      case 9:
        return minimumSalary[2];
      case 10:
      case 11:
      case 12:
        return minimumSalary[3];
      default:
        return minimumSalary[0];
    }
  }
}
