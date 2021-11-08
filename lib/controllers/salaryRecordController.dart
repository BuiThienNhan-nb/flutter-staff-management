import 'package:get/get.dart';
import 'package:staff_management/models/salaryRecords.dart';
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
}
