import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/services/additionHistoryRepo.dart';
import 'package:staff_management/services/quotaHistoryRepo.dart';
import 'package:staff_management/services/relativeRepo.dart';
import 'package:staff_management/services/workHistoryRepo.dart';

class EmployeeRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static Employee employee = Employee(
      uid: '',
      name: '',
      address: '',
      additionHistory: null,
      birthdate: null,
      folk: '',
      identityCard: '',
      quotaHistory: null,
      relative: null,
      retirementDate: null,
      salary: 0,
      sex: '',
      workDate: null,
      workHistory: null);
  Stream<List<Employee>> employeeStream() {
    return _db.collection('employees').snapshots().map((QuerySnapshot query) {
      List<Employee> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Employee.fromJson(element));
        list.last.quotaHistory!.bindStream(
            QuotaHistoryRepo().quotaHistoryByEmployeeStream(element.reference));
        list.last.additionHistory!.bindStream(
            AdditionHistoryRepo().additionHistoryStream(element.reference));
        list.last.relative!.bindStream(
            RelativeRepo().relativeByEmployeeStream(element.reference));
        list.last.workHistory!.bindStream(
            WorkHistoryRepo().workHistoryByEmployeeStream(element.reference));
      });
      return list;
    });
  }

  Future<Employee> fetchUser(String uid) async {
    DocumentSnapshot documentReference =
        await _db.collection('employees').doc(uid).get();

    if (documentReference.exists) {
      return Employee.fromJson(documentReference);
    } else {
      print('USER REPO: Fecth user failed');
      return Employee(
        uid: '',
        name: '',
        additionHistory: null,
        workHistory: null,
        salary: 0,
        retirementDate: null,
        address: '',
        birthdate: null,
        folk: '',
        identityCard: '',
        quotaHistory: null,
        relative: null,
        sex: '',
        workDate: null,
      );
    }
  }

  Future<void> updateEmployee(Employee _employee) async {
    await _db
        .collection("employees")
        .doc("${_employee.uid}")
        .update(_employee.toMap());
    _employee.additionHistory!.forEach((element) async {
      if (element.uid == "uid") {
        await _db
            .collection("employees")
            .doc("${_employee.uid}")
            .collection("additions")
            .add(element.toMap())
            .then((value) => element.uid = value.id);
      } else {
        await _db
            .collection("employees")
            .doc("${_employee.uid}")
            .collection("additions")
            .doc("${element.uid}")
            .update(element.toMap());
      }
    });
    _employee.relative!.forEach((element) async {
      if (element.uid == "uid") {
        await _db
            .collection("employees")
            .doc("${_employee.uid}")
            .collection("relatives")
            .add(element.toMap())
            .then((value) => element.uid = value.id);
      } else {
        await _db
            .collection("employees")
            .doc("${_employee.uid}")
            .collection("relatives")
            .doc("${element.uid}")
            .update(element.toMap());
      }
    });
    _employee.quotaHistory!.forEach((element) async {
      if (element.uid == "uid") {
        await _db
            .collection("employees")
            .doc("${_employee.uid}")
            .collection("quotaHistories")
            .add(element.toMap());
      } else {
        await _db
            .collection("employees")
            .doc("${_employee.uid}")
            .collection("quotaHistories")
            .doc("${element.uid}")
            .update(element.toMap());
      }
    });
    _employee.workHistory!.forEach((element) async {
      if (element.uid == "uid") {
        await _db
            .collection("employees")
            .doc("${_employee.uid}")
            .collection("workHistories")
            .add(element.toMap());
      } else {
        await _db
            .collection("employees")
            .doc("${_employee.uid}")
            .collection("workHistories")
            .doc("${element.uid}")
            .update(element.toMap());
      }
    });
  }

  Future<void> addEmployee(Employee _employee) async {
    // add basic information
    await _db
        .collection("employees")
        .add(_employee.toMap())
        .then((value) => _employee.uid = value.id);

    // add collections
    _employee.additionHistory!.forEach((element) async {
      await _db
          .collection("employees")
          .doc("${_employee.uid}")
          .collection("additions")
          .add(element.toMap())
          .then((value) => element.uid = value.id);
    });
    _employee.relative!.forEach((element) async {
      await _db
          .collection("employees")
          .doc("${_employee.uid}")
          .collection("relatives")
          .add(element.toMap())
          .then((value) => element.uid = value.id);
    });
    _employee.workHistory!.forEach((element) async {
      await _db
          .collection("employees")
          .doc("${_employee.uid}")
          .collection("workHistories")
          .add(element.toMap())
          .then((value) => element.uid = value.id);
    });
    _employee.quotaHistory!.forEach((element) async {
      await _db
          .collection("employees")
          .doc("${_employee.uid}")
          .collection("quotaHistories")
          .add(element.toMap())
          .then((value) => element.uid = value.id);
    });
  }
}
