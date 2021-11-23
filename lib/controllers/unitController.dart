import 'package:get/get.dart';
import 'package:staff_management/models/unit.dart';
import 'package:staff_management/services/unitRepo.dart';

class UnitController extends GetxController {
  static UnitController instance = Get.find();

  RxList<Unit> _listUnit = <Unit>[].obs;

  //get function
  List<Unit> get listUnits => _listUnit.value;
  late List<String> listUnitName;

  @override
  void onInit() {
    super.onInit();
    _listUnit.bindStream(UnitRepo().unitStream());
  }

  void initListUnitName() {
    listUnitName = [];
    listUnits.forEach((element) => listUnitName.add(element.name));
  }
}
