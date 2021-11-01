import 'package:get/get.dart';
import 'package:staff_management/models/position.dart';
import 'package:staff_management/services/positionRepo.dart';

class PositionController extends GetxController {
  static PositionController instance = Get.find();

  RxList<Position> listPosition = <Position>[].obs;

  //get function
  List<Position> get listPositions => listPosition.value;

  @override
  void onInit() {
    super.onInit();
    listPosition.bindStream(PositionRepo().positionStream());
  }
}
