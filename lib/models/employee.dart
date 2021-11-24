import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/const_value/value.dart';
import 'package:staff_management/models/additionHistory.dart';
import 'package:staff_management/models/quotaHistories.dart';
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
  RxList<QuotaHistory> quotaHistory;
  Timestamp retirementDate;
  String sex;
  Timestamp workDate;
  RxList<Relative> relative;
  RxList<WorkHistory> workHistory;
  RxList<AdditionHistory> additionHistory;
  int salary;

  Employee({
    required this.uid,
    required this.address,
    required this.birthdate,
    required this.folk,
    required this.identityCard,
    required this.name,
    required this.quotaHistory,
    required this.retirementDate,
    required this.sex,
    required this.workDate,
    required this.relative,
    required this.workHistory,
    required this.additionHistory,
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
      // quota: (data.containsKey('quotaId') && data['quotaId'] != null)
      //     ? new Quota(
      //         uid: data['quotaId'] as String,
      //         duration: 0,
      //         name: '',
      //         ranks: []).obs
      //     : new Quota(uid: 'uid', duration: 0, name: '', ranks: []).obs,
      quotaHistory: <QuotaHistory>[].obs,
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
      workHistory: <WorkHistory>[].obs,
      additionHistory: <AdditionHistory>[].obs,
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
      'retirementDate': retirementDate,
      'sex': sex,
      'workDate': workDate,
    };
  }

  void calculateSalary() {
    salary = 0;
    var date = DateTime.fromMillisecondsSinceEpoch(
        workHistory[0].dismissDate.seconds * 1000);
    double workYear = (DateTime.now().year - date.year) /
        quotaHistory.first.quota.value.duration;
    double salaryPoint = quotaHistory.first.quota.value.ranks[workYear.toInt()];
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
    // additionHistory.forEach((element) {
    //   if (element.getDate().month == DateTime.now().month) {
    //     if (element.addition.value.isReward)
    //       totalAddition += element.addition.value.value * 1000;
    //     else
    //       totalAddition -= element.addition.value.value * 1000;
    //   }
    // });
    for (var element in additionHistory) {
      if (element.getDate().month == DateTime.now().month) {
        if (element.addition.value.isReward)
          totalAddition += element.addition.value.value * 1000;
        else
          totalAddition -= element.addition.value.value * 1000;
      } else {
        break;
      }
    }
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
