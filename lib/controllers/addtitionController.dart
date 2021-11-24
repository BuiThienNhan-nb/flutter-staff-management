import 'package:get/get.dart';
import 'package:staff_management/models/addition.dart';
import 'package:staff_management/services/additionRepo.dart';

class AdditionController extends GetxController {
  static AdditionController instance = Get.find();

  RxList<Addition> _listAddition = <Addition>[].obs;

  //get function
  List<Addition> get listAdditions => _listAddition.value;
  late List<String> listAdditionName;

  @override
  void onInit() {
    super.onInit();
    _listAddition.bindStream(AdditionRepo().additionStream());
  }

  void initListAdditionName() {
    listAdditionName = [];
    listAdditions.forEach((element) => listAdditionName.add(element.content));
  }
}
