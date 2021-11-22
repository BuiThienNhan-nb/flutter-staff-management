import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/services/additionRepo.dart';
import 'package:staff_management/services/quotaRepo.dart';
import 'package:staff_management/services/relativeRepo.dart';
import 'package:staff_management/services/workHistoryRepo.dart';

class EmployeeRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Employee>> employeeStream() {
    return _db.collection('employees').snapshots().map((QuerySnapshot query) {
      List<Employee> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Employee.fromJson(element));
        // list.last.quota
        //     .bindStream(QuotaRepo().quotaByIdStream(list.last.quota.value.uid));
        list.last.quotaHistories.bindStream(
            QuotaRepo().quotaHistoryByEmployeeStream(element.reference));
        list.last.addition.bindStream(
            AdditionRepo().fetchAdditionIdStream(element.reference));
        list.last.relative.bindStream(
            RelativeRepo().relativeByEmployeeStream(element.reference));
        list.last.workHistory.bindStream(
            WorkHistoryRepo().workHistoryByEmployeeStream(element.reference));
        // list.last.relative = RelativeRepo().relativeStream() as List<Relative>;
        // list.last.workHistory =
        //     WorkHistoryRepo().workHistoryStream() as List<WorkHistory>;
      });
      return list;
    });
  }

  Future<void> updateEmployee(Employee _employee) async {
    await _db
        .collection("employees")
        .doc("${_employee.uid}")
        .update(_employee.toMap());
    _employee.addition.forEach((element) async {
      await _db
          .collection("employees")
          .doc("${_employee.uid}")
          .collection("additions")
          .add(element.toChildMap());
    });
    _employee.quotaHistories.forEach((element) async {
      await _db
          .collection("employees")
          .doc("${_employee.uid}")
          .collection("quotaHistories")
          .add(element.toChildMap());
    });
    _employee.relative.forEach((element) async {
      await _db
          .collection("employees")
          .doc("${_employee.uid}")
          .collection("relatives")
          .add(element.toMap());
    });
    _employee.workHistory.forEach((element) async {
      await _db
          .collection("employees")
          .doc("${_employee.uid}")
          .collection("workHistories")
          .add(element.toMap());
    });
  }
}
