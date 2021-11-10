import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/const_value/value.dart';
import 'package:staff_management/models/addition.dart';
import 'package:staff_management/models/quota.dart';
import 'package:staff_management/models/relative.dart';
import 'package:intl/intl.dart';
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
  int salary;

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
    required this.salary,
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
      salary: 0,
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

  void calculateSalary() {
    var date = DateTime.fromMillisecondsSinceEpoch(
        workHistory[0].dismissDate.seconds * 1000);
    double workYear = (DateTime.now().year - date.year) / quota.value.duration;
    double salaryPoint = quota.value.ranks[workYear.toInt()];
    double dSalary =
        (salaryPoint + workHistory[0].position.value.allowancePoint) *
            salaryRecordController.listSalaryRecords[0].currentSalary() *
            (1 -
                ConsInsurancetValue.healthInsurance -
                ConsInsurancetValue.socialInsurance -
                ConsInsurancetValue.unemploymentInsurance);
    salary = dSalary.ceil();
  }

  int getSalaryWithAdditions() {
    int totalAddition = 0;
    addition.forEach((element) {
      if (element.isReward)
        totalAddition += element.value * 1000;
      else
        totalAddition -= element.value * 1000;
    });
    return (salary + totalAddition);
  }

  String getSalaryWithoutAdditionsToCurrency() {
    final oCcy = new NumberFormat("#,##0", "en_US");
    return "${oCcy.format(salary)} VNĐ";
  }

  String getSalaryWithAdditionsToCurrency() {
    final oCcy = new NumberFormat("#,##0", "en_US");
    return "${oCcy.format(getSalaryWithAdditions())} VNĐ";
  }

  String getBirthdateToString() {
    return DateFormat.yMMMd()
        .format(DateTime.fromMillisecondsSinceEpoch(birthdate.seconds * 1000));
  }
}
