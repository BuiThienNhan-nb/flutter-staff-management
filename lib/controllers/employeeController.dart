import 'package:get/get.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/services/additionRepo.dart';
import 'package:staff_management/services/employeeRepo.dart';
import 'package:staff_management/services/positionRepo.dart';
import 'package:staff_management/services/quotaRepo.dart';
import 'package:staff_management/services/unitRepo.dart';

class EmployeeController extends GetxController {
  static EmployeeController instance = Get.find();

  RxList<Employee> _listEmployee = <Employee>[].obs;

  //get function
  List<Employee> get listEmployees => _listEmployee.value;

  @override
  void onInit() {
    super.onInit();
    _listEmployee.bindStream(EmployeeRepo().employeeStream());
  }

  void retreiveDetailData() {
    listEmployees.forEach((item) {
      item.addition
          .bindStream(AdditionRepo().additionByEmployeeStream(item.addition));
      item.quotaHistories.bindStream(
          QuotaRepo().listQuotaByEmployeeStream(item.quotaHistories));
      item.workHistory.forEach((element) {
        element.position
            .bindStream(PositionRepo().positionByIdStream(element.positionId));
        element.unit.bindStream(UnitRepo().unitByIdStream(element.unitId));
      });
    });
    update();
  }
}
