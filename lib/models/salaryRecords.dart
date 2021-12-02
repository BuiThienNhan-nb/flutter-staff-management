import 'package:cloud_firestore/cloud_firestore.dart';

class SalaryRecord {
  String uid = '';
  int year;
  int baseSalary;

  SalaryRecord({
    required this.uid,
    required this.year,
    required this.baseSalary,
  });

  factory SalaryRecord.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return SalaryRecord(
      uid: doc.id,
      year: (data!.containsKey('year') && data['year'] != null)
          ? data['year'] as int
          : 0,
      baseSalary: (data.containsKey('baseSalary') && data['baseSalary'] != null)
          ? data['baseSalary'] as int
          : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'baseSalary': baseSalary,
    };
  }
}
