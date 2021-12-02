import 'package:get/get.dart';
import 'package:staff_management/const_value/value.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/models/quotaHistories.dart';
import 'package:staff_management/models/salaryRecords.dart';
import 'package:staff_management/models/workHistory.dart';
import 'package:staff_management/services/salaryRecordRepo.dart';

class SalaryRecordController extends GetxController {
  static SalaryRecordController instance = Get.find();

  RxList<SalaryRecord> _listSalaryRecord = <SalaryRecord>[].obs;

  //get function
  List<SalaryRecord> get listSalaryRecords => _listSalaryRecord.value;

  @override
  void onInit() {
    super.onInit();
    _listSalaryRecord.bindStream(SalaryRecordRepo().salaryRecordStream());
  }

  List<int> calculateYearSalary(Employee employee, int year,
      List<WorkHistory> position, List<QuotaPoint> quota) {
    List<int> ySalary = [];
    int baseSalary = listSalaryRecords
            .firstWhere((element) => element.year == year)
            .baseSalary *
        1000;
    for (int i = 0; i < 12; i++) {
      ySalary.add(0);
    }
    if (position.length == 0 && quota.length == 0) {
      // if in this year, this employee don't have any position and quota
    } else if (position.length == 1 && quota.length == 1) {
      // if in this year, this employee just has only one position and quota
      for (int i = 11; i >= 0; i--) {
        ySalary[i] = calculateMonthSalary(
                position.first.position.value.allowancePoints["$year"]! +
                    quota.first.quotaPoint,
                baseSalary)
            .ceil();
      }
    } else if (position.length == 1) {
      // if in this year, this employee just has only one position
      int quotaIndex = 0;
      for (int i = 11; i >= 0; i--) {
        if (i == (quota[quotaIndex].joinDate.month - 2)) {
          quotaIndex++;
        }
        ySalary[i] = calculateMonthSalary(
                position.first.position.value.allowancePoints["$year"]! +
                    quota[quotaIndex].quotaPoint,
                baseSalary)
            .ceil();
      }
    } else if (quota.length == 1) {
      // if in this year, this employee just has only one quota
      int positionIndex = 0;
      for (int i = 11; i >= 0; i--) {
        if (i == (position[positionIndex].joinDate.toDate().month - 2)) {
          positionIndex++;
        }
        ySalary[i] = calculateMonthSalary(
                position[positionIndex]
                        .position
                        .value
                        .allowancePoints["$year"]! +
                    quota.first.quotaPoint,
                baseSalary)
            .ceil();
      }
    } else {
      int positionIndex = 0;
      int quotaIndex = 0;
      int salaryIndex = 11;
      while (positionIndex < position.length - 1 &&
          quotaIndex < quotaIndex - 1 &&
          salaryIndex >= 0) {
        if (salaryIndex == (quota[quotaIndex].joinDate.month - 2)) {
          quotaIndex++;
        } else if (salaryIndex ==
            (position[positionIndex].joinDate.toDate().month - 2)) {
          positionIndex++;
        }
        ySalary[salaryIndex] = calculateMonthSalary(
                position[positionIndex]
                        .position
                        .value
                        .allowancePoints["$year"]! +
                    quota[quotaIndex].quotaPoint,
                baseSalary)
            .ceil();
        salaryIndex--;
      }
    }
    if (employee.workDate.toDate().year == year) {
      for (int i = 0; i < employee.workDate.toDate().month - 1; i++) {
        ySalary[i] = 0;
      }
    }
    return ySalary;
  }

  // String calculateYearSalaryToString(Employee employee, int year) {
  //   double dSalary = 0.0;
  //   final oCcy = new NumberFormat("#,##0", "en_US");

  //   return "${oCcy.format(dSalary.ceil())} VNĐ";
  // }

  double calculateMonthSalary(double point, int baseSalary) {
    return point *
        baseSalary *
        (1 -
            ConsInsurancetValue.healthInsurance -
            ConsInsurancetValue.socialInsurance -
            ConsInsurancetValue.unemploymentInsurance);
  }
}
