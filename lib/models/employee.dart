import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:staff_management/models/addition.dart';
import 'package:staff_management/models/quota.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/models/salaryRecords.dart';
import 'package:staff_management/models/workHistory.dart';

class Employee {
  String uid = '';
  String address;
  Timestamp birthdate;
  String folk;
  String identityCard;
  String name;
  Rx<Quota> quota;
  Timestamp retirementDate;
  String sex;
  Timestamp workDate;
  RxList<Relative> relative;
  RxList<WorkHistory> workHistory;
  RxList<Addition> addition;

  Employee({
    required this.uid,
    required this.address,
    required this.birthdate,
    required this.folk,
    required this.identityCard,
    required this.name,
    required this.quota,
    required this.retirementDate,
    required this.sex,
    required this.workDate,
    required this.relative,
    required this.workHistory,
    required this.addition,
  });

  factory Employee.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Employee(
      uid: doc.id,
      birthdate: (data!.containsKey('birthdate') && data['birthdate'] != null)
          ? data['birthdate'] as Timestamp
          : Timestamp.fromDate(DateTime.now()),
      address: (data.containsKey('address') && data['address'] != null)
          ? data['address'] as String
          : '',
      folk: (data.containsKey('folk') && data['folk'] != null)
          ? data['folk'] as String
          : '',
      identityCard:
          (data.containsKey('identityCard') && data['identityCard'] != null)
              ? data['identityCard'] as String
              : '',
      name: (data.containsKey('name') && data['name'] != null)
          ? data['name'] as String
          : '',
      quota: (data.containsKey('quotaId') && data['quotaId'] != null)
          ? new Quota(
              uid: data['quotaId'] as String,
              duration: 0,
              name: '',
              ranks: []).obs
          : new Quota(uid: 'uid', duration: 0, name: '', ranks: []).obs,
      // ? Quota(
      //     uid: data['quotaId'] as String,
      //     duration: 0,
      //     name: '',
      //     ranks: [],
      //   ).obs
      // : Quota(
      //     uid: 'uid',
      //     duration: 0,
      //     name: '',
      //     ranks: [],
      //   ),
      retirementDate:
          (data.containsKey('retirementDate') && data['retirementDate'] != null)
              ? data['retirementDate'] as Timestamp
              : Timestamp.fromDate(DateTime.now()),
      sex: (data.containsKey('sex') && data['sex'] != null)
          ? data['sex'] as String
          : '',
      workDate: (data.containsKey('workDate') && data['workDate'] != null)
          ? data['workDate'] as Timestamp
          : Timestamp.fromDate(DateTime.now()),
      relative: <Relative>[].obs,
      // workHistory: WorkHistory(
      //     uid: '',
      //     dismissDate: Timestamp.fromDate(DateTime.now()),
      //     joinDate: Timestamp.fromDate(DateTime.now()),
      //     positionId: '',
      //     unitId: ''),
      workHistory: <WorkHistory>[].obs,
      addition: <Addition>[].obs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'birthdate': birthdate,
      'folk': folk,
      'identityCard': identityCard,
      'name': name,
      'quotaId': quota.value.uid,
      'retirementDate': retirementDate,
      'sex': sex,
      'workDate': workDate,
    };
  }

  double getSalaryWithoutAdditions() {
    // int _currentminimumSalary;
    // SalaryRecord _salaryRecord;
    // switch (DateTime.now().month) {
    //   case 1:
    //   case 2:
    //   case 3:
    //     _currentminimumSalary = _salaryRecord.minimumSalary[0];
    //     break;
    //   default:
    // }
    return 0.0;
  }
}
